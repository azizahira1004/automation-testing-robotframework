*** Variables ***
${ADB_PATH}    C:\\Android\\platform-tools\\adb.exe
${NPX_PATH}    C:\\nodejs\\npx.cmd

*** Keywords ***
Spawn Appium Server
    ${APPIUM_INSTANCE}            Start Process    ${NPX_PATH}
    ...                           appium
    ...                           -p                  ${PORT}
    ...                           --base-path         /wd/hub
    ...                           stdout=${EXECDIR}/appium-log.txt
    ...                           stderr=STDOUT
    ...                           shell=True
    ...                           env:ANDROID_HOME=C:\\Android
    ...                           env:ANDROID_SDK_ROOT=C:\\Android
    ...                           alias=Phone
    Set Suite Variable            ${APPIUM_INSTANCE}
    Wait Until Appium Ready       ${PORT}     40

Open App
    Run Process    ${ADB_PATH}    shell    pm    clear    ${APP_PACKAGE}    shell=True
    Open Application             ${APPIUM_SERVER}
    ...                          udid=${UDID}
    ...                          skipLogcatCapture=${True}
    ...                          platformName=Android
    ...                          deviceName=emulator-5554
    ...                          appPackage=${APP_PACKAGE}
    ...                          appActivity=${APP_ACTIVITY}
    ...                          appWaitActivity=${APP_WAIT_ACTIVITY}
    ...                          alias=Phone
    ...                          newCommandTimeout=${15000}
    ...                          noReset=${True}
    ...                          dontStopAppOnReset=${True}
    ...                          skipDeviceInitialization=${True}
    ...                          skipServerInstallation=${True}
    ...                          automationName=UiAutomator2
    ...                          disableWindowAnimation=${True}
    ...                          waitForIdleTimeout=${0}
    ...                          uiautomator2ServerInstallTimeout=${90000}
    ...                          adbExecTimeout=${90000}
    Wait Until Element Is Visible       accessibility_id=test-Username      timeout=15s
    
Open Mobile Device and App
  Spawn Appium Server
  setup.Open App

Idle for
  [Arguments]     ${time}
  Sleep           ${time}
