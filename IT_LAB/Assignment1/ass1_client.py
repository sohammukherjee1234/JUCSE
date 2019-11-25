#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Aug 19 10:04:34 2019

@author: soham
"""

import sys
import socket
from utils import get_host_port, free_ip


def argument_parser():
    args = []
    num_args = len(sys.argv)
    if num_args < 3:
        print("Please specify client identifier, hostname and port")
        sys.exit(1)
    client_identifier = int(sys.argv[1])

    hostname = sys.argv[2]
    port = int(sys.argv[3])

    
    curr_idx = 4
    while curr_idx < num_args:
        
        if sys.argv[curr_idx] == "put":
            if (curr_idx+1)>=num_args or (curr_idx+2)>=num_args:
                print("put takes atleast two arguments")
                sys.exit(1)
            elif sys.argv[curr_idx+1] == "get" or sys.argv[curr_idx+1] == "put":
                print("put takes atleast two arguments")
                sys.exit(1)
            elif sys.argv[curr_idx+2] == "get" or sys.argv[curr_idx+2] == "put":
                print("put takes atleast two arguments")
                sys.exit(1)
            else:
                argument = "put "
                curr_idx += 1
                while curr_idx<num_args and (sys.argv[curr_idx]!="put" and sys.argv[curr_idx]!="get"):
                    argument += sys.argv[curr_idx] + " "
                    curr_idx += 1
                args.append(argument)

        elif sys.argv[curr_idx] == "get":
            if (curr_idx+1)>=num_args:
                print("get takes exactly one argument")
                sys.exit(1)
                
            elif sys.argv[curr_idx+1] == "get" or sys.argv[curr_idx+1] == "put":
                print("get takes exactly one argument")
                sys.exit(1)
            else:
                args.append("get " + sys.argv[curr_idx+1])
                curr_idx+=2
        else:
            print("only get and put operations allowed")
            sys.exit(1)
    return (client_identifier, hostname, port, args)


def client_handler():
    arguments = argument_parser()
    print(arguments)
    client_identifier, hostname, port, args = arguments[0], arguments[1], arguments[2], arguments[3]
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    s.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
#        s.bind(('127.28.3.1', 65431))
    ip_det = get_host_port(client_identifier)
    print("User is now: ", ip_det)
    s.bind((ip_det[0], ip_det[1]))
    s.connect((hostname, port))
    print("connection successfull")
    for arg in args:
        s.sendall(arg.encode('utf-8'))
        data = s.recv(1024)
        if arg.split(' ')[0] == "get":
            print(data.decode('utf-8'))
    s.close()
    free_ip(ip_det[0])
    

if __name__ == "__main__":
    client_handler()   
    