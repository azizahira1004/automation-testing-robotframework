*** Keywords ***
Verify Login Page Element
    LoginPagePages.Verify Field Username
    LoginPagePages.Verify Field Password
    LoginPagePages.Verify Login Button

Login With Valid Data
    LoginPagePages.Input Username                   ${VALID_USERNAME}
    LoginPagePages.Input Password                   ${VALID_PASSWORD}
    LoginPagePages.Tap Login Button

Verify Success Login
    HomepagePages.Verify Products Page Is Visible
    HomepagePages.Verify Homepage Title             PRODUCTS

Login With Invalid Data
    [Arguments]             ${username}=${INVALID_USERNAME}    ${password}=${INVALID_PASSWORD}
    LoginPagePages.Input Username                   ${username}
    LoginPagePages.Input Password                   ${password}
    LoginPagePages.Tap Login Button

Verify Failed Login Message
    [Arguments]             ${errorMessage}=Username and password do not match any user in this service.
    LoginPagePages.Verify Error Message             ${errorMessage}
