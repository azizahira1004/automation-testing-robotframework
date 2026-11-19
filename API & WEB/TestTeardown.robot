*** Keywords ***
Capture Page If Test Failed
    ${browsers}=    Get Browser Ids
    IF    ${browsers}
        Run Keyword If Test Failed    Capture Page Screenshot
        Run Keyword If Test Failed    Capture Current Location
    END

Capture Current Location
    ${current_url}=                       Get Location

Capture Failed and Close All Browsers
    Capture Page If Test Failed
    Close All Browsers

Logout And Capture Failed and Close All Browsers 
   Logout Account
   Capture Page If Test Failed
   Close All Browsers 