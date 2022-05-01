*** Variables ***
${mainpage.title_page}         SCGH Retail
${mainpage.feature_AI}         xpath=//h5[contains(text(),'AI')]
${mainpage.feature_DRP}        xpath=//h5[contains(text(),'DRP')]
${mainpage.feature_VMI}        xpath=//h5[contains(text(),'VMI')]
${mainpage.feature_config}     xpath=//h5[contains(text(),'Configuration')]
${mainpage.btn_AI}             xpath=//h5[text()="AI"]/parent::div//following-sibling::div//button
${mainpage.btn_DRP}            xpath=//h5[text()="DRP"]/parent::div//following-sibling::div//button
${mainpage.btn_VMI}            xpath=//h5[text()="VMI"]/parent::div//following-sibling::div//button
${mainpage.btn_config}         xpath=//h5[text()="Configuration"]/parent::div//following-sibling::div//button


*** Keywords ***
User select AI feature
    DobbyWebCommon.Click element when ready       ${mainpage.btn_AI}

Saleuser select DRP feature
    DobbyWebCommon.Click element when ready       ${mainpage.btn_DRP}

Saleuser select VMI feature
    DobbyWebCommon.Click element when ready       ${mainpage.btn_VMI} 

Verify page title displayed correctly
    SeleniumLibrary.Title should be                         ${loginpage.title_page}

Verify ai box displayed correctly
    SeleniumLibrary.Wait until element is visible           ${mainpage.feature_AI}

Verify drp box displayed correctly
    SeleniumLibrary.Wait until element is visible           ${mainpage.feature_DRP} 

Verify vmi box displayed correctly
    SeleniumLibrary.Wait until element is visible           ${mainpage.feature_VMI}  

User select configuration feature
    DobbyWebCommon.Click element when ready                 ${mainpage.btn_config}

Verify configuration box displayed correctly
    SeleniumLibrary.Wait until element is visible           ${mainpage.feature_config}  


