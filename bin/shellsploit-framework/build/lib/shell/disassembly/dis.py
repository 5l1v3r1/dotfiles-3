from capstone import *
from binascii import hexlify



def disas(shellcode, bits=32):
    test = []
    ARCH = {
        'arm': CS_ARCH_ARM,
        'arm64': CS_ARCH_ARM64,
        'mips': CS_ARCH_MIPS,
        'ppc': CS_ARCH_PPC,
        'x86': CS_ARCH_X86,
        'xcore': CS_ARCH_XCORE
    }

    MODE = {
        '16': CS_MODE_16,
        '32': CS_MODE_32,
        '64': CS_MODE_64,
        'arm': CS_MODE_ARM,
        'be': CS_MODE_BIG_ENDIAN,
        'le': CS_MODE_LITTLE_ENDIAN,
        'micro': CS_MODE_MICRO,
        'thumb': CS_MODE_THUMB
    }


    if bits == 32:
        md = Cs(CS_ARCH_X86, CS_MODE_32)
    elif bits == 64:
        md = Cs(CS_ARCH_X86, CS_MODE_64)

    
    for i in md.disasm(shellcode, 0x10000000):
        if len(i.mnemonic) <= 3:
            db = "\t0x%x: %s\t\t%s\t\t%s" % (i.address, hexlify(i.bytes), i.mnemonic, i.op_str)
        else:
            db = "\t0x%x: %s\t%s\t%s" % (i.address, hexlify(i.bytes),  i.mnemonic, i.op_str)
        test.append(db)
    return "\n".join(test)





