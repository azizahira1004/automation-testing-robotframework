import os
import re

class android_emulator(object):
    def kill(self):
        os.system('ps -ax > all_process.txt')
        file=open("all_process.txt",'r')
        content = file.read()
        file.close()
        os.system('sudo rm -f all_process.txt')
        pid = re.findall(r'emulator(?:\w|-|\s)*-ppid\s(\d*)\s',content)
        for item in pid:
            os.system('sudo kill {}'.format(item))

if __name__ == '__main__':
    emu = android_emulator()
    emu.kill()
