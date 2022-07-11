#!/usr/local/bin/python3.8

import os
import logging

def initlog(logfile, file_handler=False, strean_handler=True):    
    log = logging.getLogger()
    if log.handlers:
        for item in log.handlers:
            log.removeHandler(item)
    #
    if file_handler:
        handler = logging.FileHandler(logfile)
        formatter = logging.Formatter('%(asctime)s %(message)s','%Y-%m-%d,%H:%M:%S')
        handler.setFormatter(formatter)
        log.addHandler(handler)
    #
    if strean_handler:
        handler1 = logging.StreamHandler()    
        formatter1 = logging.Formatter('%(levelname)s %(asctime)s %(message)s', '%y-%m-%d %H:%M:%S')
        handler1.setFormatter(formatter1)
        log.addHandler(handler1)

    log.setLevel(logging.NOTSET)
    return log

LOG = initlog("%s/log.log"%(os.path.abspath('.')))