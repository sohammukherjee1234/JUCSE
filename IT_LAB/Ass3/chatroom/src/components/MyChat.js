import React, { Component } from 'react'
import '../App.css';
export default class MyChat extends Component {
    render() {
        return (
            <div className="mychat">
                <h5 className="idmy">{this.props.message.username}</h5>
                {this.props.message.message}
            </div>
        )
    }
}
