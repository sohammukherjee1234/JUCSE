import React, { Component } from 'react'
import '../App.css';
export default class OthersChat extends Component {
    render() {
        return (
            <div className="otherchat">
                <h5 className="idother">{this.props.message.username}</h5>
                {this.props.message.message}
                 </div>
        )
    }
}
