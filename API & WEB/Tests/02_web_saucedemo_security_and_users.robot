*** Settings ***
Documentation     Pengujian keamanan sesi, akses URL langsung tanpa autentikasi,
...               serta perilaku akun khusus (locked_out_user & problem_user).
Resource          ${EXECDIR}/resources.txt
Test Setup        Open Homepage
Test Teardown     Capture Failed and Close All Browsers
Suite Teardown    Close All Browsers

*** Test Cases ***
TC01 - Security: Direct Access To Cart Page Without Login
    [Tags]    security    negative
    Go To    ${CART_URL}
    login_logic.Verify Auth Error Message    Epic sadface: You can only access '/cart.html' when you are logged in.

TC02 - Auth Negative: Login With Locked Out User
    [Tags]    auth    negative
    login_logic.Login With Credentials       ${LOCKED_OUT_USER.USERNAME}    ${LOCKED_OUT_USER.PASSWORD}
    login_logic.Verify Auth Error Message    Epic sadface: Sorry, this user has been locked out.

TC03 - Defect Detection: Verify Broken Product Image On Problem User
    [Tags]    defect_check    problem_user    dynamic
    login_logic.Login With Credentials    ${PROBLEM_USER.USERNAME}    ${PROBLEM_USER.PASSWORD}
    @{product_img}=    inventory_logic.Get Random Product Image Src
    ${product_name}=    Set Variable    ${product_img}[0]
    ${img_src}=         Set Variable    ${product_img}[1]
    # Pada standard_user gambar produk tampil normal sesuai masing-masing item
    # Pada problem_user semua gambar produk berubah menjadi sl-404.jpg
    Should Contain    ${img_src}    sl-404
    Log    Bug terdeteksi pada problem_user untuk produk '${product_name}': Gambar mengarah ke ${img_src}}