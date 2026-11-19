*** Settings ***
Documentation     Test suite untuk memverifikasi fungsi filter / pengurutan produk di halaman Inventory SauceDemo
Resource          ${EXECDIR}/resources.txt
Test Setup        login_logic.Open Browser And Login As Standard User
Test Teardown     Capture Failed and Close All Browsers
Suite Teardown    Close All Browsers

*** Test Cases ***
TC01 - Verify Default Sort Is Name A To Z
    [Documentation]    Memastikan saat halaman inventory pertama kali dibuka, filter default adalah Name (A to Z) dan urutan produk sesuai.
    [Tags]             filter    sort    smoke
    filter_logic.Verify Default Sort Is Name A To Z

TC02 - Verify Sort Products By Name Z To A
    [Documentation]    Memastikan klik menu filter dan memilih opsi 'za' mengurutkan nama produk secara descending (Z ke A).
    [Tags]             filter    sort
    filter_logic.Select Product Sort Option    za    Name (Z to A)
    filter_logic.Verify Products Are Sorted By Name    order=DESC

TC03 - Verify Sort Products By Price Low To High
    [Documentation]    Memastikan klik menu filter dan memilih opsi 'lohi' mengurutkan harga produk dari termurah ke termahal.
    [Tags]             filter    sort
    filter_logic.Select Product Sort Option    lohi    Price (low to high)
    filter_logic.Verify Products Are Sorted By Price    order=ASC

TC04 - Verify Sort Products By Price High To Low
    [Documentation]    Memastikan klik menu filter dan memilih opsi 'hilo' mengurutkan harga produk dari termahal ke termurah.
    [Tags]             filter    sort
    filter_logic.Select Product Sort Option    hilo    Price (high to low)
    filter_logic.Verify Products Are Sorted By Price    order=DESC

TC05 - Verify Switching Back To Name A To Z From Another Filter
    [Documentation]    Memastikan opsi 'az' berfungsi saat dipilih kembali setelah menggunakan filter lain.
    [Tags]             filter    sort
    filter_logic.Select Product Sort Option    hilo    Price (high to low)
    filter_logic.Verify Products Are Sorted By Price    order=DESC
    filter_logic.Select Product Sort Option    az    Name (A to Z)
    filter_logic.Verify Products Are Sorted By Name    order=ASC

TC06 - Verify Add To Cart Adds Correct Item After Filtering
    [Documentation]    Memastikan produk yang masuk ke cart sesuai dengan item yang diklik setelah daftar produk diurutkan.
    [Tags]             filter    integration
    filter_logic.Select Product Sort Option    za    Name (Z to A)
    ${first_product_name}=    filter_logic.Get First Product Name
    filter_logic.Add First Product To Cart
    cart_logic.Go To Cart Page
    cart_logic.Verify Product Is In Cart    ${first_product_name}