*** Variables ***
${loginpage.title_page}       SCGH Retail
${loginpage.lbl_AI}           AI
${loginpage.txt_username}     id=outlined-adornment-email
${loginpage.txt_password}     id=outlined-adornment-password
${loginpage.btn_login}        xpath=//button[@data-test="submit"]

*** Keywords ***
Click login button
    DobbyWebCommon.Click element when ready       ${loginpage.btn_login}

Input email login        
    [Arguments]     ${emaillogin}
    DobbyWebCommon.Input text to element when ready     ${loginpage.txt_username}        ${emaillogin}

Input password login        
    [Arguments]     ${passwordlogin}
    DobbyWebCommon.Input text to element when ready     ${loginpage.txt_password}        ${passwordlogin}

Verify page title displayed correctly
    SeleniumLibrary.Title should be                         ${loginpage.title_page}

Verify wording ai displayed correctly
    SeleniumLibrary.Wait Until Page Contains                ${loginpage.lbl_AI}

Verify button login disappeared
    SeleniumLibrary.Wait Until Element Is Not Visible       ${loginpage.btn_login}