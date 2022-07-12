#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os,sys
import json

def durationSort(method):
    return method['duration']

def numSort(method):
    return method['numberOfTimes']

if __name__ == '__main__':
    currentDir = os.path.abspath('.')
    inLogFile = os.path.abspath(sys.argv[1])
    if not os.path.exists(inLogFile):
        print("%s file not exist!"%(inLogFile))
    else:
        list=[]
        with open(inLogFile, "r+") as log:
            for line in log.readlines():
                line = line.replace("'","\"")
                # print(line)
                list.append(json.loads(line))
            log.close()
        
        list.sort(key=durationSort, reverse=True)

        baseName = os.path.basename(inLogFile)
        logDir = os.path.dirname(inLogFile)
        with open("%s/duration_%s"%(logDir, baseName), "w") as durationLog:
            durationLog.write('\n'.join( json.dumps(x) for x in list))
            durationLog.flush()
            durationLog.close()

        list.sort(key=numSort, reverse=True)
        with open("%s/numberOfTimes_%s"%(logDir, baseName), "w") as numLog:
            numLog.write('\n'.join( json.dumps(x) for x in list))
            numLog.flush()
            numLog.close()