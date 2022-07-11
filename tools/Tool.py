#!/usr/bin/python3.8

import os,sys
from tools.Log import LOG
import subprocess

class bcolors:
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'


def execute_cmd(cmd,log=True,allow_fail=False, status=True):
    a, b = subprocess.getstatusoutput(cmd)
    if log:
        print('excute %d:%s'%(a,cmd))
    if a!=0 and not allow_fail:
        print ('\n  ***  execute fail:%d,%s,%s\n' % (a,cmd,b))
        raise Exception('\n  ***  execute fail:%d,%s,%s\n' % (a,cmd,b));
    if status:
        return a,b
    else:
        return b

def exec_command(cmd, log=False, allow_fail=False, status=False, allow_waring=True, doing=True, pexception=False):
    if log :
        LOG.info("Begin exec %s"%cmd)

    a = 0
    b = ""
    try:
        a,b = subprocess.getstatusoutput(cmd)
        if a != 0 :
            if not allow_fail:
                print("exec fail :\n%s%s%s\n%s"%(bcolors.FAIL, cmd, bcolors.ENDC, b))
                exit()
            elif allow_waring:
                print("Waring : \n%s%s%s\n"%(bcolors.FAIL, cmd, bcolors.ENDC))
        elif a == 0 and doing:
            print("%sexec %s success%s"%(bcolors.OKGREEN, cmd, bcolors.ENDC))
    except Exception as e:
        if not allow_fail:
            print("exec fail :\n%s%s%s"%(bcolors.FAIL, cmd, bcolors.ENDC))
            if pexception: print("%s"%(str(e)))
            raise Exception("exec failed")
        elif allow_waring:
            print("Waring : \n%s%s%s\n"%(bcolors.FAIL, cmd, bcolors.ENDC))
            if pexception: print("%s"%(str(e)))

    if status:
        return a,b
    else:
        return b

def output(function):
    def func(*args, **kwargs):
        print("----------------- %12s -----------------"%function.__name__)
        b = function(*args, **kwargs)
        print("%s%s%s\n"%(bcolors.OKBLUE, str(b), bcolors.ENDC))
        return b
    return func

def is_zip(zip_file):
    a1,b1 = exec_command("zipinfo %s"%(zip_file), status=True, allow_fail=True, allow_waring=False, doing=False)
    return a1 == 0

def is_dex(dex_file):
    with open(dex_file,"rb") as _dex:
        try:
            buf = _dex.read(6)
            left_num = 0
            for i in range(0,6):
                #print("i : %d"%(i))
                left_num = ( buf[i] << 8 * (5-i) ) | left_num
            #print("left_num : %d == 110386968408115"%left_num)
            return left_num == 110386968408115
        except Exception as identifier:
            raise identifier
        finally:
            _dex.close()

TOOL_DIR = os.path.dirname(__file__)

PLATFORM = "macos" if sys.platform.find("darwin") >=0 else "linux" if sys.platform.find("linux") >=0 else "windows" 

AAPT = "%s/%s/aapt"%(TOOL_DIR, PLATFORM)
APK_SIGNER = "%s/%s/apksigner"%(TOOL_DIR, PLATFORM)

# public
JKS = "%s/public/debug.jks"%(TOOL_DIR)

SMALI = "java -jar %s/public/smali-2.2.7.jar "%(TOOL_DIR)
BAKSMALI = "java -jar %s/public/baksmali-2.2.7.jar "%(TOOL_DIR)
AXML3="java -jar %s/public/axml3.jar"%(TOOL_DIR)
AXML_DEBUG="java -jar %s/public/axml_debug.jar"%(TOOL_DIR)
AXML_MINSDK="java -jar %s/public/axml-minsdk.jar"%(TOOL_DIR)
DEX_SPLIT="java -jar %s/public/fixmethod-all-2.3.jar"%(TOOL_DIR)
