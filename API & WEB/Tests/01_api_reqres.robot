*** Settings ***
Resource         ${EXECDIR}/resources.txt
Suite Setup      users_service.Initialize ReqRes Session

*** Test Cases ***
TC01 - Get List Users
    ${response}=    users_service.Get Users List
    ${json}=        Set Variable    ${response.json()}
    Should Not Be Empty    ${json}[data]

TC02 - Create User
    [Documentation]    
    ${response}=    users_service.Create New User    Ira Nurazizah    Test Engineer Specialist
    ${json}=        Set Variable    ${response.json()}
    Should Be Equal As Strings    ${json}[name]    Ira Nurazizah
    Should Be Equal As Strings    ${json}[job]     Test Engineer Specialist
    Should Not Be Empty           ${json}[id]

TC03 - Get User Detail by ID
    ${response}=    users_service.Get User Detail By ID    2
    ${json}=        Set Variable    ${response.json()}
    Should Be Equal As Integers    ${json}[data][id]    2

TC03B - Get User Detail By Name
    ${user}=    users_service.Get User Detail By Name    Janet
    Log To Console    \n[DEBUG USER FOUND] ${user}
    Should Be Equal As Integers    ${user}[id]            2
    Should Be Equal As Strings     ${user}[first_name]    Janet
    Should Be Equal As Strings     ${user}[last_name]     Weaver
    Should Be Equal As Strings     ${user}[email]         janet.weaver@reqres.in

TC04 - Update User
    ${response}=    users_service.Update User By ID    2    Ira Nurazizah    Lead QA Automation
    ${json}=        Set Variable    ${response.json()}
    Should Be Equal As Strings    ${json}[job]    Lead QA Automation
    Should Not Be Empty           ${json}[updatedAt]

TC05 - Delete User
    ${response}=    users_service.Delete User By ID    2
    Should Be Equal As Integers    ${response.status_code}    204
    Should Be Empty                ${response.text}