*** Variables ***
${settarget.lbl_settarget}          xpath=//label[@aria-label="setTarget"]
${settarget.title_settarget}        xpath=//div[text()="Set Target"]
${settarget.cb_categories}          id=mui-component-select-categoriesMch3
${settarget.cb_status_data}         id=mui-component-select-statusData
${settarget.jan}    //span[text()='Target 2023']//ancestor::tr/following-sibling::tr//span[text()='ADJUSTMENT']/parent::td/following-sibling::td[1]/span
${settarget.feb}    //span[text()='Target 2023']//ancestor::tr/following-sibling::tr//span[text()='ADJUSTMENT']/parent::td/following-sibling::td[2]/span
${settarget.mar}    //span[text()='Target 2023']//ancestor::tr/following-sibling::tr//span[text()='ADJUSTMENT']/parent::td/following-sibling::td[3]/span
${common.txt_notification_settarget}        xpath=//p[text()="Sorry, your import file for import category target set value with {transaction_id} could not be completed. This file is invalid, Please try again."]

${settarget.adjustment_cell}    //span[text()='Target year']//ancestor::tr/following-sibling::tr//span[text()='ADJUSTMENT']/parent::td/following-sibling::td[month]/span
${settarget.current_cell}    //span[text()='Target year']//ancestor::tr/following-sibling::tr//span[text()='Current']/parent::td/following-sibling::td[month]
${settarget.btn_import_csv}         xpath=//div/button[contains(@data-test,'button-upload-file')]
${settarget.txt_settarget_invalid}    xpath=//p[text()="Sorry, your import file for import category target set value with {transaction_id} could not be completed, some unexpected errors occurred. {items_invalid} item is invalid. Please try again."]

*** Keywords ***
Verify the button import file csv should be display
    SeleniumLibrary.Wait until element is visible    ${settarget.btn_import_csv}

Verify settarget combo status data is visible
    SeleniumLibrary.Wait until element is visible    ${settarget.cb_status_data} 

Verify settarget label is visible  
    SeleniumLibrary.Wait until element is visible    ${settarget.lbl_settarget}

Verify settarget title is visible 
    SeleniumLibrary.Wait until element is visible    ${settarget.title_settarget}

Verify settarget combo categories is visible
    SeleniumLibrary.Wait until element is visible    ${settarget.cb_categories}

Verify sale target should be displayed in blue
    [Arguments]    ${sale_target_jan}     ${sale_target_feb}     ${sale_target_mar}   ${color}=rgba(0, 125, 255, 1)
    SeleniumLibrary.Wait until element contains         ${settarget.jan}      ${settarget['sale_target']['jan']}
    SeleniumLibrary.Wait until element contains         ${settarget.feb}      ${settarget['sale_target']['feb']}
    SeleniumLibrary.Wait until element contains         ${settarget.mar}      ${settarget['sale_target']['mar']}
    SeleniumLibrary.Wait until element is visible       ${settarget.jan}
    SeleniumLibrary.Wait until element is visible       ${settarget.feb}
    SeleniumLibrary.Wait until element is visible       ${settarget.mar}

    ${elm_jan}    SeleniumLibrary.Get WebElement    ${settarget.jan}
    ${bg_color}    Call Method    ${elm_jan}    value_of_css_property    color
    BuiltIn.Should be equal    ${bg_color}    ${color}

    ${elm_feb}    SeleniumLibrary.Get WebElement    ${settarget.feb}
    ${bg_color}    Call Method    ${elm_feb}    value_of_css_property    color
    BuiltIn.Should be equal    ${bg_color}    ${color}

    ${elm_mar}    SeleniumLibrary.Get WebElement    ${settarget.mar}
    ${bg_color}    Call Method    ${elm_mar}    value_of_css_property    color
    BuiltIn.Should be equal    ${bg_color}    ${color}

