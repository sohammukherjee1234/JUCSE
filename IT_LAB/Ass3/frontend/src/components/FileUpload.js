import React, { Component } from 'react'
import FileDrop from 'react-file-drop';
import {Modal} from 'react-bootstrap';
export default class FileUpload extends Component {

    constructor(props){
        super(props);

        this.state = {
            show: false,
            
        }
        this.handleClose = this.handleClose.bind(this);
    }

    componentWillReceiveProps = (nextProps) => {
        if(nextProps.showModal !== this.state.show){
            this.setState({show: nextProps.showModal});
        }
    }

    handleDrop = (files, event) => {
        console.log(files[0]);
        this.props.handleSend(files[0], "image");
      }

      handleClose(){
          this.props.handleModalClose();

      }
    
      render() {
       
        return (
            <Modal show={this.state.show} onHide={this.handleClose}>
        <Modal.Header closeButton>
          <Modal.Title>Upload A File</Modal.Title>
        </Modal.Header>
        <Modal.Body>
        <div id="react-file-drop-demo" className="file-dropzone">
            <FileDrop onDrop={this.handleDrop}>
              Drop some files here!
            </FileDrop>
          </div>
        </Modal.Body>
      </Modal>

         
        );
      }
}
