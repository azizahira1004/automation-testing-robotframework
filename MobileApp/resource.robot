*** Settings ***
Library     AppiumLibrary      ${DEFAULT_TIMEOUT}    run_on_failure=No Operation
Library     Process
Library     Collections
Library     String
Library     OperatingSystem
Library     FakerLibrary
Library     DateTime

Resource    keywords/Pages/HomepagePages.robot
Resource    keywords/Logics/HomepageLogic.robot
Resource    keywords/Pages/LoginPagePages.robot
Resource    keywords/Logics/LoginLogic.robot
Resource    keywords/Pages/BurgerMenuPages.robot
Resource    keywords/Logics/BurgerMenuLogic.robot
Resource    keywords/Pages/FilterPages.robot
Resource    keywords/Logics/FilterLogic.robot
Resource    keywords/Pages/FooterPages.robot
Resource    keywords/Logics/FooterLogic.robot
Resource    keywords/Pages/ProductAndCartPages.robot
Resource    keywords/Logics/ProductAndCartLogic.robot
Resource    keywords/Pages/CheckoutPagePages.robot
Resource    keywords/Logics/CheckoutLogic.robot

Resource    externalLibrary/_LIBRARY_IMPORT.robot
Resource    test_data.robot
Resource    setup.robot
Resource    teardown.robot

*** Variables ***
${APPIUM_SERVER}            http://localhost:4729/wd/hub
${UDID}                     emulator-5554
${PORT}                     4729
${BOOTSTRAP_PORT}           50009
${API_TOKEN}
${APP_PACKAGE}              com.swaglabsmobileapp
${APP_ACTIVITY}             com.swaglabsmobileapp.MainActivity
${APP_WAIT_ACTIVITY}        com.swaglabsmobileapp.*
${VIRTUAL_DISPLAY}          False
${REMOTE_SELENIUM}          false
${APP_PATH}                 ${CURDIR}${/}app${/}saucelabs-sample-v2.5.0.apk
${SELENIUM_HOST}            localhost
${SELENIUM_PORT}            4444

# Timeout variable
${TURBO_TIMEOUT}            1
${FAST_TIMEOUT}             3
${MIDDLE_TIMEOUT}           5
${MEDIUM_TIMEOUT}           10
${DEFAULT_TIMEOUT}          20
${LONG_TIMEOUT}             45
