import binascii

from .logger import logs

def RawFile( shellcode):
        sc = shellcode.replace("\\x", "")
        sc = binascii.unhexlify( sc )
	logs( sc, None)
