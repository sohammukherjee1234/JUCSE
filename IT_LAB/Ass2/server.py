#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Sep  9 09:34:41 2019

@author: soham
"""

import asyncio
import websockets

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

async def manage_client(websocket, path):
    while True:
        username = await websocket.recv()
        if username not in local_state_store.keys():
            local_state_store[username] = {}
        await websocket.send('success')
        print('User is now '+ username)
        break
	# async for data in websocket:

    while True:
        data = await websocket.recv()
        arr = data.split()
        if arr[0] == 'exit':
            await websocket.send('exiting')
            break
        
        elif arr[0] == 'put':
            data = ""
            for itr in range(2, len(arr)):
                data += arr[itr] + " "
            if len(arr) >= 3:
                local_state_store[username][arr[1]] = data
                if arr[1] not in global_state_store.keys():
                    global_state_store[arr[1]] = []
                global_state_store[arr[1]].append(data)
                await websocket.send('done')
            else:
                await websocket.send('wrong message format')

        elif arr[0] == 'get':
            if len(arr) == 2:
                if username not in managers:
                    if arr[1] in local_state_store[username].keys():
                        await websocket.send(local_state_store[username][arr[1]])
                    else:
                        await websocket.send("key not found")
                else:
                    if arr[1] in global_state_store.keys():
                        data = ""
                        for value in global_state_store[arr[1]]:
                            data += value + ", "
                        await websocket.send(data)
                    else:
                        await websocket.send("key not found")
        elif arr[0] == 'upgrade':
            message = promote(username)
            await websocket.send(message)
        elif arr[0] == 'demote':
            message = demote(username)
            await websocket.send(message)
        else:
            await websocket.send('wrong message format')


addr = "127.0.0.1"
port = 1601
start_server = websockets.server.serve(manage_client, addr, port, ping_interval = 1000, ping_timeout = 1000)
asyncio.get_event_loop().run_until_complete(start_server)
asyncio.get_event_loop().run_forever()
