#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Aug 19 10:30:26 2019

@author: soham
"""

import socket
import threading


global_state_store = {}
local_state_store = {}

managers = []

def promote(ip):
    global managers
    if ip not in managers:
        managers.append(ip)
        return "Promoted "+ ip+" to manager"
    else:
        return ip + " is already a manager"
    
def is_manager(ip):
    global managers
    if ip in managers:
        return True
    return False
    
def demote(ip):
    global managers
    if ip in managers:
        managers.remove(ip)
        return "Demoted " + ip +" to user"
    return ip+ " is not a manager"



def handle_newclient(connection, address):
    global global_state_store
    print("Connected to ", connection)
    peer_ip, peer_port = connection.getpeername()
    if peer_ip not in local_state_store.keys():
        local_state_store[peer_ip] = {}

    while True:
        data = connection.recv(1024).decode('utf-8')
        if not data:
            break
        data = data.split(' ')
        if data[0] == "put":
            key = data[1]
            value = ""
            for itr in range(2,len(data)-1):
                value += data[itr]+" "

            local_state_store[peer_ip][key] = value
            if key in global_state_store.keys():
                global_state_store[key].append(value)
            else:
                global_state_store[key] = [value]
            connection.sendall("Received data".encode('utf-8'))
        elif data[0] == "get":
            key = data[1]
            to_send = " "
            if is_manager(peer_ip):
                if key in global_state_store.keys():
                    to_send = ""
                    for data in global_state_store[key]:
                        to_send += data+" ,"
            else:
                if key  in local_state_store[peer_ip].keys():
                    to_send = ""
                    for data in local_state_store[peer_ip][key]:
                        to_send += data+" "
            connection.sendall(to_send.encode('utf-8'))
        elif data[0] == "promote":
            result = promote(data[1])
            connection.sendall(result.encode('utf-8'))
        else:
            result = demote(data[1])
            connection.sendall(result.encode('utf-8'))
                    
        


hostname = '127.0.0.1'
port = 65432

with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
    s.bind((hostname, port))
    s.listen()
    
    while True:
        conn, addr = s.accept()
        
        t = threading.Thread(target=handle_newclient, args=(conn, addr))
        t.start()
        t.join()
        
    
