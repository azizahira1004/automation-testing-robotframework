*** Keywords ***
Initialize ReqRes Session
    ${api_key}=    Get Environment Variable    REQRES_API_KEY
    Should Not Be Empty    ${api_key}    msg=Set the REQRES_API_KEY environment variable before running API tests.
    &{headers}=    Create Dictionary    x-api-key=${api_key}
    Create Session    reqres    ${BASE_URL}    headers=${headers}    verify=True

Get Users List
    ${response}=    GET On Session    reqres    /users    expected_status=200
    RETURN    ${response}

Create New User
    [Arguments]    ${name}    ${job}
    &{payload}=    Create Dictionary    name=${name}    job=${job}
    ${response}=    POST On Session    reqres    /users    json=${payload}    expected_status=201
    RETURN    ${response}

Get User Detail By ID
    [Arguments]    ${user_id}
    ${response}=    GET On Session    reqres    /users/${user_id}    expected_status=200
    RETURN    ${response}

Get User Detail By Name
    [Arguments]    ${first_name}
    ${response}=    GET On Session    reqres    /users    params=per_page=12    expected_status=200
    ${users}=       Set Variable    ${response.json()}[data]
    FOR    ${user}    IN    @{users}
        IF    '${user}[first_name]' == '${first_name}'
            RETURN    ${user}
        END
    END
    Fail    User dengan nama '${first_name}' tidak ditemukan dalam daftar.

Update User By ID
    [Arguments]    ${user_id}    ${name}    ${job}
    &{payload}=    Create Dictionary    name=${name}    job=${job}
    ${response}=    PUT On Session    reqres    /users/${user_id}    json=${payload}    expected_status=200
    RETURN    ${response}

Delete User By ID
    [Arguments]    ${user_id}
    ${response}=    DELETE On Session    reqres    /users/${user_id}    expected_status=204
    RETURN    ${response}