#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Sep  9 09:44:26 2019

@author: soham
"""

import asyncio
import websockets

addr = '127.0.0.1'
port = 1601

cmds = ['get','put','upgrade', 'demote', 'exit']
num_cmd = 5


def arg_verifier(key, value):

    if key == "get":
        if len(value.split(' '))>1:
            return "get takes exactly one argument"
        elif value in cmds:
            return "value cannot be a keyword"
        else:
            return "ok"
    elif key == "put":
        data = value.split(' ')
        for entity in data:
            if entity in cmds:
                return "value cannot be a keyword"
        return "ok"
    elif key == "upgrade" or key == "demote" or key == "exit" :
        if len(value)>0:
            return key+" doesn't expect an argument"
        else:
            return "ok"

    
        

async def hello():
    uri = "ws://"+addr+":"+str(port)
    async with websockets.connect(uri) as websocket:
        while True:
            if not websocket.open:
                print("Websocket not open. Trying to reconnect")
                websocket = await websockets.connect(uri)
            user = str(input('>>Enter user name : '))
            await websocket.send(user)
            ans = await websocket.recv()
            if ans == 'success':
                print('user connected to server')
                break
            else:
                print(ans)
        while True:
            if not websocket.open:
                print("Websocket not open. Trying to reconnect")
                websocket = await websockets.connect(uri)
            inp = str(input(">>"))
            words = inp.split(' ')
            if words[0] in cmds:
                data = ""
                for itr in range(1,len(words)):
                    data += words[itr] + " "
                data = data[:-1]

                is_arg = arg_verifier(words[0], data)
                if is_arg == "ok":
                    await websocket.send(inp)
                    reply = await websocket.recv()
                    print(reply)
                    if words[0] == "exit":
                        break
                else:
                    print(is_arg)
            else:
                print("wrong command")
            
			
asyncio.get_event_loop().run_until_complete(hello())