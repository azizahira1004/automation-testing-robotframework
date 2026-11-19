*** Keywords ***
Kill Appium
  ${is_appium_exist}=    Run Keyword And Return Status    Variable Should Exist    ${APPIUM_INSTANCE}
  Run Keyword If    '${REMOTE_SELENIUM}' == 'false' and ${is_appium_exist}    Terminate Process    ${APPIUM_INSTANCE}    kill=true

Close Appium Server
  Terminate Process            ${APPIUM_INSTANCE}    kill=True

Reset App State Fast
    [Documentation]    Membersihkan data aplikasi via ADB dan membuka ulang aplikasi tanpa mematikan Appium Server.
    Run Process    ${ADB_PATH}    shell    pm    clear    ${APP_PACKAGE}
    Activate Application    ${APP_PACKAGE}

Close Application After Test
    Run Keyword And Ignore Error    Capture Page Screenshot
    Run Keyword And Ignore Error    Close Application

Terminate Mobile App And Close Session
    IF    '${TEST STATUS}' == 'FAIL'
        Run Keyword And Continue On Failure    Capture Page Screenshot
    END
    Run Keyword And Continue On Failure    Terminate Application    ${APP_PACKAGE}
    Close Application
