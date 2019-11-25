import React, { Component } from 'react'
import {Modal, Button, InputGroup, FormControl, Form} from "react-bootstrap";
 const channelList = [
   {label: "JU", value: 1},
   {label: "Public", value: 2}
 ]



export default class LoginModal extends Component {

    constructor(props){
        super(props);
        this.state = {
            show: true,
            name:""
        };
        this.handleClose = this.handleClose.bind(this);
        this.handleNameChange = this.handleNameChange.bind(this);
        this.handleChannelChange = this.handleChannelChange.bind(this);
        this.textInput = React.createRef();
        this.channelName = React.createRef();
        
    }

    handleClose() {

       this.props.handleChange(this.textInput.current.value, this.channelName.current.value);
       this.setState({show: false});
    }

    handleChannelChange(){
      console.log(this.channelName.current.value);
    }

    handleNameChange(){
       console.log(this.textInput.current.value);
    }

    render() {
        return (
            <div>
                 <Modal show={this.state.show} onHide={() => {}}>
        <Modal.Header closeButton>
          <Modal.Title>Enter Details</Modal.Title>
        </Modal.Header>
        <Modal.Body>
        <InputGroup className="mb-3">
            <InputGroup.Prepend>
            <InputGroup.Text id="basic-addon1">@</InputGroup.Text>
            </InputGroup.Prepend>
            <FormControl
                placeholder="Username"
                aria-label="Username"
                aria-describedby="basic-addon1"
                ref={this.textInput}
            />
        </InputGroup>

        <Form.Group controlId="exampleForm.ControlSelect1">
        <Form.Label>Select Channel</Form.Label>
        <Form.Control as="select" ref={this.channelName}>
            <option>JU</option>
            <option>Public</option>
          </Form.Control>
        </Form.Group>
      
        </Modal.Body>
        <Modal.Footer>
          <Button variant="primary" onClick={this.handleClose}>
            Submit
          </Button>
        </Modal.Footer>
      </Modal>
            </div>
        )
    }
}
