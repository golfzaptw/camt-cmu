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
    Login to SauceLab    ${USERNAME}    ${PASSWORD}
    Wait Until Element Is Visible    locator=accessibility_id=test-Modal Selector Button    timeout=5s
    Click Element    locator=accessibility_id=test-Modal Selector Button
    Wait Until Element Is Visible    locator=android=new UiSelector().text("Name (A to Z)")    timeout=5s
    Click Element    locator=android=new UiSelector().text("Name (A to Z)")
    BuiltIn.Wait Until Keyword Succeeds     5x    3s     Run Keywords
    ...    Swipe    1000    1000    1000    500
    ...    AND    Wait Until Element Is Visible    locator=android=new UiSelector().text("Test.allTheThings() T-Shirt (Red)")    timeout=2s
    ...    AND    Click Element    locator=android=new UiSelector().text("Test.allTheThings() T-Shirt (Red)")
    Wait Until Page Contains    text=Test.allTheThings() T-Shirt (Red)
    BuiltIn.Wait Until Keyword Succeeds     5x    3s     Run Keywords
    ...    Swipe    1000    1000    1000    500
    ...    AND    Wait Until Element Is Visible    locator=accessibility_id=test-ADD TO CART    timeout=2s
    ${item_price}    Get Text    locator=accessibility_id=test-Price
    ${item_price}    String.Remove String    ${item_price}    $
    Click Element    locator=accessibility_id=test-ADD TO CART

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
