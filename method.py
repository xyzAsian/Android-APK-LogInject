# -*- coding: utf-8 -*-

BASIC = ('Z','B','S','C','I','J','F','D')
BASIC_NO_JD = ('Z','B','S','C','I','F')
# V=void Z=boolean B=byte S=short C=char I=int J=long F=float D=double
END = ('Z','B','S','C','I','J','F','D',';')
START = ('Z','B','S','C','I','J','F','D','L','[')
JD = ('J','D')

class Method(object):
    """docstring for Method"""
    def __init__(self, className, methodBuf, prefix, paramBuf = '', annotationBuf = ''):
        self.className = className
        self.methodBuf = methodBuf
        self.prefix = prefix
        self.inParam = False
        self.paramBuf = paramBuf
        self.inAnnotation = False
        self.annotationBuf = annotationBuf

        self.methodName = self.methodBuf[self.methodBuf.rfind(' ')+1:].strip()
        self.params = self.methodName[self.methodName.find('(')+1:self.methodName.rfind(')')]

        self.METHOD_IN = '''
    const-string v0, "%s"
    const-string v1, "%s"
    const/16 v2, %#x
    invoke-static {v0, v1, v2}, Lbangcle/log/DataStatistics;->methodIn(Ljava/lang/String;Ljava/lang/String;I)V
'''
        self.METHOD_OUT = '''
    const-string v0, "%s"
    const-string v1, "%s"
    const/16 v2, %#x
    invoke-static {v0, v1, v2}, Lbangcle/log/DataStatistics;->methodOut(Ljava/lang/String;Ljava/lang/String;I)V
'''


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

    def totalBuf(self):
        buf = ''
        size = self.parseRegistersCount(self.params.strip())
        _ori_size = size
        # 复制原始的方法
        buf += '\n\n'
        buf += self.methodBuf
        buf += '    .registers '+str(size+5)+'\n'
        if self.paramBuf:
            buf += self.paramBuf
        if self.annotationBuf:
            buf += self.annotationBuf
        buf += '\n'
        buf += self.METHOD_IN%(self.className, self.methodName, _ori_size)
        buf += '\n'
        _invoke = ''
        _param = ''
        _start = 0
        _range = ''
        if size >= 5:
            _range = '/range'

        if ' static ' in self.methodBuf :
            _invoke = '    invoke-static%s '%_range
        else:
            if ' private ' in self.methodBuf :
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
        buf += (_invoke+'{'+_param+'}, '+self.className+"->_"+self.prefix+"_"+self.methodName+'\n')

        if self.methodBuf.strip().endswith(')V') :
            buf += ('    '+(self.METHOD_OUT%(self.className, self.methodName, _ori_size)))
            buf += '\n    return-void'
        else :
            no_basic = self.methodBuf.strip()
            for c in BASIC:
                no_basic = no_basic.replace(c,'')
                pass
            if self.methodBuf.strip().endswith(BASIC_NO_JD) and not no_basic.endswith('['):
                buf += '\n    move-result v3\n\n'
            elif self.methodBuf.strip().endswith(JD) and not no_basic.endswith('['):
                buf += '\n    move-result-wide v3\n\n'
            else :
                buf += '\n    move-result-object v3\n\n'
            buf += ('    '+(self.METHOD_OUT%(self.className, self.methodName, _ori_size)))
            if self.methodBuf.strip().endswith(BASIC_NO_JD) and not no_basic.endswith('['):
                buf += '\n\n    return v3'
            elif self.methodBuf.strip().endswith(JD) and not no_basic.endswith('['):
                buf += '\n    return-wide v3\n\n'
            else:
                buf += '\n\n    return-object v3'
        buf += '\n.end method\n\n'

        return buf