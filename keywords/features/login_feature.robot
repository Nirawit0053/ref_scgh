*** Keywords ***
User login via email and password
    [Arguments]    ${email}     ${password}
    login_page.Input email login         ${email}
    login_page.Input password login      ${password}
    login_page.Click login button

Verify Login Success
    login_page.Verify page title displayed correctly
    login_page.Verify wording ai displayed correctly
    login_page.Verify button login disappeared