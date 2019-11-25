import React, { Component } from 'react';
import 'bootstrap/dist/css/bootstrap.min.css';
import LoginModal from './components/LoginModal';
import ChatPage from './components/ChatPage';
import socketIOClient from "socket.io-client";
import './App.css';

let socket;


export default class App extends Component {

  constructor(props){
    super(props);
    this.state = {
      username: null,
      group: null,
      endpoint: "http://192.168.0.14:3005",
      messages: []

    };
    socket = socketIOClient(this.state.endpoint);
    this.handleChange = this.handleChange.bind(this);
    this.handleSendUsername = this.handleSendUsername.bind(this);
    this.handleSendMessage = this.handleSendMessage.bind(this);
    this.newMessage = this.newMessage.bind(this);
  }

  newMessage(msg){
    const messages = [...this.state.messages];
    if(messages === null) messages = [msg];
    else messages.push(msg)
    this.setState({messages: messages});
  }
  
  componentDidMount(){
    socket.on("new_message", this.newMessage);
  }

  componentWillUnmount(){
    socket.off("new_message");
  }

  handleSendUsername(){

    socket.emit("new_user", this.state.username);
  }

  handleSendMessage(msg){
    const data = {
      "message": msg,
      "group": this.state.group,
      "username": this.state.username
    };

    socket.emit("send_message", data);
  }

  handleChange(userName, lobby){
    this.setState({username: userName, group: lobby}, () => {this.handleSendUsername()});
  }

  render() {
    return (
      <div className="main-page">
        <ChatPage 
        username={this.state.username} 
        group={this.state.group} 
        messages={this.state.messages}
        handleSend={this.handleSendMessage}/>
        <LoginModal handleChange={this.handleChange}/>
      </div>
    )
  }
}


