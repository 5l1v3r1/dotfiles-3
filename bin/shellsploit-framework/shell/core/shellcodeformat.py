import re

def prettyout( shellcode):
	data = shellcode.replace("\\x", "")
	db = []
	print ("\n")
	for x in [data[x:x+40] for x in range(0, len(data), 40)]:
		db = re.findall("..?", x)
		if data.endswith( x):
			print ('\t"\\x'+"\\x".join(db)+'"')
		else:
			print ('\t"\\x'+"\\x".join(db)+'"'+' +')
	print ("\n")
	
