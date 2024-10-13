*** Settings ***
Library    AppiumLibrary
Variables    ${CURDIR}/devices.yml
Library    String

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

*** Test Cases ***
Open CAMT Application
    [Documentation]    Test case to open the application, login, and navigate to Google
    Open SauceLab Application
    # **Step 1: Login with "Standard User"** 
    # **Step 2: Verify Login Success**
    Login to SauceLab    ${USERNAME}    ${PASSWORD}

    # **Step 3: Sort Product Items by "Name Ascending" (A-Z)**
    Wait Until Element Is Visible    locator=accessibility_id=test-Modal Selector Button    timeout=5s
    Click Element    locator=accessibility_id=test-Modal Selector Button
    Wait Until Element Is Visible    locator=android=new UiSelector().text("Name (A to Z)")    timeout=5s
    Click Element    locator=android=new UiSelector().text("Name (A to Z)")
    
    #**Step 4: Find and Click Product "Test.allTheThings() T-Shirt"**
    BuiltIn.Wait Until Keyword Succeeds     5x    3s     Run Keywords
    ...    Swipe    1000    1000    1000    500
    ...    AND    Wait Until Element Is Visible    locator=android=new UiSelector().text("Test.allTheThings() T-Shirt (Red)")    timeout=2s
    ...    AND    Click Element    locator=android=new UiSelector().text("Test.allTheThings() T-Shirt (Red)")
    Wait Until Page Contains    text=Test.allTheThings() T-Shirt (Red)
    
    # **Step 5: Get and Save Price of the Product, Then Click "Add to Cart"**
    BuiltIn.Wait Until Keyword Succeeds     5x    3s     Run Keywords
    ...    Swipe    1000    1000    1000    500
    ...    AND    Wait Until Element Is Visible    locator=accessibility_id=test-ADD TO CART    timeout=2s
    ${item_price}    Get Text    locator=accessibility_id=test-Price
    ${item_price}    String.Remove String    ${item_price}    $
    Click Element    locator=accessibility_id=test-ADD TO CART
    Wait Until Element Is Visible    locator=accessibility_id=test-REMOVE    timeout=5s

    # **Step 6: Verify "Cart" Icon Has Changed to "1"**
    ${item_count}    Get Text    locator=android=new UiSelector().description("test-Cart").childSelector(new UiSelector().className("android.widget.TextView"))
    Should Be Equal As Numbers    ${item_count}    1

    # **Step 7: Go to "Checkout Page"**
    Wait Until Element Is Visible    locator=accessibility_id=test-Cart    timeout=5s
    Click Element    locator=accessibility_id=test-Cart

    # **Step 8: Verify the Product Name and Price Are Correct**
    Wait Until Page Contains    text=Test.allTheThings() T-Shirt (Red)
    ${shopping_price}    Get Text    locator=android=new UiSelector().description("test-Price").childSelector(new UiSelector().className("android.widget.TextView"))
    ${shopping_price}    String.Remove String    ${shopping_price}    $
    Should Be Equal As Numbers    ${item_price}    ${shopping_price}

    # **Step 9: Click "Checkout" Button**
    Wait Until Element Is Visible    locator=accessibility_id=test-CHECKOUT    timeout=5s
    Click Element    locator=accessibility_id=test-CHECKOUT

    # **Step 10: Fill in the Form with "Firstname, Lastname, Postal Code" Data**
    Wait Until Element Is Visible    locator=accessibility_id=test-First Name    timeout=5s
    Input Text    locator=accessibility_id=test-First Name    text=John
    Input Text    locator=accessibility_id=test-Last Name    text=Doe
    Input Text    locator=accessibility_id=test-Zip/Postal Code    text=12345
    
    # **Step 11: Click "Continue" Button**
    Wait Until Element Is Visible    locator=accessibility_id=test-CONTINUE    timeout=5s
    Click Element    locator=accessibility_id=test-CONTINUE

    # **Step 12: Verify the Product Name and Price Are Correct Again**
    Wait Until Page Contains    text=Test.allTheThings() T-Shirt (Red)
    ${shopping_price}    Get Text    locator=android=new UiSelector().description("test-Price").childSelector(new UiSelector().className("android.widget.TextView"))
    ${shopping_price}    String.Remove String    ${shopping_price}    $
    Should Be Equal As Numbers    ${item_price}    ${shopping_price}

    # **Step 13: Verify "Item Total", "Tax", and "Total" Are Correct**
    Wait Until Element Is Visible    locator=android=new UiSelector().textContains("Item total")
    ${item_total}    Get Text    locator=android=new UiSelector().textContains("Item total")
    Should Be Equal    ${item_total}    Item total: $${item_price}

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
