import os
import requests

from robot.libraries.BuiltIn import BuiltIn
from time import sleep

class AppiumHelper(object):
    def __init__(self):
        self.cwd = os.getcwd()
        self.session = requests.session()

    def wait_until_appium_ready(self, port, timeout=40):
        started = False
        for i in range(int(timeout)):
            try:
                r = self.session.get("http://127.0.0.1:{}/wd/hub/status".format(port), timeout=2)
                if r.status_code == 200:
                    started = True
                    break
            except Exception:
                if os.path.exists("appium-log.txt"):
                    with open("appium-log.txt", "r", encoding="utf-8", errors="ignore") as file:
                        content = file.read()
                        if "Appium REST http interface listener started" in content or "sessionOverride: true" in content:
                            started = True
                            break
            sleep(1)

        if not started:
            BuiltIn().fail("Appium did not start after %s seconds" % timeout)
