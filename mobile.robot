*** Settings ***
Library    AppiumLibrary
Variables    ${CURDIR}/devices.yml

*** Variables ***
${REMOTE_URL}    http://127.0.0.1:4723

# Login page locators
${login.txt_username}    accessibility_id=test-Username
${login.txt_password}    accessibility_id=test-Password
${login.btn_login}       accessibility_id=test-LOGIN

# Menu and navigation locators
${menu.btn_menu}              accessibility_id=test-Menu
${menu.btn_webview}           accessibility_id=test-WEBVIEW
${webview.input_url}          accessibility_id=test-enter a https url here...
${webview.btn_go_to_site}     accessibility_id=test-GO TO SITE

# Google search locators
${google.input_search}    android=new UiSelector().description("ค้นหาโดยใช้กล้องหรือรูปภาพของคุณ").fromParent(new UiSelector().className("android.widget.EditText"))
${google.btn_search}      android=new UiSelector().resourceId("tsf").childSelector(new UiSelector().text("ค้นหาด้วย Google"))

# Validation locators
${home.products_page}     android=new UiSelector().description("test-Cart drop zone").childSelector(new UiSelector().text("PRODUCTS"))
${search.result_page}     Mobile Automation
${search.install_text}    ติดตั้งการทำ Mobile Test

# Credentials
${USERNAME}    standard_user
${PASSWORD}    secret_sauce

*** Test Cases ***
Open CAMT Application
    [Documentation]    Test case to open the application, login, and navigate to Google
    Open SauceLab Application
    Login to SauceLab    ${USERNAME}    ${PASSWORD}
    Navigate to WebView
    Perform Google Search    Mobile Automation

*** Keywords ***
Open SauceLab Application
    Open Application    ${REMOTE_URL}    &{ANDROID_DEVICE}

Login to SauceLab
    [Arguments]    ${user}    ${pass}
    Input Username    ${user}
    Input Password    ${pass}
    Click Login Button
    Wait Until Element Is Visible    ${home.products_page}    timeout=5s

Navigate to WebView
    Wait Until Element Is Visible    ${menu.btn_menu}    timeout=5s
    Click Element    ${menu.btn_menu}
    Wait Until Element Is Visible    ${menu.btn_webview}    timeout=5s
    Click Element    ${menu.btn_webview}
    Wait Until Element Is Visible    ${webview.input_url}    timeout=5s
    Input Text    ${webview.input_url}    text=https://www.google.com
    Wait Until Element Is Visible    ${webview.btn_go_to_site}    timeout=5s
    Click Element    ${webview.btn_go_to_site}

Perform Google Search
    [Arguments]    ${search_text}
    Wait Until Element Is Visible    ${google.input_search}    timeout=5s
    Input Text    ${google.input_search}    text=${search_text}
    Click Element    ${google.btn_search}
    Press Keycode    66
    Wait Until Page Contains    ${search.result_page}
    Swipe    1000    1000    1000    500
    Swipe    1000    1000    1000    500
    Swipe    1000    1000    1000    500
    Wait Until Page Contains    ${search.install_text}

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
