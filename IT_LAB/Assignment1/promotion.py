#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Aug 26 11:57:17 2019

@author: soham
"""

import sys
import socket


def argument_parser():
    num_args = len(sys.argv)
    curr_idx = 1
    arguments = []
    while curr_idx < num_args:
        if sys.argv[curr_idx] == "promote":
            if curr_idx+1 >= num_args:
                print("promote takes exactly one argument")
                sys.exit(1)
            elif sys.argv[curr_idx+1] == "promote" or sys.argv[curr_idx+1] == "demote":
                print("promote takes exactly one argument")
                sys.exit(1)
            else:
                ip = sys.argv[curr_idx+1]
                arguments.append("promote "+ip)
                
        elif sys.argv[curr_idx] == "demote":
            if curr_idx+1 >= num_args:
                print("demote takes exactly one argument")
                sys.exit(1)
            elif sys.argv[curr_idx+1] == "promote" or sys.argv[curr_idx+1] == "demote":
                print("demote takes exactly one argument")
                sys.exit(1)
            else:
                ip = sys.argv[curr_idx+1]
                arguments.append("demote "+ip)
        else:
            print("only promote and demote keywords identified")
            sys.exit(1)
        curr_idx+=2
    
    return arguments


if __name__ == "__main__":
    args = argument_parser()
    hostname = "127.0.0.1"
    port = 65432
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    s.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
    s.connect((hostname, port))
    print("connection successfull")
    for arg in args:
        s.sendall(arg.encode('utf-8'))
        data = s.recv(1024)
        print(data.decode('utf-8'))
    s.close()

            