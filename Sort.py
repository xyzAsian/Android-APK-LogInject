#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os,sys
import json

def durationSort(method):
    return method['duration']

def numSort(method):
    return method['numberOfTimes']

def findIndex(list, duration=0, numberOfTimes=0):
    index = 0
    for x in list :
        if duration >0 and x['duration'] < duration:
            return index;
        if numberOfTimes >0 and x['numberOfTimes'] < numberOfTimes:
            return index;
        index += 1

if __name__ == '__main__':
    currentDir = os.path.abspath('.')
    inLogFile = os.path.abspath(sys.argv[1])
    if not os.path.exists(inLogFile):
        print("%s file not exist!"%(inLogFile))
    else:
        listLogs=[]
        with open(inLogFile, "r+") as log:
            for line in log.readlines():
                line = line.replace("'","\"")
                # print(line)
                item = json.loads(line)
                item['className'] = item['className'].replace('/','.')[1:-1]
                listLogs.append(item)
            log.close()
        
        listLogs.sort(key=durationSort, reverse=True)
        index = findIndex(listLogs, duration=500)
        classNames = [ x['className'][0: x['className'].find('$') if x['className'].find('$') >= 0 else len(x['className'])] for x in listLogs[0:index]]

        baseName = os.path.basename(inLogFile)
        logDir = os.path.dirname(inLogFile)
        with open("%s/duration_%s"%(logDir, baseName), "w") as durationLog:
            durationLog.write('\n'.join( x for x in list(set(classNames))))
            durationLog.write('\n'.join( json.dumps(x) for x in listLogs))
            durationLog.flush()
            durationLog.close()

        listLogs.sort(key=numSort, reverse=True)
        index = findIndex(listLogs, numberOfTimes=1000)
        classNames = [ x['className'][0: x['className'].find('$') if x['className'].find('$') >= 0 else len(x['className'])] for x in listLogs[0:index]]
        with open("%s/numberOfTimes_%s"%(logDir, baseName), "w") as numLog:
            numLog.write('\n'.join( x for x in list(set(classNames))))
            numLog.write('\n'.join( json.dumps(x) for x in listLogs))
            numLog.flush()
            numLog.close()