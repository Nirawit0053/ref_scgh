*** Variables ***
${common.lbl_process}           xpath=//div[.="Processing..."]
${common.lbl_eta_time}          xpath=//div[.="Estimated time : 10 second(s)"]
${common.lbl_upload_complete}   xpath=//span[text()="This information has been imported"]
${common.button_name}           xpath=//span[@class="MuiButton-label" and text()="button_name"]/parent::button
${common.btn_import_csv}        id=fileUpload
${common.td_number}             xpath=//tbody/tr/td[text()="{categories_code}"]/following::td[text()="{brand_name}"]/following-sibling::td//span[text()="ADJUST (value)"]/following::td/span[text()="{price}"]
${common.lbl_modal_discard}     xpath=//p[text()="Are you sure you want to discard? All the information will be permanently deleted"]
${common.btn_modal_discard}     xpath=//div[contains(@class,"MuiDialogActions-root")]//button[@data-test-id="submit"]
${common.lbl_modal_discard_successful}    xpath=//p[text()="Successfully Canceled!"]
${common.terminate_dropdown}     xpath=//div[@class="px-6"]
${common.cb_categories_name}     xpath=(//span[contains(@class,"MuiTypography-root") and text()="categories_name"]//ancestor::span)[1]
${common.lbl_msg_error_import}              xpath=//span[contains(@class,"font-semibold") and text()="This file is invalid, Please try again."]
${common.lbl_msg_duplicated_records}        xpath=//span[contains(@class,"font-semibold") and text()="There are duplicated records with different value. Please recheck!"]
${common.disabled_button}                   xpath=//span[@class="MuiButton-label" and text()="button_name"]//parent::button[contains(@class,"Mui-disabled") and @disabled]
${common.btn_notication}                    xpath=//button[contains(@class,"MuiButtonBase-roo") and @aria-label="notification"]
${common.btn_view_all}                      xpath=//button/span[@class="MuiButton-label"]/a[text()="View All"]
${common.txt_notification}                  xpath=//p[text()="Sorry, your import file for import category forecast adjustment with {transaction_id} could not be completed. This file is invalid, Please try again."]
${common.btn_close_system_require}          xpath=//button[@aria-label="Close"]
${common.cb_all_cate}                       xpath=//div[@class="MuiListItemText-root"]//span[text()="All Categories"]
${common.txt_get_unpected_noti}             xpath=(//p[contains(text(),"could not be completed, some unexpected errors occurred.")])[1]
${common.article_number}                    xpath=//input[@name='articleNumber']
${common.txt_unpected_noti}                 xpath=//p[text()="Sorry, your import file for import category {page} adjustment with {id_transaction} could not be completed, some unexpected errors occurred. {items} item is invalid. Please try again."]
${common.btn_back}                          xpath=//button[@class="MuiButtonBase-root MuiIconButton-root" and @aria-label="arrow"]
${common.export_file}                       xpath=//button[contains(@class,"MuiButtonBase-root ") and contains(.,"Export for edit")]
${common.lbl_invalide_export}               xpath=//span[text()="{items} items are invalid, Please export file for detail."]
${common.cb_franchise}                      id=mui-component-select-franchise
${common.cb_rdc_categories}                 id=mui-component-select-rdc
${common.cb_dc_categories}                 id=mui-component-select-dc
${common.franchises_name}                   xpath=(//span[contains(@class,"MuiTypography-root") and text()="franchises_name"]//ancestor::span)[1] 
${common.search}                            xpath=//input[@placeholder="Search"]
${common.search_articlename}                name=articleName
${common.lbl_warning_imported}              xpath=//span[text()="{x} items has been imported"]
${common.lbl_warning_export_invalid}        xpath=//span[text()="{x} item is invalid, Please export file for detail."]
${common.lbl_import_file_success}    xpath=//p[text()="Your import file for import category {page} adjustment with {transaction_id} is has been imported."]
${common.btn_user}    xpath=//button[@aria-label="user"]
${common.btn_logout}    xpath=//li[@data-test="logOutButton"]
${common.txt_search}             xpath=//input[@placeholder="Search"]
${common.cb_mch1_categories}     id=mui-component-select-categoriesMch1
${common.cb_mch2_categories}     id=mui-component-select-categoriesMch2
${common.cb_mch3_categories}     id=mui-component-select-categoriesMch3
${common.txt_notification_imported}       xpath=//p[text()="Your import file for import category target set value with {transaction_id} is has been imported."]
${common.txt_settarget_invalid}    xpath=//p[text()="Sorry, your import file for import category target set value with {transaction_id} could not be completed, some unexpected errors occurred. {items_invalid} item is invalid. Please try again."]
${common.lbl_cate_name}          xpath=//span[@class="MuiChip-label" and text()="categories_name"]
${common.lbl_import_file_min_max}    xpath=//p[text()="Your import file for import product {page} event with {transection_id} is has been imported."]
${common.lbl_rdc}     id=mui-component-select-rdc
${common.rdc_categories_name}     xpath=//span[contains(@class,"MuiTypography-root") and text()="{rdc_categories_name}"]
${common.dc_categories}     xpath=//span[contains(@class,"MuiTypography-root") and text()="{dc_categories}"]
${common.lbl_export_file}    xpath=//p[text()="Your export file for {page} with {notification_id} is ready to download."]
${common.lbl_request_export_file}    xpath=//p[text()="We've received your request to export {page}, your request ID is {notification_id}."]

#SAVE #REJECT #DISCARD
${common.lbl_modal_action}    xpath=//p[text()="message"]
${common.btn_modal_action}    xpath=//div[contains(@class,"MuiDialogActions-root")]//button[@data-test-id="submit"]
${common.lbl_modal_action_successful}    xpath=//p[text()="action_done"]

*** Keywords ***
SCG suite setup
    ${directory_download}    DobbyWebCommon.Open chrome browser    url=${url['link']}    with_download_dir=${TRUE}
    SeleniumLibrary.Set selenium timeout    ${global_timeout}
    SeleniumLibrary.Maximize browser window
    BuiltIn.Set Library search order    SeleniumLibrary     AppiumLibrary   DobbyWebCommon  DobbyCommon
    [Return]    ${directory_download}

SCG suite teardown
    DobbyWebCommon.Default test teardown

Close alert 
    DobbyWebCommon.Click element when ready  xpath=//button[@aria-label='Close']

Click button using name
    [Documentation]    ${button_name} is name of button page such a Apply , Reset , Edit , Discard , Cancel
    [Arguments]    ${name_button}
    ${button}    String.Replace string    ${common.button_name}    button_name    ${name_button}
    DobbyWebCommon.Click element when ready    ${button}

Verify button using name
    [Documentation]    ${button_name} is name of button page such a Apply , Reset , Edit , Discard , Cancel
    [Arguments]    ${name_button}
    ${button}    String.Replace string    ${common.button_name}    button_name    ${name_button}
    SeleniumLibrary.Wait until element is visible    ${button}

Click the button import csv file
    DobbyWebCommon.Click element when ready    ${common.btn_import_csv}     only_contains=${TRUE}

Verify the button import file csv should be display
    SeleniumLibrary.Wait until element is visible    ${common.btn_import_csv}

Verify the button according name
    [Documentation]    ${button_name} is name of button page such a Apply , Reset , Edit , Discard , Cancel
    [Arguments]    ${name_button}
    ${button}    String.Replace string    ${common.button_name}    button_name    ${name_button}
    SeleniumLibrary.Wait until element is visible    ${button}

Select categories name
    [Arguments]    ${name_category}
    ${name}    String.Replace string            ${common.cb_categories_name}    categories_name    ${name_category}   
    DobbyWebCommon.Click element when ready     ${name}
    SeleniumLibrary.Double click element        ${common.terminate_dropdown}

Input search categories name
    [Arguments]    ${categories_name}
    DobbyWebCommon.Input text to element when ready    ${common.txt_search}    ${categories_name}

Choose csv file
    [Documentation]    ${file_name} is name of file csv in resources/csv_data 
    ...    example    file name is common.csv -- sent arguments common in test cases.
    [Arguments]    ${folder_name}       ${file_name}    ${File_extension}=csv
    ${path_name}    OperatingSystem.Join path    ${CURDIR}${/}..${/}resources${/}${folder_name}${/}${file_name}.${File_extension}
    DobbyWebCommon.Browse file when ready    ${common.btn_import_csv}    ${path_name}

Verify wording after choose file 
    [Documentation]     Verify wording after choose file 
    ${10_sec_status}=     BuiltIn.Run keyword and return status       SeleniumLibrary.Wait until element is visible           ${common.lbl_process}
    ${success_status}=     BuiltIn.Run keyword and return status      SeleniumLibrary.Wait until element is visible           ${common.lbl_eta_time}
    ${final_result}=     Evaluate  ${10_sec_status} or ${success_status}
    BuiltIn.Should be true    ${final_result}
    SeleniumLibrary.Wait until element is not visible       ${common.lbl_process}
    SeleniumLibrary.Wait until element is not visible       ${common.lbl_eta_time}

Verify wording upload successfully
    SeleniumLibrary.Wait until element is visible           ${common.lbl_upload_complete}

Verify notification on modal popup while discard
    SeleniumLibrary.Wait until element is visible    ${common.lbl_modal_discard}

Click button discard on modal popup
    DobbyWebCommon.Click element when ready    ${common.btn_modal_discard} 

Verify notification on modal popup while discard successfully
    SeleniumLibrary.Wait until element is visible    ${common.lbl_modal_discard_successful}

Click button ok on modal popup
    DobbyWebCommon.Click element when ready    ${common.btn_modal_discard}

Clear fill input
    [Arguments]    ${locator}
    DobbyWebCommon.Manually clear input from textbox    ${locator}

Get data from csv file
    [Arguments]    ${file_name}    ${column_name}    ${rowindex}
    ${rowindex}         BuiltIn.evaluate    ${rowindex}+1
    ${path_name}        OperatingSystem.Join path    ${CURDIR}${/}..${/}resources${/}csv_data${/}${file_name}.csv
    ${listcsv}          CsvLibrary.Read csv file to list    ${path_name}
    ${index}            Collections.Get index from list    ${listcsv[0]}    ${column_name}
    ${Data_inlist}      Convert To List    ${listcsv[${rowindex}]}
    [Return]    ${Data_inlist}

Get information in list
    [Arguments]    ${list_variable}    ${index}
    ${information_list}    Collections.Get from list    ${list_variable}    ${index}
    ${value}    Set variable    ${information_list}
    [Return]    ${value}

Convert value to currency
    [Arguments]    ${number}
    ${int}    BuiltIn.Convert To Integer    ${number}
    ${currency}    Evaluate    "{:,.2f}".format(${int})
    [Return]    ${currency}

Round decimal value
    [Arguments]    ${number}
    [Documentation]     Use for round decimal type float
    ...    example if .88(8) more than 5 will round decimal to .89 // if less than .88(5) not round decimal
    ${round_decimal}    Evaluate    "{:,.2f}".format(${number})
    [Return]    ${round_decimal}

Convert price to million baht
    [Documentation]    Convert price to million baht for check value
    [Arguments]    ${number}
    ${mb}   BuiltIn.Evaluate    ${number}/(1000**2)
    ${round_decimal}    BuiltIn.Evaluate    "{:,.2f}".format(${mb})
    ${million}    Catenate    ${round_decimal}${SPACE}MB
    [Return]    ${million}

Get all data from csv file
    [Arguments]    ${file_name}    
    ${path_name}   OperatingSystem.Join path    ${CURDIR}${/}..${/}resources${/}csv_data${/}${file_name}.csv
    ${listcsv}     CsvLibrary.Read csv file to list    ${path_name}
    [Return]       ${listcsv}

Reformat amount to currency 
    [Documentation]    Reformat amount to currency and if greater than a million will convert to x.MB
    [Arguments]    ${amount}
    IF  ${amount} >= 100000
        ${mb}   BuiltIn.Evaluate    ${amount}/(1000**2)
        ${round_decimal}    BuiltIn.Evaluate    "{:,.2f}".format(${mb})
        ${round_decimal}    Catenate    ${round_decimal}${SPACE}MB
    ELSE   
        ${round_decimal}    BuiltIn.Evaluate    "{:,.2f}".format(${amount})
    END

    [Return]        ${round_decimal}


Verify error message when import file incorrect condition
    [Documentation]   Use this keyword when check error message when import file wrong format.
    SeleniumLibrary.Wait until element is visible    ${common.lbl_msg_error_import}

Verify error message when import file with duplicated records
    [Documentation]   Use this keyword when check error message when import file wrong format.
    SeleniumLibrary.Wait until element is visible    ${common.lbl_msg_duplicated_records}

Verify button should be disabled using name
    [Documentation]    ${name_button} is name of button page such a Apply , Reset , Edit , Discard , Cancel
    [Arguments]    ${name_button}
    ${button}    String.Replace string    ${common.disabled_button}    button_name    ${name_button}
    SeleniumLibrary.Wait until element is visible    ${button}

Click expand notification  
    DobbyWebCommon.Click element when ready    ${common.btn_notication}

Click button view all notication
    DobbyWebCommon.Click element when ready    ${common.btn_view_all}

Verify notification warning upload file incorrect format
    SeleniumLibrary.Wait until element is visible    ${common.txt_notification}

Close the popup system require update
    DobbyWebCommon.Click element when ready    ${common.btn_close_system_require}

Get customer token
    [Documentation]  Get customer token
    [Arguments]    ${username}    ${passwords}
    &{header}    BuiltIn.Create dictionary    Content-Type=application/json
    ${jsonfile}     JsonLibrary.Load json from file    ${customer_body}
    ${jsonfile}    JsonLibrary.Update value to json       ${jsonfile}    $..email    ${username}
    ${jsonfile}    JsonLibrary.Update value to json       ${jsonfile}    $..password    ${passwords}
    ${response}    REST.POST    endpoint=${url['url_api']}    headers=&{header}    validate=false    body=${jsonfile}
    REST.Integer    response status    200
    ${respbody}    REST.Output    response body
    ${customer_token}    JsonLibrary.Get value from json    ${respbody}    $.data..token
    ${customer_token}    BuiltIn.Set variable    ${customer_token}[0]
    Set test variable    ${customer_token}

Get notification id
    [Documentation]  Get notification id
    &{header}    BuiltIn.Create dictionary    Content-Type=application/json    Authorization=Bearer ${customer_token}
    ${response}    REST.POST    endpoint=${url['url_api']}    headers=&{header}    validate=false    body=${notification_body}   
    REST.Integer    response status    200
    ${transaction_id}    REST.Output    response body
    ${message}    JsonLibrary.Get value from json    ${transaction_id}    $..staffNotifications.edges[0].node.content
    ${noti_message}    BuiltIn.Set variable    ${message}[0]
    ${id}    String.Get Regexp Matches    ${noti_message}    (ID\\s(\\w+)\\W+)
    ${id}    BuiltIn.Set variable    ${id}[0]
    log to console          ${id.strip()}
    [Return]        ${id.strip()} 

Verify after import file filed notifiction should be warning
    [Arguments]    ${id_transaction}
    ${transec}    String.Replace string    ${common.txt_notification}    {transaction_id}    ${id_transaction}
    SeleniumLibrary.Wait until element is visible    ${transec}

Verify notification file has been imported
    [Arguments]    ${id_transaction}
    ${tran}    String.Replace string    ${common.txt_notification_imported}    {transaction_id}    ${id_transaction}
    SeleniumLibrary.Wait until element is visible    ${tran}

Verify unexpected settarget
    [Arguments]    ${id}    ${items}
    ${unexpected_noti}    String.Replace string    ${common.txt_settarget_invalid}    {transaction_id}    ${id}
    ${items}    String.Replace string    ${unexpected_noti}    {items_invalid}    ${items}
    SeleniumLibrary.Wait until element is visible    ${items}

Click notification file imported per id
    [Arguments]    ${id_transaction}
    ${tran}    String.Replace string    ${common.txt_notification_imported}    {transaction_id}    ${id_transaction}
    DobbyWebCommon.Click element when ready    ${tran}

Click notification accroding transaction id
    [Arguments]    ${id_transaction}
    ${transec}    String.Replace string    ${common.txt_notification}    {transaction_id}    ${id_transaction}
    DobbyWebCommon.Click element when ready    ${transec}

Get expected notification message
    [Arguments]    ${message_email}    ${transaction_id}    ${page}
    ${id}    String.Replace string    ${message_email}    {id_transcript}    ${transaction_id}
    ${page}    String.Replace string    ${id}    {page}    ${page}
    [Return]    ${page}

Wait until all categories appear
    SeleniumLibrary.Wait until element is visible    ${common.cb_all_cate}

Download file for edit and move to csv folder
    [Arguments]    ${new_file_name}    ${directory}
    common.Click export file for edit
    common.Click button discard on modal popup
    common.Check file download and move to folder    ${new_file_name}   ${directory}

Expand MCH1 categoeis
    [Documentation]    Using this keyword for show all category
    DobbyWebCommon.Click element when ready    ${common.cb_mch1_categories}

Expand MCH2 categoeis
    [Documentation]    Using this keyword for show all category
    DobbyWebCommon.Click element when ready    ${common.cb_mch2_categories}

Expand MCH3 categoeis
    [Documentation]    Using this keyword for show all category
    DobbyWebCommon.Click element when ready    ${common.cb_mch3_categories}

Verify notification on modal popup while action
    [Arguments]    ${notification}
    ${msg}    String.Replace string    ${common.lbl_modal_action}    message    ${notification}
    SeleniumLibrary.Wait until element is visible    ${msg}

Click button action on modal popup
    DobbyWebCommon.Click element when ready    ${common.btn_modal_action} 

Verify notification on modal popup while action successfully
    [Arguments]    ${notification}
    ${msg}    String.Replace string    ${common.lbl_modal_action_successful}    action_done    ${notification}
    SeleniumLibrary.Wait until element is visible    ${msg}

Click button ok on modal popup after action successfully
    DobbyWebCommon.Click element when ready    ${common.btn_modal_action}

Verify categories ch2 should be display
    [Documentation]    Using this keyword for show all category
    SeleniumLibrary.Wait until element is visible    ${common.cb_mch2_categories}

Get unexpected notification
    [Documentation]    Get message unexpected accroding page
    ${text}    DobbyWebCommon.Get text from element when ready    ${common.txt_get_unpected_noti}
    ${id}    String.Get Regexp Matches    ${text}    (ID\\s(\\w+)\\W+)
    ${id}    BuiltIn.Set variable    ${id}[0]
    [Return]    ${id.strip()}

Verify unexpected notification
    [Arguments]    ${pages}    ${id}    ${items}
    ${page}    String.Replace string    ${common.txt_unpected_noti}    {page}    ${pages}
    ${unexpected_noti}    String.Replace string    ${page}    {id_transaction}    ${id}
    ${items}    String.Replace string    ${unexpected_noti}    {items}    ${items}
    SeleniumLibrary.Wait until element is visible    ${items}

Get expected notification unexpected message
    [Documentation]    ${message_email} is message displayed on email
    ...    ${transaction_id} is id transaction
    ...    ${page} page will be displayed accordding to page
    ...    ${items} is quantity invalid in file 
    [Arguments]    ${message_email}    ${transaction_id}    ${page}    ${items}
    ${id}    String.Replace string    ${message_email}    {id_transaction}    ${transaction_id}
    ${pages}    String.Replace string    ${id}    {page}    ${page}
    ${items}    String.Replace string    ${pages}    {items}    ${items}
    [Return]    ${items}

Click button back
    [Documentation]    click button back
    DobbyWebCommon.Click element when ready    ${common.btn_back}

Check file download and move to folder
    [Documentation]    ${new_file_name} is new name when move to csv_data
    [Arguments]    ${new_file_name}    ${directory}
    ${current_file}    DobbyCommon.Wait until download is completed    ${directory}    wait_time=10s
    ${path_name}    OperatingSystem.Join path    ${CURDIR}${/}..${/}resources${/}csv_data${/}${new_file_name}.csv
    OperatingSystem.Move file    ${current_file}    ${path_name}
    [Return]    ${path_name}

Click export file for edit
    DobbyWebCommon.Click element when ready    ${common.export_file}

Get export file id
    [Documentation]  Get id transaction id from API 
    &{header}    BuiltIn.Create dictionary    Content-Type=application/json    Authorization=Bearer ${customer_token}
    ${response}    REST.POST    endpoint=${url['url_api']}    headers=&{header}    validate=false    body=${export_body}  
    REST.Integer    response status    200
    ${id}    REST.Output    response body
    ${message}    JsonLibrary.Get value from json    ${id}    $..exportFile.id
    ${id}    BuiltIn.Set variable    ${message}[0]
    [Return]        ${id} 

Get export file information
    [Documentation]  Get export file information from API use this keywords after get export file id
    [Arguments]    ${export_id}
    &{header}    BuiltIn.Create dictionary    Content-Type=application/json    Authorization=Bearer ${customer_token}
    ${jsonfile}     JsonLibrary.Load json from file    ${export_details_body}
    ${jsonfile}    JsonLibrary.Update value to json       ${jsonfile}    $..id    ${export_id}
    ${response}    REST.POST    endpoint=${url['url_api']}    headers=&{header}    validate=false    body=${jsonfile}
    REST.Integer    response status    200
    ${export_details_body}    REST.Output    response body
    ${export_details_body}    JsonLibrary.Get value from json    ${export_details_body}    $..exportFile.id
    ${export_details_body}    BuiltIn.Set variable    ${export_details_body}[0]
    [Return]        ${export_details_body} 

Verify warning message item invalid displayed
    [Arguments]    ${items_each}
    [Documentation]    ${items_each}  is quantity of item invalid when import file csv
    ${message}    String.Replace string    ${common.lbl_invalide_export}    {items}    ${items_each}
    SeleniumLibrary.Wait until element is visible    ${message}

Input article name
    [Arguments]    ${article_name}
    DobbyWebCommon.Input text to element when ready     ${common.search_articlename}       ${article_name}

Expand franchise store
    [Documentation]    Using this keyword for show all franchise store
    DobbyWebCommon.Click element when ready    ${common.cb_franchise}

Expand RDC categories
    [Documentation]    Using this keyword for show all category
    DobbyWebCommon.Click element when ready    ${common.cb_rdc_categories}

Expand DC categories
    [Documentation]    Using this keyword for show all category
    DobbyWebCommon.Click element when ready    ${common.cb_dc_categories}

Input article number
    [Arguments]    ${article_num}
    DobbyWebCommon.Input text to element when ready    ${common.article_number}    ${article_num}

Input franchise store name
    [Arguments]    ${franchise_name}
    DobbyWebCommon.Input text to element when ready     ${common.txt_search}    ${franchise_name}

Select franchise store name
    [Arguments]    ${franchises_name}
    ${name}    String.Replace string            ${common.franchises_name}    franchises_name    ${franchises_name}
    DobbyWebCommon.Click element when ready     ${name}
    SeleniumLibrary.Double click element        ${common.terminate_dropdown} 

Verify warning message items import successfully
    [Documentation]  Use this keyword when import file success x items 
    [Arguments]    ${items_success} 
    ${message}    String.Replace string    ${common.lbl_warning_imported}    {x}    ${items_success}
    SeleniumLibrary.Wait until element is visible    ${message}

Verify warning message items invalid
    [Documentation]  Use this keyword when import file invalid x items
    [Arguments]       ${items_invalid}
    ${invalid_message}    String.Replace string    ${common.lbl_warning_export_invalid}    {x}    ${items_invalid}
    SeleniumLibrary.Wait until element is visible    ${invalid_message}

Click unexpected notification
    [Arguments]    ${pages}    ${id}    ${items}
    ${page}    String.Replace string    ${common.txt_unpected_noti}    {page}    ${pages}
    ${unexpected_noti}    String.Replace string    ${page}    {id_transaction}    ${id}
    ${items}    String.Replace string    ${unexpected_noti}    {items}    ${items}
    DobbyWebCommon.Click element when ready    ${items}

Copy file to directory
    [Arguments]    ${oldfile}    ${newfile}
    ${oldname}    OperatingSystem.Join path    ${CURDIR}${/}..${/}resources${/}csv_data${/}${oldfile}.csv
    ${newname}    OperatingSystem.Join path    ${CURDIR}${/}..${/}resources${/}csv_data${/}${newfile}.csv
    OperatingSystem.Copy file    ${oldname}    ${newname}

Update csv file from column and row
    [Documentation]    Update csv file from column and row
    [Arguments]   ${file_name}    ${columnname}    ${rowindex}    ${value}
    ${rowindex}    BuiltIn.Evaluate    ${rowindex}+1
    ${path_file}    OperatingSystem.Join path    ${CURDIR}${/}..${/}resources${/}csv_data${/}${file_name}.csv
    ${listcsv}    CSVLibrary.Read csv file to list    ${path_file}
    CSVLibrary.Empty Csv File     ${path_file}
    ${index}    Collections.Get index from list    ${listcsv[4]}    ${columnname}
    ${listupdatevalue}    Collections.Convert to list    ${listcsv[${rowindex}]}
    Collections.Remove from list    ${listupdatevalue}    ${index}
    Collections.Insert into list    ${listupdatevalue}    ${index}    ${value}
    Collections.Remove from list    ${listcsv}    ${rowindex}
    Collections.Insert into list    ${listcsv}    ${rowindex}    ${listupdatevalue}
    CSVLibrary.Append To Csv File        ${path_file}    ${listcsv}

Verify notification import file successfully should be displayed
    [Arguments]    ${page}    ${transaction_id}
    ${page}    String.Replace string    ${common.lbl_import_file_success}    {page}    ${page}
    ${id}    String.Replace string    ${page}    {transaction_id}    ${transaction_id}
    SeleniumLibrary.Wait until element is visible    ${id}

Get notification message from email
    [Arguments]    ${exp_page}      ${username}    ${password}    ${folder}    ${noti_id}    ${sender}=${account['sender_email']['acc_01']}
    [Documentation]    ${username} is username of email
    ...    ${password} is password of email
    ...    ${folder} is folder receive email
    ...    ${noti_id} is notification id get from API 
    ...    ${sender} is sender of system default (admin-scgh-retail-dev@scg-wedo.tech)

    ImapLibrary2.Open Mailbox    host=imap.gmail.com    user=${username}    password=${password}
    ${mailbox}    ImapLibrary2.Wait for email    
                    ...     sender=${sender}    
                    ...     recipient=${username}   folder=${folder}  
                    ...     status=unseen   text=${noti_id}     timeout=120
    ${parts}=      ImapLibrary2.Walk Multipart Email    ${mailbox}
    FOR    ${i}    IN RANGE    ${parts}
        ImapLibrary2.Walk Multipart Email    ${mailbox}
        ${content-type} =    ImapLibrary2.Get Multipart Content Type
        Continue For Loop If    '${content-type}' != 'text/plain'
        ${payload} =    ImapLibrary2.Get Multipart Payload    decode=True 
        ${html_text} =    extract_file.extract_file_html    ${payload}
        log        ${html_text}
    END
    ${html_text_1}    String.Replace string    ${html_text}    ${SPACE}    ${EMPTY}
    ${html_text_1}    String.Replace string    ${html_text}    \r\n    ${EMPTY}
    ${html_text_2}    String.Replace string    ${html_text_1}    "    ${EMPTY}
    ${html_text_4}    String.Get regexp matches    ${html_text_2}       ${exp_page}
    ${html_text_5}    BuiltIn.Set variable    ${html_text_4}[0]
    ${html_text_6}    String.Replace string using regexp    ${html_text_5}    ID     ID${SPACE}
    [Return]    ${html_text_6.strip()}

Click button user
    DobbyWebCommon.Click element when ready    ${common.btn_user} 

Click button logout
    DobbyWebCommon.Click element when ready    ${common.btn_logout}

Update csv file
    [Documentation]    Update csv file from column and row
    [Arguments]   ${file_name}    ${columnname}    ${rowindex}    ${value}
    ${rowindex}    BuiltIn.Evaluate    ${rowindex}+1
    ${path_file}    OperatingSystem.Join path    ${CURDIR}${/}..${/}resources${/}csv_data${/}${file_name}.csv
    ${listcsv}    CSVLibrary.Read csv file to list    ${path_file}
    CSVLibrary.Empty Csv File     ${path_file}
    ${index}    Collections.Get index from list    ${listcsv[0]}    ${columnname}
    ${listupdatevalue}    Collections.Convert to list    ${listcsv[${rowindex}]}
    Collections.Remove from list    ${listupdatevalue}    ${index}
    Collections.Insert into list    ${listupdatevalue}    ${index}    ${value}
    Collections.Remove from list    ${listcsv}    ${rowindex}
    Collections.Insert into list    ${listcsv}    ${rowindex}    ${listupdatevalue}
    CSVLibrary.Append To Csv File        ${path_file}    ${listcsv}

Ensure categories name select correctly
    [Arguments]    ${categories_name}
    ${cate_name}    String.Replace string            ${common.lbl_cate_name}    categories_name    ${categories_name}
    SeleniumLibrary.Wait until element is visible    ${cate_name}

Get email body then return to text
    [Arguments]      ${username}    ${password}    ${folder}    ${sender}=${account['sender_email']['acc_01']}
    ImapLibrary2.Open mailbox      host=imap.gmail.com       user=${username}    password=${password}
    ${index}=      ImapLibrary2.Wait for email    sender=${sender}    recipient=${username}   folder=${folder}   status=unseen  
    ${parts}=      ImapLibrary2.Walk Multipart Email    ${index}
    FOR    ${i}    IN RANGE    ${parts}
        ImapLibrary2.Walk Multipart Email    ${index}
        ${content-type} =    ImapLibrary2.Get Multipart Content Type
        Continue For Loop If    '${content-type}' != 'text/html'
        ${payload} =    ImapLibrary2.Get Multipart Payload    decode=True 
        ${payload} =    extract_file.extract_file_html    ${payload}
        log        ${payload}
    END
    ImapLibrary2.Delete All Emails
    ImapLibrary2.Close Mailbox
    [Return]    ${payload}

Remove the whitespace from messages then compare 
    [Documentation]    Use keyword for remove all space 
    [Arguments]    ${message1}   ${message2}
    ${actual_result}    String.Remove string    ${message1}    ${SPACE}
    ${expected_result}    String.Remove string    ${message2}    ${SPACE}
    BuiltIn.Should be equal    ${actual_result}    ${expected_result}

Verify notification export file is ready should be displayed
    [Arguments]    ${page}    ${notification_id}
    ${lbl_message}    String.Replace string    ${common.lbl_export_file}    {page}    ${page}
    ${lbl_message}    String.Replace string    ${lbl_message}    {notification_id}    ${notification_id}
    SeleniumLibrary.Wait until element is visible    ${lbl_message}

Verify notification request export file should be displayed
    [Arguments]    ${page}    ${notification_id}
    ${lbl_message}    String.Replace string    ${common.lbl_request_export_file}    {page}    ${page}
    ${lbl_message}    String.Replace string    ${lbl_message}    {notification_id}    ${notification_id}
    SeleniumLibrary.Wait until element is visible    ${lbl_message}

Get notification message export file from email
    [Arguments]    ${username}    ${password}    ${foloder}    ${noti_id}    ${sender}=${account['sender_email']['acc_01']}
    ImapLibrary2.Open Mailbox    host=imap.gmail.com    user=${username}    password=${password}
    ${mailbox}    ImapLibrary2.Wait for email    sender=${sender}    recipient=${username}   folder=${foloder}  status=unseen   text=${body_email['export_file']}${SPACE}${noti_id}
    ${mailbox}    ImapLibrary2.Get email body    ${mailbox}
    ${mailbox}    String.Replace string    ${mailbox}    \r\n    ${EMPTY}
    ${mailbox}    String.Replace string    ${mailbox}    "    ${EMPTY}
    ${mailbox}    String.Get regexp matches    ${mailbox}    (You'?.*Version.*?.)
    ${mailbox}    String.Get regexp matches    ${mailbox}[0]    (Export?.*download.*?.)
    ${mailbox}    BuiltIn.Set variable    ${mailbox}[0]
    ${mailbox}    String.Replace string using regexp    ${mailbox}    ID     ID${SPACE}
    [Return]    ${mailbox}

Get notification message start preparing export data from email
    [Arguments]    ${username}    ${password}    ${foloder}    ${noti_id}    ${sender}=${account['sender_email']['acc_01']}
    ImapLibrary2.Open Mailbox    host=imap.gmail.com    user=${username}    password=${password}
    ${mailbox}    ImapLibrary2.Wait for email    sender=${sender}    recipient=${username}   folder=${foloder}  status=unseen   text=${body_email['export_request']}${SPACE}${noti_id}
    ${mailbox}    ImapLibrary2.Get email body    ${mailbox}
    ${mailbox}    String.Replace string    ${mailbox}    \r\n    ${EMPTY}
    ${mailbox}    String.Replace string    ${mailbox}    "    ${EMPTY}
    ${mailbox}    String.Get regexp matches    ${mailbox}    (You'?.*Version.*?.)
    ${mailbox}    String.Get regexp matches    ${mailbox}[0]    (Start?.*ID.*?.[a-zA-Z0-9]{1,23}.)
    ${mailbox}    BuiltIn.Set variable    ${mailbox}[0]
    ${mailbox}    String.Replace string using regexp    ${mailbox}    ID     ID${SPACE}
    [Return]    ${mailbox}
