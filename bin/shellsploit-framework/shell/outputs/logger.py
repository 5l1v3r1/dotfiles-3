#------------------Bombermans Team---------------------------------# 
#Author  : B3mB4m
#Concat  : b3mb4m@protonmail.com
#Project : https://github.com/b3mb4m/Shellsploit
#LICENSE : https://github.com/b3mb4m/Shellsploit/blob/master/LICENSE
#------------------------------------------------------------------#

from random import randint
import os

def logs(  data=None, extension=None):
	while True:
		if extension == None:
			name = "{0}".format(str(randint(0, 999999999)))
		else:
			name = "{0}.{1}".format(str(randint(0, 999999999)),extension)

		if not os.path.isfile(name):
			break

	if extension == None:
		logs = open(name, "wb")
	else:
		logs = open(name, "w")
		
	logs.write(data)
	logs.close()
	if extension != None:
		print ("\n\t[+]Script file : {0} saved !\n".format(os.getcwd()+os.sep+name))
	else:
		print ("\n\t[+]Executable file : {0} saved !\n".format(os.getcwd()+os.sep+name))

