*** Settings ***
Resource        ${CURDIR}/import.resource

*** Variables ***
${REMOTE_URL}    http://127.0.0.1:4723

# Login page locators
${login.txt_username}    accessibility_id=test-Username
${login.txt_password}    accessibility_id=test-Password
${login.btn_login}       accessibility_id=test-LOGIN

# Validation locators
${home.products_page}     android=new UiSelector().description("test-Cart drop zone").childSelector(new UiSelector().text("PRODUCTS"))

# Credentials
${USERNAME}    standard_user
${PASSWORD}    secret_sauce

&{PRODUCT_NAME}
...    jacket=Sauce Labs Fleece Jacket
...    onesie=Sauce Labs Onesie


*** Test Cases ***
Automating E-commerce Quiz
    [Documentation]    This test case is to automate the e-commerce quiz
    ...    1. **เปิดแอปพลิเคชัน**
    ...    2. **ใส่ข้อมูล Username และ Password**
    ...    3. **เข้าสู่ระบบ**
    ...    4. **ค้นหาเพื่อเลือกและเพิ่มสินค้าลงตะกร้า** Sauce Labs Fleece Jacket
    ...    5. **ค้นหาเพื่อเลือกและเพิ่มสินค้าชิ้นที่สอง**  Sauce Labs Onesie
    ...    6. **ตรวจสอบจำนวนสินค้าในตะกร้า**
    ...    7. **ยืนยันการสั่งซื้อ**
    ...    8. **กรอกข้อมูลผู้ซื้อ**
    ...    9. **ตรวจสอบข้อมูลการชำระเงิน**
    ...    10. **ยืนยันคำสั่งซื้อ**
    ...    11. **กลับสู่หน้าหลัก**
    Open SauceLab Application
    Login to SauceLab    ${USERNAME}    ${PASSWORD}    
    ${status}    Run Keyword And Return Status    Wait Until Element Is Visible    locator=android=new UiSelector().description("test-Item title").text("${PRODUCT_NAME.jacket}")    timeout=5s
    IF    not ${status}
        BuiltIn.Wait Until Keyword Succeeds     5x    3s     Run Keywords
        ...    Swipe    1000    1500    1000    500
        ...    AND    Wait Until Element Is Visible    locator=android=new UiSelector().description("test-Item title").text("${PRODUCT_NAME.jacket}")    timeout=5s
        ...    AND    Wait Until Element Is Visible    locator=android=new UiSelector().description("test-Item title").text("${PRODUCT_NAME.jacket}").fromParent(new UiSelector().description("test-ADD TO CART"))    timeout=5s
    END
    ${first_item_price}    Get Text    locator=android=new UiSelector().description("test-Item title").text("${PRODUCT_NAME.jacket}").fromParent(new UiSelector().description("test-Price"))
    ${first_item_price}    String.Remove String    ${first_item_price}    $
    Click Element    locator=android=new UiSelector().description("test-Item title").text("${PRODUCT_NAME.jacket}").fromParent(new UiSelector().description("test-ADD TO CART"))
    ${item_count}    Get Text    locator=android=new UiSelector().description("test-Cart").childSelector(new UiSelector().className("android.widget.TextView"))
    Should Be Equal As Numbers    ${item_count}    1

    ${status}    Run Keyword And Return Status    Wait Until Element Is Visible    locator=android=new UiSelector().description("test-Item title").text("${PRODUCT_NAME.onesie}")    timeout=5s
    IF    not ${status}
        BuiltIn.Wait Until Keyword Succeeds     5x    3s     Run Keywords
        ...    Swipe    1000    1500    1000    500
        ...    AND    Wait Until Element Is Visible    locator=android=new UiSelector().description("test-Item title").text("${PRODUCT_NAME.onesie}")    timeout=5s
        ...    AND    Wait Until Element Is Visible    locator=android=new UiSelector().description("test-Item title").text("${PRODUCT_NAME.onesie}").fromParent(new UiSelector().description("test-ADD TO CART"))    timeout=5s
    END
    ${second_item_price}    Get Text    locator=android=new UiSelector().description("test-Item title").text("${PRODUCT_NAME.onesie}").fromParent(new UiSelector().description("test-Price"))
    ${second_item_price}    String.Remove String    ${second_item_price}    $
    Click Element    locator=android=new UiSelector().description("test-Item title").text("${PRODUCT_NAME.onesie}").fromParent(new UiSelector().description("test-ADD TO CART"))
    ${item_count}    Get Text    locator=android=new UiSelector().description("test-Cart").childSelector(new UiSelector().className("android.widget.TextView"))
    Should Be Equal As Numbers    ${item_count}    2

    Wait Until Element Is Visible    locator=accessibility_id=test-Cart    timeout=5s
    Click Element    locator=accessibility_id=test-Cart
    
    Wait Until Page Contains    text=${PRODUCT_NAME.jacket}
    ${first_shopping_price}    Get Text    locator=android=new UiSelector().description("test-Price").childSelector(new UiSelector().className("android.widget.TextView")).instance(0)
    ${first_shopping_price}    String.Remove String    ${first_shopping_price}    $
    Should Be Equal As Numbers    ${first_item_price}    ${first_shopping_price}

    Wait Until Page Contains    text=${PRODUCT_NAME.onesie}
    ${second_shopping_price}    Get Text    locator=android=new UiSelector().description("test-Price").childSelector(new UiSelector().className("android.widget.TextView")).instance(1)
    ${second_shopping_price}    String.Remove String    ${second_shopping_price}    $
    Should Be Equal As Numbers    ${second_item_price}    ${second_shopping_price}

    ${status}    Run Keyword And Return Status    Wait Until Element Is Visible    locator=accessibility_id=test-CHECKOUT    timeout=5s
    IF    not ${status}
        BuiltIn.Wait Until Keyword Succeeds     5x    3s     Run Keywords
        ...    Swipe    1000    1500    1000    500
        ...    AND    Wait Until Element Is Visible    locator=accessibility_id=test-CHECKOUT    timeout=5s
        ...    AND    Click Element    locator=accessibility_id=test-CHECKOUT
    END

    Wait Until Element Is Visible    locator=accessibility_id=test-First Name    timeout=5s
    Input Text    locator=accessibility_id=test-First Name    text=John
    Input Text    locator=accessibility_id=test-Last Name    text=Doe
    Input Text    locator=accessibility_id=test-Zip/Postal Code    text=12345
    Wait Until Element Is Visible    locator=accessibility_id=test-CONTINUE    timeout=5s
    Click Element    locator=accessibility_id=test-CONTINUE

    Wait Until Page Contains    text=${PRODUCT_NAME.jacket}
    ${first_shopping_price}    Get Text    locator=android=new UiSelector().description("test-Price").childSelector(new UiSelector().className("android.widget.TextView")).instance(0)
    ${first_shopping_price}    String.Remove String    ${first_shopping_price}    $
    Should Be Equal As Numbers    ${first_item_price}    ${first_shopping_price}

    Wait Until Page Contains    text=${PRODUCT_NAME.onesie}
    ${second_shopping_price}    Get Text    locator=android=new UiSelector().description("test-Price").childSelector(new UiSelector().className("android.widget.TextView")).instance(1)
    ${second_shopping_price}    String.Remove String    ${second_shopping_price}    $
    Should Be Equal As Numbers    ${second_item_price}    ${second_shopping_price}

    ${status}    Run Keyword And Return Status    Wait Until Element Is Visible    locator=android=new UiSelector().textStartsWith("Total:")    timeout=5s
    IF    not ${status}
        BuiltIn.Wait Until Keyword Succeeds     5x    3s     Run Keywords
        ...    Swipe    1000    1500    1000    500
        ...    AND    Wait Until Element Is Visible    locator=android=new UiSelector().textStartsWith("Total:")    timeout=5s
    END

    ${item_total_price}    Evaluate    ${first_shopping_price} + ${second_shopping_price}

    Wait Until Element Is Visible    locator=android=new UiSelector().textContains("Item total:")
    ${item_total}    Get Text    locator=android=new UiSelector().textContains("Item total:")
    Should Be Equal    ${item_total}    Item total: $${item_total_price}
    ${CONSTANT_TAX}    Set Variable    0.08
    ${tax}    Evaluate    ${item_total_price} * ${CONSTANT_TAX}
    ${total}    Evaluate    ${item_total_price} + ${tax}
    ${tax}    Evaluate    round(${tax}, 2)
    ${total}    Evaluate    round(${total}, 2)
    ${item_tax}    Get Text    locator=android=new UiSelector().textContains("Tax:")
    ${item_total}    Get Text    locator=android=new UiSelector().textStartsWith("Total:")
    Should Be Equal    ${item_tax}    Tax: $${tax}
    Should Be Equal    ${item_total}    Total: $${total}


    BuiltIn.Wait Until Keyword Succeeds     5x    3s     Run Keywords
    ...    Swipe    1000    1500    1000    500
    ...    AND    Wait Until Element Is Visible    locator=accessibility_id=test-FINISH    timeout=2s
    ...    AND    Click Element    locator=accessibility_id=test-FINISH


    Wait Until Page Contains    text=THANK YOU FOR YOU ORDER
    Wait Until Page Contains    text=Your order has been dispatched, and will arrive just as fast as the pony can get there!
    Wait Until Element Is Visible    locator=accessibility_id=test-BACK HOME    timeout=5s
    Click Element    locator=accessibility_id=test-BACK HOME
    Wait Until Element Is Visible    ${home.products_page}    timeout=5s


*** Keywords ***
Open SauceLab Application
    Open Application    ${REMOTE_URL}    &{ANDROID_DEVICE}

Login to SauceLab
    [Arguments]    ${user}    ${pass}
    Input Username    ${user}
    Input Password    ${pass}
    Click Login Button
    Wait Until Element Is Visible    ${home.products_page}    timeout=5s

Input Username
    [Arguments]    ${user}
    Wait Until Element Is Visible    ${login.txt_username}    timeout=5s
    Input Text    ${login.txt_username}    text=${user}

Input Password
    [Arguments]    ${pass}
    Wait Until Element Is Visible    ${login.txt_password}    timeout=5s
    Input Text    ${login.txt_password}    text=${pass}

Click Login Button
    Wait Until Element Is Visible    ${login.btn_login}    timeout=5s
    Click Element    ${login.btn_login}
