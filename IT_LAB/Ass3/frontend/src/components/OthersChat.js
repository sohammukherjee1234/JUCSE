import React, { Component } from 'react'
import '../App.css';
export default class OthersChat extends Component {
  
    showMessage(msg){
        return (
            {msg}
        );
    }

    showImage(msg){
        return (
            <img src={`data:image/jpeg;base64,${msg}`} />
        );
    }



    render() {
        return (
            <div className="otherchat">
                <h5 className="idother">{this.props.message.username}</h5>
                {this.props.message.messageType === "image" ? this.showImage(this.props.message.message) : this.showMessage(this.props.message.message)}
                 </div>
        )
    }
}
