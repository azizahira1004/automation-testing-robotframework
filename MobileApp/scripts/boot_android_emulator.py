import os
import re
import sys
import time
import subprocess

if len(sys.argv)==3:
    android_ver = sys.argv[1]
    n_device = int(sys.argv[2])
elif len(sys.argv)==2:
    android_ver = sys.argv[1]
    n_device = 1
else:
    os.system("echo WARNING")
    os.system("echo Please use this format:")
    os.system("echo python3 *path*/boot_android_emulator.py *android_ver*")
    os.system("echo or")
    os.system("echo python3 *path*/boot_android_emulator.py *android_ver* *n_device*")
    os.system("exit 1")

class android_emulator:
    def __init__(self):
        self.device = "tv_1080p"
        self.tag = "android-tv"
        self.abi = "x86"
        self.sdcard = "1024M"
        self.memory = "3096"
        self.set_package()
        self.set_name()
        self.count = 1

    def set_package(self):
        if str(android_ver) == "6":
            self.package = "system-images;android-23;android-tv;x86"
        elif str(android_ver) == "8":
            self.package = "system-images;android-27;android-tv;x86"
        elif str(android_ver) == "9":
            self.package = "system-images;android-28;android-tv;x86"
        elif str(android_ver) == "10":
            self.package = "system-images;android-29;android-tv;x86"
        else:
            os.system('echo "please set to env.ANDROID_VER to available version"')

    def set_name(self):
        self.name = []
        for i in range(n_device):
            self.name.append('Android_{}_1080'.format(android_ver, i+1))

    def create_avd(self, name):
        os.system('echo "==== Creating {} AVD ===="'.format(name))
        os.system('$ANDROID_HOME/cmdline-tools/tools/bin/avdmanager -s create avd --name "{}" --device "{}" --package "{}" --tag "{}" --abi "{}" --sdcard "{}" --force'.format(name, self.device, self.package, self.tag, self.abi, self.sdcard))
        os.system('echo "FINISH CREATING AVD"')
        os.system('$ANDROID_HOME/emulator/emulator -list-avds')

    def boot_avd(self, name):
        self.count = self.count + 1
        os.system('echo ""')
        os.system('echo "==== Booting {} ===="'.format(name))
        os.system('$ANDROID_HOME/emulator/emulator @{} -wipe-data -no-audio -no-snapshot -no-window -gpu swiftshader_indirect -memory {} &'.format(name,self.memory))
        os.system('echo "==== Waiting for emulator to be fully booted ===="')
        os.system('echo "*please ignore the first error: no devices/emulators found*"')
        time.sleep(20)
        self.retry_get_udid(self.count)
        file=open("android-tv/scripts/wait_emulator_fragment.txt",'r')
        start = file.readline().replace("\n","")
        end = file.readline().replace("\n","")
        file.close
        command = start + " " + self.udid + " " + end
        os.system(command)

    def get_udid(self, n):
        command = r"adb devices | awk 'FNR == " + str(n) + r" {print $1}'"
        udid_byte = subprocess.check_output(command, shell=True)
        self.udid = udid_byte.decode('utf-8').replace('\n','')

    def retry_get_udid(self, n):
        for i in range(5):
            os.system('echo "Percobaan ke {}"'.format(i))
            self.get_udid(n)
            if self.udid != "":
                os.system('echo "Udah dapet {}"'.format(self.udid))
                break
            time.sleep(20)

    def start_boot_process(self):
        for item in self.name:
            self.create_avd(item)
        for item in self.name:
            self.boot_avd(item)

if __name__ == '__main__':
    emu = android_emulator()
    emu.start_boot_process()