Verify sale target is displayed correctly
    [Arguments]     ${verify_cell}  ${file_name}    ${row}    ${col}    ${year}   ${month}      ${font_color}    ${background_color}     

    ${listcsv}    common.Get all data from csv file    ${file_name}   
    ${row} =    Builtin.Set variable        ${row}
    ${col} =    Builtin.Set variable        ${col}
    ${expected_value}    common.Reformat amount to currency    ${listcsv[${row}][${col}]}

    ${target_year}=     Builtin.Convert to string    ${year}
    ${target_month}=    Builtin.Convert to string    ${month}  
    ${cell}    String.Replace string    ${verify_cell}    year    ${target_year}
    ${cell}    String.Replace string    ${cell}    month    ${target_month}  
    SeleniumLibrary.Wait until element contains         ${cell}       ${expected_value}
    SeleniumLibrary.Wait until element is visible       ${cell}
    
    ${elm}    SeleniumLibrary.Get WebElement    ${cell}
    ${bg_color}    Call Method    ${elm}    value_of_css_property    color
    BuiltIn.Should be equal    ${bg_color}    ${font_color}

    ${back_color}    Call Method    ${elm}    value_of_css_property    background-color
    BuiltIn.Should be equal    ${back_color}    ${background_color}

    IF  "${verify_cell}" == "${settarget.current_cell}"
        ${cell}    String.Replace string    ${settarget.adjustment_cell}    year    ${target_year}
        ${cell}    String.Replace string    ${cell}    month    ${target_month}
        SeleniumLibrary.Wait until element contains         ${cell}       -
        SeleniumLibrary.Wait until element is visible       ${cell}
        ${elm}    SeleniumLibrary.Get WebElement    ${cell}
        ${bg_color}    Call Method    ${elm}    value_of_css_property    color
        BuiltIn.Should be equal    ${bg_color}    rgba(0, 0, 0, 0.75)
        ${back_color}    Call Method    ${elm}    value_of_css_property    background-color
        BuiltIn.Should be equal    ${back_color}    rgba(0, 0, 0, 0)
    END

Get expected settarget notification unexpected message
    [Documentation]    ${message_email} is message displayed on email
    ...    ${transaction_id} is id transaction
    ...    ${items} is quantity invalid in file 
    [Arguments]    ${message_email}    ${transaction_id}      ${items}
    ${id}    String.Replace string    ${message_email}    {transaction_id}    ${transaction_id}
    ${items}    String.Replace string    ${id}    {items_invalid}    ${items}
    [Return]    ${items}

Verify settarget unexpected notification
    [Arguments]        ${id}    ${items}
    ${unexpected_noti}    String.Replace string    ${settarget.txt_settarget_invalid}    {transaction_id}    ${id}
    ${items}    String.Replace string    ${unexpected_noti}    {items_invalid}    ${items}
    SeleniumLibrary.Wait until element is visible    ${items}

Click settarget unexpected notification
    [Arguments]    ${id}    ${items} 
    ${unexpected_noti}    String.Replace string    ${settarget.txt_settarget_invalid}    {transaction_id}    ${id}
    ${items}    String.Replace string    ${unexpected_noti}    {items_invalid}    ${items}
    DobbyWebCommon.Click element when ready    ${items}

Update csv file before import file settarget
    [Arguments]     ${file_name}        ${row}      ${col}     
    ${path_name}   OperatingSystem.Join path    ${CURDIR}${/}..${/}..${/}..${/}resources${/}csv_data${/}${file_name}.csv
    ${listcsv}     CsvLibrary.Read csv file to list    ${path_name}
    ${amount}=  Builtin.Convert to number       ${listcsv[${row}][${col}]}      
    ${value}    Builtin.Evaluate    ${amount} + 1
    ${value}    Builtin.Convert to string    ${value}   
    ${listUpdateValue}      Collections.Convert to list          ${listcsv[${row}]} 
    Remove from list     ${listUpdateValue}      ${col}
    Insert into list     ${listUpdateValue}      ${col}       ${value}
    Remove from list     ${listcsv}      ${row}
    Insert into list     ${listcsv}      ${row}      ${listUpdateValue}
    CsvLibrary.Empty csv file       ${path_name}
    CsvLibrary.Append to csv file   ${path_name}    ${listcsv}
    [Return]       ${listcsv}
    
Verify settarget after import file filed notifiction should be warning
    [Arguments]    ${id_transaction}
    ${transec}    String.Replace string    ${common.txt_notification_settarget}    {transaction_id}    ${id_transaction}
    SeleniumLibrary.Wait until element is visible    ${transec}
    
Click settarget notification accroding transaction id
    [Arguments]    ${id_transaction}
    ${transec}    String.Replace string    ${common.txt_notification_settarget}     {transaction_id}    ${id_transaction}
    DobbyWebCommon.Click element when ready    ${transec}
