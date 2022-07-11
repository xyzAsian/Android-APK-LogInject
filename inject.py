#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os, sys
import subprocess
import msgpack
import zipfile
import hashlib
import json
import shutil
from tools.Tool import *

from method import *
from functools import cmp_to_key

def compare(x,y):
    if not x.endswith('.dex') and not y.endswith('.dex'):
        return 0
    elif x.endswith('.dex') and not y.endswith('.dex'):
        return 1
    elif not x.endswith('.dex') and y.endswith('.dex'):
        return -1
    else :
        xInt = x.replace('classes','').replace('.dex','')
        if xInt == '':
            xInt = 0
        yInt = y.replace('classes','').replace('.dex','')
        if yInt == '' :
            yInt = 0
        return int(xInt) - int(yInt)

class Packer(object):
    """docstring for Packer"""
    def __init__(self, currentDir, inApk, workspace, config, isTest = False):
        #
        self.currentDir = currentDir
        self.inApk = inApk
        self.workspace = workspace
        self.config = config
        self.mac_mach = "''" if PLATFORM=="macos" else ""
        if not isTest:
            #execute_cmd('rm -rf {0};mkdir -p {0}'.format(self.workspace))
            if os.path.exists(self.workspace):
                shutil.rmtree(self.workspace)
            os.makedirs(self.workspace)
            self.parse_axml()
            self.initConfig(self.config)

    def initConfig(self,config):
        if not config :
            config = {'data_statistics':{'func_filter':[]}}
        if not config['data_statistics']:
            config.setdefault('data_statistics',{})
        #存放需要做打桩的类
        config['data_statistics'].setdefault('func',[])
        #存放不需要打桩的类
        config['data_statistics'].setdefault('filter',[])
        #默认三方库不打桩
        '''
        config['data_statistics']['filter'].append('com/google')
        config['data_statistics']['filter'].append('com/android')
        config['data_statistics']['filter'].append('com/alipay')
        config['data_statistics']['filter'].append('com/alibaba')
        config['data_statistics']['filter'].append('com/taobao')
        config['data_statistics']['filter'].append('okio')
        config['data_statistics']['filter'].append('rx')
        config['data_statistics']['filter'].append('android/support')
        config['data_statistics']['filter'].append('com/facebook')
        config['data_statistics']['filter'].append('com/amap')
        config['data_statistics']['filter'].append('net/sqlcipher')
        config['data_statistics']['filter'].append('retrofit2/')
        config['data_statistics']['filter'].append('okhttp3/')
        config['data_statistics']['filter'].append('io/reactivex')
        config['data_statistics']['filter'].append('com/tencent/')
        config['data_statistics']['filter'].append('org/apache/')
        '''

        if config['data_statistics']['func_filter']:
            for item in config['data_statistics']['func_filter']:
                if item.startswith('!'):
                    config['data_statistics']['filter'].append(item[1:])
                else :
                    config['data_statistics']['func'].append(item)
                pass

    def doUnzip(self) :
        self.outApk = 'target_{0}'.format(self.inApk)
        self.outDir = '{0}/out'.format(self.workspace)
        execute_cmd('mkdir -p {2}; cp -f {0}/{1} {2}/{3}'.format(self.currentDir, self.inApk, self.outDir,self.outApk))
        self.dexDir = "{0}/dex".format(self.workspace)
        execute_cmd('mkdir -p {1}; unzip {0} classes*.dex -d {1}'.format(self.inApk, self.dexDir))

    def doLogSetting(self,smali_file_dir):
        if not self.config.get('log',None):
            self.config.setdefault('log',{'print':False,'file':True})
        if self.config['log'].get('print',False):
            execute_cmd("find {0} -name DataStatistics.smali|xargs sed -i {1} '0,/LOGPRINT/s/LOGPRINT/{2}/g'".format(smali_file_dir, self.mac_mach, "LOGPRINT_TRUE"))
        if self.config['log'].get('file',False):
            execute_cmd("find {0} -name DataStatistics.smali|xargs sed -i {1} '0,/LOGFILE/s/LOGFILE/{2}/g'".format(smali_file_dir, self.mac_mach, "LOGFILE_TRUE"))

    def prepareDex(self):
        isSplitAgain = False
        dexess = [os.path.join(self.dexDir, name) for name in os.listdir(self.dexDir) if name.endswith('.dex')]
        for dexFileFullPath in dexess:
            methodCount = self.methodIdCount(dexFileFullPath)
            if methodCount > 30000:
                isSplitAgain = True
                self.move_smali(dexFileFullPath, (len([os.path.join(self.dexDir, name) for name in os.listdir(self.dexDir) if name.endswith('.dex')])+1), int(methodCount/2))
        if isSplitAgain:
            self.prepareDex()

    def doInject(self) :
        dexess = [os.path.join(self.dexDir, name) for name in os.listdir(self.dexDir) if name.endswith('.dex')]
        #print dexess
        for dexFileFullPath in dexess:
            print("========================= %s start ========================="%(os.path.basename(dexFileFullPath)))
            dexFileFullDir = dexFileFullPath[:-4]
            self.dexToSmali(dexFileFullPath, dexFileFullDir)
            if os.path.isdir(dexFileFullDir):
                print('start inject %s'%dexFileFullPath)
                for parent,dirnames,filenames in os.walk(dexFileFullDir):
                    for filename in filenames:
                        filepath = os.path.join(parent, filename).replace(dexFileFullDir+'/', '')
                        if self.isNeedInject(filepath):
                            #print filepath
                            self.inject(os.path.join(parent, filename), dexFileFullDir)
                        pass
                print('finish inject %s'%dexFileFullPath)
                # 将壳Application加入到classes.dex
                if dexFileFullPath.endswith('classes.dex') :
                    if not os.path.exists("%s/xyz"%dexFileFullDir):
                        execute_cmd("mkdir -p %s/xyz"%dexFileFullDir)
                    execute_cmd('cp -rf %s/xyz/* %s/xyz/'%(TOOL_DIR, dexFileFullDir))
                    #execute_cmd('cp -rf %s/../xyz/log/ %s/xyz/'%(self.toolsDir, dexFileFullDir))
                    # self.doLogSetting(dexFileFullDir)
                    newSuperClass = self.manifest.get('android:name',None)
                    if newSuperClass:
                        newSuperClass = newSuperClass.replace('.','/')
                        execute_cmd(("sed -i %s 's#.super Landroid/app/Application;#.super L"+newSuperClass[1:-1]+";#g' %s/xyz/app/XyzLogApplication.smali") % (self.mac_mach, dexFileFullDir))
                        execute_cmd(("sed -i %s 's#Landroid/app/Application;->#L"+newSuperClass[1:-1]+";->#g' %s/xyz/app/XyzLogApplication.smali") % (self.mac_mach, dexFileFullDir))
                '''
                如果smali转dex失败，则move_smali
                '''
                self.smaliToDex(dexFileFullDir,self.outDir+dexFileFullPath.replace(self.dexDir,''),allow_fail = True)

    def doZip(self):
        execute_cmd('cd {0}/out && zip -r target_{1} classes*.dex;cd -'.format(self.workspace,self.inApk))
        #删除原有签名
        execute_cmd('zip -d {0}/out/{1} META-INF/*.MF META-INF/*.SF META-INF/*.RSA '.format(self.workspace,self.outApk), allow_fail=True)
        #重新签名
        execute_cmd('{0} sign --ks {3} --ks-key-alias debugkey --ks-pass pass:qwe123 --key-pass pass:qwe123 --out {1}/out/{2}_signed.apk {1}/out/{2}.apk'.format(APK_SIGNER,self.workspace,self.outApk[:-4], JKS))

    #是否需要做
    def isNeedInject(self,filepath) :
        if self.isInFunc(filepath) and not self.isInFilter(filepath):
            return True
        return False

    def isInFunc(self,filepath):
        if self.config['data_statistics']['func'] :
            for filterItem in self.config['data_statistics']['func']:
                if(filepath.startswith(filterItem)):
                    return True
        return True

    def isInFilter(self,filepath):
        if self.config['data_statistics']['filter'] :
            for funcItem in self.config['data_statistics']['filter']:
                if(filepath.startswith(funcItem)):
                    return True
        return False

    def methodIdCount(self,dexpath):
        print("hexdump -n 100 -C %s | grep 00000050 | awk -F ' ' '{print $13$12$11$10}'"%dexpath)
        methodsid = int(execute_cmd("hexdump -n 100 -C %s | grep 00000050 | awk -F ' ' '{print $13$12$11$10}'"%dexpath, log=False,      status=False), 16)
        fieldsid =  int(execute_cmd("hexdump -n 100 -C %s | grep 00000050 | awk -F ' ' '{print $5$4$3$2}'"%dexpath, log=False,          status=False), 16)
        stringids=  int(execute_cmd("hexdump -n 100 -C %s | grep 00000030 | awk -F ' ' '{print $13$12$11$10}'" % dexpath, log=False,    status=False), 16)
        typeIds=    int(execute_cmd("hexdump -n 100 -C %s | grep 00000040 | awk -F ' ' '{print $5$4$3$2}'"%dexpath, log=False,          status=False), 16)
        proto=      int(execute_cmd("hexdump -n 100 -C %s | grep 00000040 | awk -F ' ' '{print $13$12$11$10}'" % dexpath, log=False,    status=False), 16)
        
        LOG.info("%s methodIDs: %d fieldIDs: %d stringIDs: %d typeIDs: %d protoIDs: %d" % (os.path.basename(dexpath), methodsid, fieldsid, stringids, typeIds, proto))

        maxcount=max(methodsid, fieldsid)
        if(maxcount<65000):
            if max(typeIds,proto)>65000:
                raise Exception('\n  ***  execute fail (The number of DEX methodsid sringids, typeIds, proto exceeds 65000).%s,%d, %d,%d,%d\n'%(dexpath,methodsid,stringids, typeIds,proto));
            
        return maxcount

    def smaliToDex(self, smalidir, outdex_path, minSdk=9, delsmali=False, log=True, allow_fail=False):
        if delsmali:
            return execute_cmd('%s a %s -o %s -a %s && rm -fr %s' % (SMALI, smalidir, outdex_path, minSdk, smalidir), log,allow_fail)
        else:
            return execute_cmd('%s a %s -o %s -a %s' % (SMALI, smalidir, outdex_path, minSdk), log,allow_fail)

    def dexToSmali(self, index_path, outdir, deldex=False, locals=False, log=True, allow_fail=False):
        uselocals = '-l' if locals else ''
        if deldex:
            return execute_cmd('%s d %s %s -o %s && rm %s' % (BAKSMALI, uselocals, index_path, outdir, index_path), log,allow_fail)
        else:
            return execute_cmd('%s d %s %s -o %s' % (BAKSMALI, uselocals, index_path, outdir),log,allow_fail)

    def move_smali(self, srcDexFile, desDexDirIndex, methodMovCount):
        print("start move %s to %d"%(srcDexFile, desDexDirIndex))
        desDexOut = "%s/classes%d.dex"%(self.dexDir,desDexDirIndex)
        execute_cmd('{0} split-dex --input-dex "{1}" --out-dex "{2}" -ms {3}'.format(DEX_SPLIT, srcDexFile, desDexOut, methodMovCount), log = True)

    def inject(self,absfilepath, fileDir):
        if absfilepath.endswith('.smali'):
            with open(absfilepath, 'r+') as file :
                buf = ''
                class_name = ''
                prefix = hashlib.md5(absfilepath.replace(fileDir,'').encode(encoding='UTF-8')).hexdigest()
                currMeth = None
                for line in file :

                    if line.startswith('.class') :
                        class_name = line[line.rfind(' ')+1:].strip()
                        buf += line

                    elif line.startswith('.method') and ' abstract ' not in line and ' native ' not in line and ' attachBaseContext(' not in line and ' constructor ' not in line:
                            currMeth = Method(class_name, line, prefix)
                            buf += line.replace(currMeth.methodName,'_'+prefix+'_'+currMeth.methodName)
                    else :
                        buf += line
                        if currMeth and line.strip() and line.strip().startswith('.param ') and (len(line[:line.find(".")])==4):
                            currMeth.inParam = True
                            currMeth.paramBuf += line
                            continue
                        elif currMeth and line.strip() and currMeth.inParam :
                            #如果开头空格大于4个
                            if line.startswith('        '):
                                currMeth.paramBuf += line
                                continue
                            else:
                                currMeth.inParam = False
                            if line.strip().startswith('.end param'):
                                currMeth.paramBuf += line
                                continue

                        if currMeth and line.strip() and not currMeth.inParam and line.strip().startswith('.annotation ') and (len(line[:line.find(".")])==4):
                            currMeth.inAnnotation = True
                            currMeth.annotationBuf += line
                            continue
                        elif currMeth and line.strip() and not currMeth.inParam and currMeth.inAnnotation :
                            #如果开头空格大于4个
                            if line.startswith('        '):
                                currMeth.annotationBuf += line
                                continue
                            else:
                                currMeth.inAnnotation = False
                            if line.strip().startswith('.end annotation'):
                                currMeth.annotationBuf += line
                                continue

                        if currMeth and line.strip() and line.strip().startswith('.end method'):
                            buf += currMeth.totalBuf()
                            currMeth = None

                file.seek(0)
                file.write(buf)

    def doManifest(self) :
        #modify Application
        execute_cmd('unzip -qo -P aaa %s AndroidManifest.xml -d %s/temp'%(self.inApk,self.workspace))
        execute_cmd('%s %s/temp/AndroidManifest.xml %s/AndroidManifest.xml xyz.app.XyzLogApplication 21'%(AXML_MINSDK,self.workspace,self.outDir))
        # execute_cmd('java -jar %s/axml_debug.jar %s/temp/AndroidManifest.xml %s/AndroidManifest.xml xyz.app.XyzLogApplication'%(self.toolsDir,self.workspace,self.outDir))
        execute_cmd("cd %s;zip -r %s AndroidManifest.xml;cd -"%(self.outDir,self.outApk))

    def parse_axml(self):
        #execute_cmd('mkdir -p %s/temp/'%(self.workspace))
        os.makedirs("%s/temp/"%(self.workspace))
        a,b = execute_cmd("%s d badging %s 2>/dev/null |grep 'package: name='" % (AAPT,self.inApk))
        self.pkgName = b.split("'")[1]
        execute_cmd("%s d xmltree %s  AndroidManifest.xml > %s/temp/manifest.txt"%(AAPT, self.inApk, self.workspace))
        execute_cmd("sed -i %s 's#([^)]*)##g' %s/temp/manifest.txt" % (self.mac_mach, self.workspace))
        execute_cmd("sed -i %s 's#android:name=\".#android:name=\"%s.#g' %s/temp/manifest.txt"%(self.mac_mach, self.pkgName, self.workspace))
        nn = {}
        stack = [nn,nn]
        app = {}
        E = {}
        for line in open('%s/temp/manifest.txt'%self.workspace):
            try:
                k,v = line.split(': ',1)
                v = v.strip()
                if k[-1] == 'A':
                    kk,vv = v.split('=',1)
                    E[kk] = vv.strip()
                elif k[-1] == 'E':
                    E = app if v == 'application' else {}
                    stack = stack[:len(k)/2]
                    stack.append(E)
                    stack[-2].setdefault(v, []).append(E)
                    
            except:
                pass
        self.manifest = app

        #fix some ap has applicaton like as 'MyApp' or '.MyApp', not 'com.yimq.MyApp'
        application = self.manifest.get('android:name',None)
        if application:
            tk = application[1:-1].split('.')
            if len(tk) == 1:
                self.manifest['android:name'] = '"' + '.'.join(self.pkgName.split('.') + tk) + '"'

    def startInject(self):
        self.doUnzip()
        self.prepareDex();
        self.doInject()
        self.doManifest()
        self.doZip()
        print(json.dumps(self.config,indent=4,sort_keys=True))
        print("Not support Android4.x device!")


if __name__ == "__main__":
    currentDir = os.path.abspath('.')
    workspace = currentDir +"/workspace"
    inApk = sys.argv[1]
    if len(sys.argv) >= 3 :
        exec(open(sys.argv[2]).read())
    else :
        config = {'data_statistics':{'func_filter':[]}}
    Packer(currentDir, inApk, workspace, config).startInject()
    pass
