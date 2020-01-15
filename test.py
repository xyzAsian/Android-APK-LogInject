#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os,sys
import re
import hashlib
import commands

from inject import *

if __name__ == '__main__':
    currentDir = os.path.abspath('.')
    toolsDir = currentDir + "/tools/linux"
    workspace = currentDir +"/workspace"
    inApk = sys.argv[1]
    if len(sys.argv) >= 3 :
        execfile(sys.argv[2])
    else :
        config = {'data_statistics':{'func_filter':[]}}
    Packer(currentDir, toolsDir, inApk, workspace, config, isTest = True).inject('/home/yazhou/DataStatictis/test/input/EVehicleLatLng.smali','/home/yazhou/DataStatictis/test/output/')