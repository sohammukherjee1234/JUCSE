import React, { Component } from 'react'
import { InputGroup,FormControl,Button } from 'react-bootstrap';
import '../App.css';
export default class InputChat extends Component {

    constructor(props){
        super(props);
        
        this.textInput = React.createRef();
        this.handleSubmit = this.handleSubmit.bind(this);
        this.handleShow = this.handleShow.bind(this);
    }

    handleSubmit(){
        console.log(this.textInput.current.value);
        this.props.handleSend(this.textInput.current.value, "text");
        this.textInput.current.value = "";
    }

    handleShow(){
        this.props.handleShowModal();
    }

    render() {
        return (
            <div className="input">
                <div className="input-form">
                    <InputGroup>
                    <InputGroup.Prepend>
                    <InputGroup.Text className="prepend-message">Your Message</InputGroup.Text>
                    </InputGroup.Prepend>
                    <FormControl as="textarea" aria-label="Your Message" ref={this.textInput}/>
                    </InputGroup>
                </div>
            
                <Button  className="submit-button" variant="primary" onClick={this.handleSubmit}>
                    Send
                </Button>
                <Button className="submit-button" variant="primary" onClick={this.handleShow}>
                    Upload
                </Button>
            </div>
        )
    }
}
