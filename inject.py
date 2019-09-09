#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os, sys
import commands
import msgpack
import hashlib
import json

BASIC = ('Z','B','S','C','I','J','F','D')
BASIC_NO_JD = ('Z','B','S','C','I','F')
# V=void Z=boolean B=byte S=short C=char I=int J=long F=float D=double
END = ('Z','B','S','C','I','J','F','D',';')
START = ('Z','B','S','C','I','J','F','D','L','[')
JD = ('J','D')

def execute_cmd(cmd,log=True,allow_fail=False):
    a, b = commands.getstatusoutput(cmd)
    print a, b
    if log:
        print 'excute %d:%s'%(a,cmd)
    if a!=0 and not allow_fail:
        print '\n  ***  execute fail:%d,%s,%s\n' % (a,cmd,b)
        raise Exception('\n  ***  execute fail:%d,%s,%s\n' % (a,cmd,b));
    return a,b

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
    def __init__(self, currentDir, toolsDir, inApk, workspace, config):
        #
        self.currentDir = currentDir
        self.toolsDir = toolsDir
        self.inApk = inApk
        self.workspace = workspace
        self.config = config
        execute_cmd('rm -rf {0};mkdir -p {0}'.format(self.workspace))
        self.parse_axml()
        self.initConfig(self.config)
        self.METHOD_IN = '''
    const-string v0, "%s"
    const-string v1, "%s"
    invoke-static {v0, v1}, Lbangcle/log/DataStatistics;->methodIn(Ljava/lang/String;Ljava/lang/String;)V
'''
        self.METHOD_OUT = '''
    const-string v0, "%s"
    const-string v1, "%s"
    invoke-static {v0, v1}, Lbangcle/log/DataStatistics;->methodOut(Ljava/lang/String;Ljava/lang/String;)V
'''

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
        config['data_statistics']['filter'].append('com/google')
        config['data_statistics']['filter'].append('com/android')
        config['data_statistics']['filter'].append('com/alipay')
        config['data_statistics']['filter'].append('okio')
        config['data_statistics']['filter'].append('android/support')
        config['data_statistics']['filter'].append('com/facebook')
        config['data_statistics']['filter'].append('com/amap')
        config['data_statistics']['filter'].append('net/sqlcipher')
        config['data_statistics']['filter'].append('retrofit2/')
        config['data_statistics']['filter'].append('okhttp3/')
        config['data_statistics']['filter'].append('io/reactivex')
        config['data_statistics']['filter'].append('com/tencent/')
        config['data_statistics']['filter'].append('org/apache/')
        config['data_statistics']['filter'].append('com/bangcle/data/statistics')

        if config['data_statistics']['func_filter']:
            for item in config['data_statistics']['func_filter']:
                if item.startswith('!'):
                    config['data_statistics']['filter'].append(item[1:])
                else :
                    config['data_statistics']['func'].append(item)
                pass
        print json.dumps(config,indent=4,sort_keys=True)

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
            execute_cmd("find {0} -name DataStatistics.smali|xargs sed -i '0,/LOGPRINT/s/LOGPRINT/{1}/g'".format(smali_file_dir,"LOGPRINT_TRUE"))
        if self.config['log'].get('file',False):
            execute_cmd("find {0} -name DataStatistics.smali|xargs sed -i '0,/LOGFILE/s/LOGFILE/{1}/g'".format(smali_file_dir,"LOGFILE_TRUE"))

    def doInject(self) :
        dexess = [os.path.join(self.dexDir, name) for name in os.listdir(self.dexDir) if name.endswith('.dex')]
        #print dexess
        for dexFileFullPath in dexess:
            dexFileFullDir = dexFileFullPath[:-4]
            self.dexToSmali(dexFileFullPath, dexFileFullDir)
            if os.path.isdir(dexFileFullDir):
                print 'start inject %s'%dexFileFullPath
                for parent,dirnames,filenames in os.walk(dexFileFullDir):
                    for filename in filenames:
                        filepath = os.path.join(parent, filename).replace(dexFileFullDir+'/', '')
                        if self.isNeedInject(filepath):
                            #print filepath
                            self.inject(os.path.join(parent, filename), dexFileFullDir)
                        pass
                print 'finish inject %s'%dexFileFullPath
                # 将壳Application加入到classes.dex
                if dexFileFullPath.endswith('classes.dex') :
                    if not os.path.exists("%s/bangcle/"%dexFileFullDir):
                        execute_cmd("mkdir -p %s/bangcle/"%dexFileFullDir)
                    execute_cmd('cp -rf %s/../bangcle/app/ %s/bangcle/'%(self.toolsDir, dexFileFullDir))
                    if self.manifest.get('android:name',None):
                        newSuperClass = self.manifest.get('android:name',None).replace('.','/')
                        execute_cmd(("sed -i 's#.super Landroid/app/Application;#.super L"+newSuperClass[1:-1]+";#g' %s/bangcle/app/BangcleLogApplication.smali") % (dexFileFullDir))
                        execute_cmd(("sed -i 's#Landroid/app/Application;->#L"+newSuperClass[1:-1]+";->#g' %s/bangcle/app/BangcleLogApplication.smali") % (dexFileFullDir))

                a,b = self.smaliToDex(dexFileFullDir,self.outDir+dexFileFullPath.replace(self.dexDir,''),allow_fail = True)
                #a,b = execute_cmd('java -jar {0}/smali-2.2.7.jar a {1}/ -o {2}/{3}'.format(self.toolsDir, _classDir, self.outDir, _classDir.replace(self.dexDir,'')[1:]+'.dex'),allow_fail=True)
                if a != 0:
                    self.move_smali(dexFileFullPath,'%s/%s'%(self.dexDir,'classes%d'%(len([os.path.join(self.dexDir, name) for name in os.listdir(self.dexDir) if name.endswith('.dex')])+1)))
        #self.re_arrange_dex('%s/%s'%(self.dexDir,'classes%d'%(len(dexess)+1)))
        filess = os.listdir(self.outDir)
        filess.sort(cmp=lambda x,y:compare(x,y),reverse=True)
        execute_cmd('rm -f %s'%(filess[0]))
        execute_cmd('cp -rf %s/../bangcle/log/ %s/%s/bangcle/'%(self.toolsDir, self.dexDir, filess[0][:-4]))
        self.doLogSetting("%s/%s"%(self.dexDir, filess[0][:-4]))
        self.smaliToDex(self.dexDir+'/'+filess[0][:-4], self.outDir+'/'+filess[0])

    def doZip(self):
        execute_cmd('cd {0}/out;zip -r target_{1} classes*.dex;cd -'.format(self.workspace,self.inApk))
        #删除原有签名
        execute_cmd('zip -d {0}/out/{1} META-INF/*.MF META-INF/*.SF META-INF/*.RSA '.format(self.workspace,self.outApk))
        #重新签名
        execute_cmd('{0}/apksigner sign --ks {0}/../debug.jks --ks-key-alias debugkey --ks-pass pass:qwe123 --key-pass pass:qwe123 --out {1}/out/{2}_signed.apk {1}/out/{2}.apk'.format(self.toolsDir,self.workspace,self.outApk[:-4]))

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
        return int(execute_cmd("hexdump -n 100 -C %s | grep 00000050 | awk -F ' ' '{print $13$12$11$10}'"%dexpath, log=False),16)

    def smaliToDex(self, smalidir, outdex_path, minSdk=9, delsmali=False, log=True, allow_fail=False):
        if delsmali:
            return execute_cmd('java -jar %s/smali-2.2.7.jar a %s -o %s -a %s && rm -fr %s' % (self.toolsDir, smalidir, outdex_path, minSdk, smalidir), log,allow_fail)
        else:
            return execute_cmd('java -jar %s/smali-2.2.7.jar a %s -o %s -a %s' % (self.toolsDir, smalidir, outdex_path, minSdk), log,allow_fail)

    def dexToSmali(self, index_path, outdir, deldex=False, locals=False, log=True, allow_fail=False):
        uselocals = '-l' if locals else ''
        if deldex:
            return execute_cmd('java -jar %s/baksmali-2.2.7.jar d %s %s -o %s && rm %s' % (self.toolsDir, uselocals, index_path, outdir, index_path), log,allow_fail)
        else:
            return execute_cmd('java -jar %s/baksmali-2.2.7.jar d %s %s -o %s' % (self.toolsDir, uselocals, index_path, outdir),log,allow_fail)

    def move_smali(self,srcDexFile,desDexDir,method_len = 45000):
        #execute_cmd('mkdir -p %s'%(srcDexFile[:-4]))
        if not os.path.exists(desDexDir):
            execute_cmd("mkdir %s"%(desDexDir),allow_fail=True)
        execute_cmd('java -jar {0}/dex_split-1.0.jar -d {1} -o {2} -m {3}'.format(self.toolsDir,srcDexFile,desDexDir,method_len))
        self.smaliToDex(srcDexFile[:-4], self.outDir + srcDexFile.replace(self.dexDir,''))
        self.smaliToDex(desDexDir, desDexDir+'.dex')
        execute_cmd('cp -f %s %s'%(desDexDir+'.dex', self.outDir))

    def inject(self,absfilepath, fileDir):
        if absfilepath.endswith('.smali'):
            with open(absfilepath, 'r+') as file :
                buf = ''
                class_name = ''
                prefix = hashlib.md5(absfilepath.replace(fileDir,'').encode(encoding='UTF-8')).hexdigest()
                for line in file :

                    if line.startswith('.class') :
                        class_name = line[line.rfind(' ')+1:].strip()
                        buf += line

                    elif line.startswith('.method') and ' abstract ' not in line and ' native ' not in line:
                        if ' constructor ' in line :
                            buf += line
                        else :
                            method_name = line[line.rfind(' ')+1:].strip()

                            params = method_name[method_name.find('(')+1:method_name.rfind(')')]
                            size = self.parseRegistersCount(params.strip())
                            # 复制原始的方法
                            buf += line
                            buf += '    .registers '+str(size+4)+'\n\n'
                            buf += self.METHOD_IN%(class_name,method_name)
                            buf += '\n'
                            _invoke = ''
                            _param = ''
                            _start = 0
                            _range = ''
                            if size >= 5:
                                _range = '/range'

                            if ' static ' in line :
                                _invoke = '    invoke-static%s '%_range
                            else:
                                if ' private ' in line :
                                    _invoke = '    invoke-direct%s '%_range
                                else :
                                    _invoke = '    invoke-virtual%s '%_range
                                _param = 'p0'
                                _start = 1
                                size += 1
                                if _start < size :
                                    _param += ','

                            if size < 5+_start:
                                for x in xrange(_start,size):
                                    _param += ('p'+str(x))
                                    if x < size-1:
                                        _param += ','
                                    pass
                            else :
                                _param = 'p0 .. p'+str(size-1)
                            buf += (_invoke+'{'+_param+'}, '+class_name+"->_"+prefix+"_"+method_name+'\n')

                            if line.strip().endswith(')V') :
                                buf += ('    '+(self.METHOD_OUT%(class_name,method_name)))
                                buf += '\n    return-void'
                            else :
                                no_basic = line.strip()
                                for c in BASIC:
                                    no_basic = no_basic.replace(c,'')
                                    pass
                                if line.strip().endswith(BASIC_NO_JD) and not no_basic.endswith('['):
                                    buf += '\n    move-result v2\n\n'
                                elif line.strip().endswith(JD) and not no_basic.endswith('['):
                                    buf += '\n    move-result-wide v2\n\n'
                                else :
                                    buf += '\n    move-result-object v2\n\n'
                                buf += ('    '+(self.METHOD_OUT%(class_name,method_name)))
                                if line.strip().endswith(BASIC_NO_JD) and not no_basic.endswith('['):
                                    buf += '\n\n    return v2'
                                elif line.strip().endswith(JD) and not no_basic.endswith('['):
                                    buf += '\n    return-wide v2\n\n'
                                else:
                                    buf += '\n\n    return-object v2'
                            buf += '\n.end method\n\n'
                            buf += line.replace(method_name,'_'+prefix+'_'+method_name)
                    else :
                        buf += line

                file.seek(0)
                file.write(buf)

    def parseRegistersCount(self,params):
        count = 0
        if not params:
            return count
        _length = len(params.strip())
        new_index = 0
        for index in xrange(0,_length):
            if new_index >= _length:
                break
            if params[new_index].startswith(START):
                if params[new_index] == 'L':
                    new_index = params.strip().find(';',new_index,_length)
                    count += 1
                elif params[new_index] == '[':
                    if params[new_index+1] == 'L':
                        new_index = params.strip().find(';',new_index,_length)
                        count += 1
                    else:
                        for xx in xrange(new_index+1,_length):
                            if params[xx].startswith(BASIC):
                                new_index = xx
                                count += 1
                                break
                else:
                    count += 1
                    if(params[new_index].startswith(JD)):
                        count += 1
            new_index+=1
        pass
        return count

    def doAddLog4a(self) :
        self.log4aDir = self.currentDir+"/tools/log4a/"
        #add /tool/log4a/log4a.dex
        dexess = [os.path.join(self.dexDir, name) for name in os.listdir(self.dexDir) if name.endswith('.dex')]
        newClassName = "classes{0}.dex".format(str(len(dexess)+1))
        execute_cmd("cp -f %s/log4a.dex %s/%s"%(self.log4aDir,self.outDir,newClassName))
        execute_cmd("cd %s;zip -r %s %s;cd -"%(self.outDir,self.outApk,newClassName))
        #add /tool/log4a/lib/*.so
        libs = ['armeabi','armeabi-v7a','arm64-v8a','x86','x86_64']
        for lib in libs :
            a,b = execute_cmd("zipinfo %s/%s lib/%s/*"%(self.outDir, self.outApk,lib), allow_fail = True)
            if a == 0:
                # 成功
                if not os.path.exists("%s/lib/"%self.outDir):
                    execute_cmd("mkdir -p %s/lib/"%self.outDir)
                execute_cmd("cp -rf %s/lib/%s %s/lib/"%(self.log4aDir,lib,self.outDir))
        if not os.path.exists("%s/lib"%self.outDir):
            lib = 'armeabi-v7a'
            execute_cmd("mkdir -p %s/lib/%s"%(self.outDir,lib))
            execute_cmd("cp -rf %s/lib/%s %s/lib/"%(self.log4aDir,lib,self.outDir))
        execute_cmd("cd %s;zip -r %s lib/;cd -"%(self.outDir,self.outApk))
        #modify Application to init log4a
        execute_cmd('unzip -qo -P aaa %s AndroidManifest.xml -d %s/temp'%(self.inApk,self.workspace))
        execute_cmd('java -jar %s/axml_debug.jar %s/temp/AndroidManifest.xml %s/AndroidManifest.xml bangcle.app.BangcleLogApplication'%(self.toolsDir,self.workspace,self.outDir))
        execute_cmd("cd %s;zip -r %s AndroidManifest.xml;cd -"%(self.outDir,self.outApk))

    def parse_axml(self):
        execute_cmd('mkdir -p %s/temp/'%(self.workspace))
        a,b = execute_cmd("%s/aapt d badging %s 2>/dev/null |grep 'package: name='" % (self.toolsDir,self.inApk))
        self.pkgName = b.split("'")[1]
        execute_cmd("%s/aapt d xmltree %s  AndroidManifest.xml|sed 's/([^)]*)//g'|sed 's/android:name=\"\./android:name=\"%s\./g'> %s/temp/manifest.txt" % (self.toolsDir,self.inApk,self.pkgName,self.workspace))
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

        minSdkVersion = nn['manifest'][0]['uses-sdk'][0]['android:minSdkVersion']
        global MINSDK
        MINSDK = int(minSdkVersion, 16)

        application = self.manifest.get('android:name',None)
        if application:
            tk = application[1:-1].split('.')
            if len(tk) == 1:
                self.manifest['android:name'] = '"' + '.'.join(self.pkgName.split('.') + tk) + '"'

    def startInject(self):
        self.doUnzip()
        self.doInject()
        self.doAddLog4a()
        self.doZip()


if __name__ == "__main__":
    currentDir = os.path.abspath('.')
    toolsDir = currentDir + "/tools/linux"
    workspace = currentDir +"/workspace"
    inApk = sys.argv[1]
    if len(sys.argv) >= 3 :
        execfile(sys.argv[2])
    else :
        config = {'data_statistics':{'func_filter':[]},'log':{'print':False,'file':True}}
    Packer(currentDir, toolsDir, inApk, workspace, config).startInject()
    pass
