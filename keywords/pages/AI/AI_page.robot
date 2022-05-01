*** Variables ***
${aipage.lbl_AI}                 xpath=//label[contains(text(),'AI')]
${aipage.menu_name}              xpath=//label[contains(text(),'***MENU_NAME***')]/parent::button
${aipage.btn_delete_all_brands}    xpath=//span[text()='All Brands']/following-sibling::*[local-name()="svg"]
${aipage.btn_all_brands}            id=mui-component-select-categoriesBrands
${aipage.lbl_confirm}           xpath=//h2[text()="Confirmation"]
${aipage.lbl_approve_msg}       xpath=//p[text()="Do you want to changes and Submit this information to Approver?"]
${aipage.btn_sutmit}            xpath=//div[contains(@class,"MuiDialogActions-root")]//button[@data-test-id="submit"]
${aipage.lbl_successfully_saved}    xpath=//p[text()="Successfully Saved"]
${aipage.lbl_approve}           xpath=//p[text()="Do you want to approve information ?"]
${aipage.lbl_successfully_approve}    xpath=//p[text()="Successfully Approved!"]
${aipage.lbl_reject}            xpath=//p[text()="Please input the reason for rejection."]
${aipage.lbl_reject_infor}      xpath=//p[text()="Do you want to reject {page} information ?"]
${aipage.lbl_sucessfully_reject}    xpath=//p[text()="Successfully Rejected!"]
${aipage.lbl_save_approve}    xpath=//p[text()="Do you want to save and approve information ?"]
*** Keywords ***
Verify AI wording is visible in top bar 
    SeleniumLibrary.Wait until element is visible       ${aipage.lbl_AI}

User clicks on menu
    [Arguments]     ${menu_name}
    ${name}    String.Replace string                    ${aipage.menu_name}    ***MENU_NAME***    ${menu_name}
    DobbyWebCommon.Click element when ready             ${name}

Menu should be visible 
    [Arguments]  ${menu_name} 
    ${name}    String.Replace string                    ${aipage.menu_name}    ***MENU_NAME***    ${menu_name}
    SeleniumLibrary.Wait until element is visible       ${name} 

Click delete all brands filter
    [Documentation]    Click delete all brands filter
    DobbyWebCommon.Click element when ready    ${aipage.btn_delete_all_brands}

Click expand filter brands
    DobbyWebCommon.Click element when ready    ${aipage.btn_all_brands}

Verify confirmation when save and submit
    SeleniumLibrary.Wait until element is visible    ${aipage.lbl_confirm}

Verify approve message
    SeleniumLibrary.Wait until element is visible    ${aipage.lbl_approve_msg}

Click button submit
    DobbyWebCommon.Click element when ready    ${aipage.btn_sutmit}

Verify successfully saved 
    SeleniumLibrary.Wait until element is visible    ${aipage.lbl_successfully_saved}

Verify message approve
    SeleniumLibrary.Wait until element is visible    ${aipage.lbl_approve}

Verify message successfully approved
    SeleniumLibrary.Wait until element is visible    ${aipage.lbl_successfully_approve}

Verify reject warning message
    [Arguments]    ${page}
    SeleniumLibrary.Wait until element is visible    ${aipage.lbl_reject}
    ${message}    String.Replace string    ${aipage.lbl_reject_infor}    {page}    ${page}
    SeleniumLibrary.Wait until element is visible    ${message}

Verify successfully reject message
    SeleniumLibrary.Wait until element is visible    ${aipage.lbl_sucessfully_reject}

Verify confirmation save and approve
    SeleniumLibrary.Wait until element is visible    ${aipage.lbl_save_approve}