import React, { Component } from 'react'
import OthersChat from './OthersChat';
import MyChat from './MyChat';
import InputChat from './InputChat';
import FileUpload from './FileUpload';
import '../App.css';
export default class ChatPage extends Component {

    constructor(props){
        super(props);
        this.state = {
            username: null,
            group: "JU",
            messages: [],
            showModal: false
        };
        this.getChats = this.getChats.bind(this);
        this.handleShowModal = this.handleShowModal.bind(this);
        this.handleModalClose = this.handleModalClose.bind(this);
        this.handleFileUpload = this.handleFileUpload.bind(this);
    }

    componentWillReceiveProps = (nextProps) => {
      if(nextProps.messages.length !== this.state.messages.length || this.state.username !== nextProps.username){
          this.setState({
              username: nextProps.username,
              group: nextProps.group, 
              messages: nextProps.messages
          })
      }
    };
    

    getChats(element){
        return (
        element.username === this.state.username ? <MyChat message={element}/> : <OthersChat message={element} />
        );
    }

    handleShowModal(){
        this.setState({showModal: true});
    }

    handleModalClose(){
        this.setState({showModal: false});
    }

    handleFileUpload(file, ftype){
        this.props.handleSend(file, ftype);
        this.handleModalClose();
    }

    render() {
        return (
            <div className="chatpage">
                <div className="chatname">
                <h1>{this.state.group === null ? `Channel: JU` : `Channel: ${this.state.group}`}</h1>
                </div>
                <div className="main-chat">
               {(this.state.messages || [])
                                .filter((message) => {return message.group === this.state.group})
                                .reverse()
                                .map((element,index) => this.getChats(element))
               }
               </div>

               <InputChat handleSend={this.props.handleSend} 
                            handleShowModal={this.handleShowModal}/>
                <FileUpload 
                            handleSend={this.handleFileUpload} 
                            showModal={this.state.showModal}
                            handleModalClose = {this.handleModalClose} 
                            />
            </div>

        );
    }
}
