*** Settings ***
Resource          ${EXECDIR}/resources.txt
Test Setup        Open Homepage
Test Teardown     Capture Failed and Close All Browsers
Suite Teardown    Close All Browsers

*** Test Cases ***
TC01 - Dynamic Random Multiple Items Checkout Flow
    [Documentation]    Memilih produk acak minimal 1, validasi tombol Remove & badge, verifikasi isi Cart, hingga selesai checkout.
    login_logic.Login With Credentials    ${STANDARD_USER.USERNAME}    ${STANDARD_USER.PASSWORD}
    inventory_page.Verify Inventory Page Loaded
    # 1. Pilih produk secara acak terlebih dahulu
    @{selected_items}=           Select Random Products
    # 2. Validasi toggle button hanya untuk produk yang terpilih
    inventory_logic.Verify Selected Inventory Buttons Functionality    ${selected_items}    allow_broken=${FALSE}
    # 3. Masukkan produk yang sama ke Cart
    @{selected_items}=    inventory_logic.Add Random Items To Cart    selected_items=${selected_items}    allow_broken=${FALSE}
    cart_logic.Go To Cart Page
    cart_logic.Verify Items In Cart    @{selected_items}
    cart_logic.Proceed To Checkout
    checkout_logic.Fill Shipping Information    Ira    Nurazizah    16411
    checkout_logic.Complete Order
    checkout_logic.Verify Order Confirmation    Thank you for your order!

TC02 - Performance Glitch User Login With Delay
    [Documentation]    Memverifikasi skrip tetap stabil menangani jeda latensi login pada performance_glitch_user.
    login_logic.Login With Credentials    ${PERFORMANCE_GLITCH_USER.USERNAME}    ${PERFORMANCE_GLITCH_USER.PASSWORD}
    inventory_page.Verify Inventory Page Loaded    timeout=15s
    @{selected_items}=    inventory_logic.Add Random Items To Cart
    cart_logic.Go To Cart Page
    cart_logic.Verify Items In Cart    @{selected_items}

TC03 - Verify Inventory Add And Remove Button Toggle On Error User
    [Documentation]    Memverifikasi fungsi toggle tombol Add to cart dan Remove pada produk terpilih secara acak untuk akun error_user, serta mendeteksi tombol yang broken (tidak merespons perubahan state).
    login_logic.Login With Credentials    ${ERROR_USER.USERNAME}    ${ERROR_USER.PASSWORD}
    inventory_page.Verify Inventory Page Loaded
    @{selected_items}=    inventory_logic.Select Random Products
    # allow_broken=${TRUE} agar test mencatat log tombol yang broken pada error_user tanpa langsung FAIL
    inventory_logic.Verify Selected Inventory Buttons Functionality    ${selected_items}    allow_broken=${TRUE}

TC04 - Visual User Encounters UI And Image Alignment Bugs
    [Documentation]    Memverifikasi visual_user mengalami bug tampilan (gambar produk tertukar / posisi elemen bergeser) meski alur checkout tetap berjalan.
    login_logic.Login With Credentials    ${VISUAL_USER.USERNAME}    ${VISUAL_USER.PASSWORD}
    inventory_page.Verify Inventory Page Loaded

    # Contoh verifikasi visual bug: gambar produk pertama (Backpack) menampilkan gambar anjing (sl-404)
    ${img_src}=    Get Element Attribute    xpath=(//img[@class="inventory_item_img"])[1]    src
    Should Contain    ${img_src}    sl-404

    # Gunakan $ agar list dikirim sebagai satu parameter ke ${selected_items}
    @{selected_items}=    inventory_logic.Add Random Items To Cart    ${ERROR_USER_VALID_ITEMS}
    cart_logic.Go To Cart Page
    cart_logic.Proceed To Checkout
    checkout_logic.Fill Shipping Information    Ira    Nurazizah    16411
    checkout_logic.Complete Order

TC05 - Validate Required Shipping Fields Error During Checkout
    [Documentation]    Memverifikasi validasi error field wajib saat mengisi form pengiriman.
    login_logic.Login With Credentials    ${STANDARD_USER.USERNAME}    ${STANDARD_USER.PASSWORD}
    inventory_page.Verify Inventory Page Loaded
    @{selected_items}=    inventory_logic.Select Random Products
    @{selected_items}=    inventory_logic.Add Random Items To Cart    selected_items=${selected_items}
    cart_logic.Go To Cart Page
    cart_logic.Verify Items In Cart    @{selected_items}
    cart_logic.Proceed To Checkout
    checkout_logic.Fill Shipping Information    Ira    Nurazizah    ${EMPTY}
    checkout_logic.Verify Shipping Input Error    Error: Postal Code is required
    # Terdapat bug pada tombol Continue yang tetap aktif meski field Postal Code kosong, sehingga perlu menekan tombol Cancel untuk kembali ke halaman Cart.
    checkout_logic.Click Button Cancel Checkout
    cart_logic.Proceed To Checkout
    checkout_logic.Fill Shipping Information    Ira    ${EMPTY}    16411
    checkout_logic.Verify Shipping Input Error    Error: Last Name is required
    checkout_logic.Click Button Cancel Checkout
    cart_logic.Proceed To Checkout
    checkout_logic.Fill Shipping Information    ${EMPTY}    Nurazizah    16411
    checkout_logic.Verify Shipping Input Error    Error: First Name is required