*** Variables ***
${dcrc.table_information}    xpath=//td[@scope="row" and text()="{rdc_name}"]//following-sibling::td//div[text()="{value}" or .="{value}"]
${dcrc.btn_next_page}    xpath=//button[@data-test="button-pagination-next"]
${dcrc.lbl_noti_import_draf_success}    xpath=//p[text()="Your import file for import draft channels with {notification_id} is has been imported."]
${dcrc.lbl_noti_export_file}    xpath=//p[text()="Your export file for Channels with {notification_id} is ready to download."]
${dcrc.lbl_noti_errors_occurred}    xpath=//p[text()="Sorry, your import file for import draft channels with {notification_id} could not be completed, some unexpected errors occurred. {item} item is invalid. Please try again."]
${dcrc.btn_inventory}    xpath=//label[text()="Select Inventory target(value) :"]//following-sibling::div
${dcrc.btn_by_rdc}    xpath=//li[@role="menuitem" and text()="By RDC"]
${dcrc.btn_by_dc}    xpath=//li[@role="menuitem" and text()="By DC"]
${dcrc.cb_rdc}    id=mui-component-select-rdc
${dcrc.cb_dc}    id=mui-component-select-dc

*** Keywords ***
Verify information in table row should be display blue color
    [Arguments]    ${rdc_name}    ${value}    ${color}=rgba(0, 125, 255, 1)
    [Documentation]    Verify information if have some information changed should be displayed blue color
    ${information}    String.Replace string    ${dcrc.table_information}    {rdc_name}    ${rdc_name}
    ${information}    String.Replace string    ${information}    {value}    ${value}
    SeleniumLibrary.Wait until element is visible    ${information}
    ${elements}    SeleniumLibrary.Get WebElement    ${information}
    ${return_color}    Call Method    ${elements}    value_of_css_property    color
    BuiltIn.Should be equal    ${return_color}    ${color}

Click change to next page
    [Documentation]    Change to next page
    DobbyWebCommon.Click element when ready    ${dcrc.btn_next_page}

Verify notification import file draf successfully
    [Documentation]    ${notification_id} is can get notification id from API.
    [Arguments]    ${notification_id}
    ${notification}    String.Replace string    ${dcrc.lbl_noti_import_draf_success}    {notification_id}    ${notification_id}
    SeleniumLibrary.Wait until element is visible    ${notification}

Download the file through the notification export file
    [Documentation]    Verify notification export file
    [Arguments]    ${notification_id}    ${new_file_name}    ${directory}
    ${xpath}    String.Replace string    ${dcrc.lbl_noti_export_file}    {notification_id}    ${notification_id}
    DobbyWebcommon.Click element when ready    ${xpath}
    common.Check file download and move to folder    ${new_file_name}   ${directory}

Verify notification unexpected occurred id from notification page
    [Documentation]    Get notification unexpected occurred id from notification page
    [Arguments]    ${notification_id}    ${item}
    ${message}    String.Replace string    ${dcrc.lbl_noti_errors_occurred}    {notification_id}    ${notification_id}
    ${message}    String.Replace string    ${message}    {item}    ${item}
    SeleniumLibrary.Wait until element is visible    ${message}

Click expand inventory target
    [Documentation]    Click expand inventory target
    DobbyWebCommon.Click element when ready    ${dcrc.btn_inventory}

Select inventory rdc
    DobbyWebcommon.Click element when ready    ${dcrc.btn_by_rdc}

Select inventory dc
    DobbyWebcommon.Click element when ready    ${dcrc.btn_by_dc}

Expand RDC inventory
    [Documentation]    Expand RDC Inventory
    DobbyWebCommon.Click element when ready    ${dcrc.cb_rdc}

Expand DC inventory
    [Documentation]    Expand DC inventory
    DobbyWebCommon.Click element when ready    ${dcrc.cb_dc}

