#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Aug 19 12:48:22 2019

@author: soham
"""


available_ips = {
                "127.0.0.3": 65431,
                "127.0.0.4": 65433,
                "127.39.28.2": 65435
                }
used_ips = {}

def get_host_port(client_identifier):
    global available_ips
    global used_ips
    
    ips = list(available_ips.keys())
    ip = ips[client_identifier]
    port = available_ips.pop(ip)
    used_ips[ip] = port
    return (ip, port)

def free_ip(ip):
    global used_ips
    global available_ips
    port = used_ips.pop(ip)
    available_ips[ip] = port


