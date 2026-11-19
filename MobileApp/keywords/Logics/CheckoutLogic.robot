*** Keywords ***
Select Fixed Mobile Checkout Product
    ${selected_items}=    Create List    Sauce Labs Backpack
    RETURN    ${selected_items}

Login Mobile User And Verify Catalog
    [Arguments]    ${username}    ${password}    ${timeout}=${DEFAULT_TIMEOUT}
    Input Login Credentials    ${username}    ${password}
    Wait For Products Screen   timeout=${timeout}

Verify Mobile Selected Buttons Functionality
    [Arguments]    ${selected_items}    ${allow_broken}=${FALSE}
    ${broken_transitions}=    Create List
    FOR    ${item}    IN    @{selected_items}
        ${title_loc}=  Set Variable    xpath=//android.widget.TextView[@text="${item}" and @content-desc="test-Item title"]
        Run Keyword And Ignore Error    Scroll Element Into View    ${title_loc}    max_swipes=4
        ${card_loc}=    Set Variable    xpath=//android.widget.TextView[@text="${item}" and @content-desc="test-Item title"]/ancestor::android.view.ViewGroup[.//*[@content-desc="test-ADD TO CART" or @content-desc="test-REMOVE"]][1]
        ${add_loc}=     Set Variable    ${card_loc}//*[@content-desc="test-ADD TO CART"]
        ${rem_loc}=     Set Variable    ${card_loc}//*[@content-desc="test-REMOVE"]

        ${has_add}=       Run Keyword And Return Status    Wait Until Element Is Visible    ${add_loc}    timeout=1s
        ${has_remove}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${rem_loc}    timeout=1s
        IF    ${has_add} and ${has_remove}
            ${failure}=    Set Variable    ${item}: both ADD TO CART and REMOVE are visible initially.
            Append To List    ${broken_transitions}    ${failure}
            Log    Broken button state: ${failure}    level=WARN
            CONTINUE
        ELSE IF    not ${has_add} and not ${has_remove}
            ${failure}=    Set Variable    ${item}: neither ADD TO CART nor REMOVE is visible initially.
            Append To List    ${broken_transitions}    ${failure}
            Log    Broken button state: ${failure}    level=WARN
            CONTINUE
        END

        IF    ${has_add}
            ${start_state}=    Set Variable    ADD TO CART
            ${start_loc}=      Set Variable    ${add_loc}
            ${next_state}=     Set Variable    REMOVE
            ${next_loc}=       Set Variable    ${rem_loc}
        ELSE
            ${start_state}=    Set Variable    REMOVE
            ${start_loc}=      Set Variable    ${rem_loc}
            ${next_state}=     Set Variable    ADD TO CART
            ${next_loc}=       Set Variable    ${add_loc}
        END

        ${failure}=    Set Variable    ${EMPTY}
        ${clicked_start}=    Run Keyword And Return Status    Click Element    ${start_loc}
        IF    not ${clicked_start}
            ${failure}=    Set Variable    ${item}: clicking ${start_state} failed; initial state did not change.
        ELSE
            ${next_visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${next_loc}    timeout=3s
            IF    not ${next_visible}
                ${start_still_visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${start_loc}    timeout=1s
                IF    ${start_still_visible}
                    ${failure}=    Set Variable    ${item}: ${start_state} -> ${next_state} failed; state remained ${start_state}.
                ELSE
                    ${failure}=    Set Variable    ${item}: ${next_state} did not appear after clicking ${start_state}.
                END
            ELSE
                ${clicked_next}=    Run Keyword And Return Status    Click Element    ${next_loc}
                IF    not ${clicked_next}
                    ${failure}=    Set Variable    ${item}: clicking ${next_state} failed; state remained ${next_state}.
                ELSE
                    ${start_visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${start_loc}    timeout=3s
                    IF    not ${start_visible}
                        ${failure}=    Set Variable    ${item}: ${next_state} -> ${start_state} failed; ${start_state} did not appear.
                    END
                END
            END
        END

        IF    $failure != ''
            Append To List    ${broken_transitions}    ${failure}
            Log    Broken button transition: ${failure}    level=WARN
        ELSE
            Log    Button toggle verified for ${item}: ${start_state} -> ${next_state} -> ${start_state}.    level=INFO
        END
    END
    ${items_checked}=    Get Length    ${selected_items}
    ${broken_count}=    Get Length    ${broken_transitions}
    IF    ${broken_count} == 0
        Log    Button check summary: ${items_checked} product(s) checked; 0 broken transitions found.    level=INFO
    ELSE
        ${summary}=    Catenate    SEPARATOR=\n    @{broken_transitions}
        Log    Button check summary: ${items_checked} product(s) checked; ${broken_count} broken transition(s) found:\n${summary}    level=WARN
    END
    IF    ${broken_count} > 0
        IF    not ${allow_broken}
            Fail    Ditemukan transisi tombol Add/Remove yang bermasalah: ${broken_transitions}
        END
    END
    RETURN    ${broken_transitions}

Add Random Mobile Items To Cart
    [Arguments]    ${selected_items}=${NONE}    ${allow_broken}=${FALSE}
    IF    ${selected_items} is ${NONE}
        ${selected_items}=    Select Fixed Mobile Checkout Product
    END
    ${added_items}=    Create List
    FOR    ${item}    IN    @{selected_items}
        ${title_loc}=  Set Variable    xpath=//android.widget.TextView[@text="${item}" and @content-desc="test-Item title"]
        Run Keyword And Ignore Error    Scroll Element Into View    ${title_loc}    max_swipes=4
        ${card_loc}=    Set Variable    xpath=//android.widget.TextView[@text="${item}" and @content-desc="test-Item title"]/ancestor::android.view.ViewGroup[.//*[@content-desc="test-ADD TO CART" or @content-desc="test-REMOVE"]][1]
        ${add_loc}=     Set Variable    ${card_loc}//*[@content-desc="test-ADD TO CART"]
        ${rem_loc}=     Set Variable    ${card_loc}//*[@content-desc="test-REMOVE"]

        ${has_rem}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${rem_loc}    timeout=1s
        IF    ${has_rem}
            Run Keyword And Ignore Error    Click Element    ${rem_loc}
            ${reset_done}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${add_loc}    timeout=3s
            IF    not ${reset_done} AND not ${allow_broken}
                Fail    Item '${item}' gagal dikembalikan ke state awal sebelum ditambahkan.
            END
        END

        ${clicked}=    Run Keyword And Return Status    Click Element    ${add_loc}
        IF    ${clicked}
            ${is_added}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${rem_loc}    timeout=3s
            IF    ${is_added}
                Append To List    ${added_items}    ${item}
            ELSE IF    not ${allow_broken}
                Fail    Item '${item}' gagal masuk ke cart (tombol REMOVE tidak muncul).
            END
        ELSE IF    not ${allow_broken}
            Fail    Tombol ADD TO CART untuk '${item}' tidak dapat diklik.
        END
    END
    RETURN    ${added_items}

Verify Mobile Cart Badge Matches Items
    [Arguments]    @{expected_items}
    ${expected_count}=    Get Length    ${expected_items}
    Scroll To Top Safe    5
    ${actual_count}=      Get Cart Badge Count
    Should Be Equal As Integers    ${actual_count}    ${expected_count}

Verify Mobile Items In Cart
    [Arguments]    @{expected_items}
    Verify Mobile Cart Badge Matches Items    @{expected_items}
    FOR    ${item}    IN    @{expected_items}
        ${item_loc}=    Set Variable    xpath=//android.widget.TextView[@text="${item}"]
        Scroll Element Into View    ${item_loc}    max_swipes=4
        Page Should Contain Element    ${item_loc}
    END

Verify Mobile Shipping Input Error
    [Arguments]    ${expected_error}
    ${actual_error}=    Get Mobile Checkout Error Text
    Should Contain      ${actual_error}    ${expected_error}    ignore_case=True