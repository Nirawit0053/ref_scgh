*** Variables ***
${product_recom.title}    xpath=//div[text()="PRODUCT CLASS RECOMMENDATION"]
${product_recom.row}        xpath=//tr[@class='MuiTableRow-root']
${product_recom.result}     xpath=(//span[.="Product Class (Recommendation)"]//ancestor::table//tbody[@class="MuiTableBody-root"]//div[contains(@class,"h-full flex items-center")][4]/div)[result]
${productrecom.btn_import_csv}         xpath=//div/button[contains(@data-test,'button-upload-file')]
${productrecom.cb_class_level}      xpath=//label[text()='Select product class level :']/following-sibling::div
${productrecom.lbl_level_name}          xpath=//li[@role='menuitem' and text()='level_name']
${productrecom.txt_unpected_noti}       xpath=//p[text()="Sorry, your import file for import {page} event with {id_transaction} could not be completed, some unexpected errors occurred. {items} item is invalid. Please try again."]
${productrecom.txt_import_success}      xpath=//p[text()="Your import file for import {page} event with {transaction_id} is has been imported."]
*** Keywords ***    
Verify system landing to product recommendation page properly
    SeleniumLibrary.Wait until element is visible    ${product_recom.title}

Verify the button import file csv should be display
    SeleniumLibrary.Wait until element is visible    ${productrecom.btn_import_csv}

Verify adjust letter should be show in blue
    [Arguments]    ${color}=rgba(0, 125, 255, 1)
    ${count} =  SeleniumLibrary.Get element count     ${product_recom.row}   
    FOR    ${i}    IN RANGE  1    ${count}+1
        ${Number}    Convert to string    ${i}
        ${result}    Replace string    ${product_recom.result}    result    ${Number}
        SeleniumLibrary.Wait until element is visible    ${result}
        ${elements}    SeleniumLibrary.Get WebElement    ${result}
        ${bg_color}    Call Method    ${elements}    value_of_css_property    color
        BuiltIn.Should be equal    ${bg_color}    ${color}
    END

Select product class level
    [Documentation]    Using this keyword for show all class level
    DobbyWebCommon.Click element when ready    ${productrecom.cb_class_level}

Verify unexpected notification for productrecom
    [Arguments]    ${pages}    ${id}    ${items}
    ${page}    String.Replace string    ${productrecom.txt_unpected_noti}    {page}    ${pages}
    ${unexpected_noti}    String.Replace string    ${page}    {id_transaction}    ${id}
    ${items}    String.Replace string    ${unexpected_noti}    {items}    ${items}
    SeleniumLibrary.Wait until element is visible    ${items}

Verify notification import file successfully should be displayed
    [Arguments]    ${page}    ${transaction_id}
    ${page}    String.Replace string    ${productrecom.txt_import_success}    {page}    ${page}
    ${id}    String.Replace string    ${page}    {transaction_id}    ${transaction_id}
    SeleniumLibrary.Wait until element is visible    ${id}