*** Settings ***
Resource    ${CURDIR}/../../../keywords/imports.robot
Test Setup         common.SCG suite setup    
Test Teardown      common.SCG suite teardown

** Test Cases ***
Verify that user able to reimport successfully
    [Tags]          QTM-1056
    # case1  import invalid data
    ${directory_download}    common.SCG suite setup
    login_feature.User login via email and password     ${account['saleuser']['acc_03']['username']}        ${account['saleuser']['acc_03']['password']}
    common.Get customer token    ${account['saleuser']['acc_03']['username']}        ${account['saleuser']['acc_03']['password']}   
    main_feature.Verify saleuser login success
    common.Close the popup system require update
    main_page.User Select AI Feature
    AI_feature.Verify AI page is displayed correctly for user 
    AI_page.User Clicks On Menu         ${menu_name['ai_page']['menu_settarget']}
    settarget_feature.Verify system landing to settarget page properly
    common.Expand MCH3 categoeis
    common.Clear fill input                 ${common.txt_search}     
    common.Select categories name           name_category=${MCH3_category['all_category']} 
    common.Click button using name          ${button_name['btn_apply']}
    common.Click button using name          ${button_name['btn_edit']} 
    common_feature.After click button edit all of these button should be display properly
    settarget_page.Verify the button import file csv should be display
    common.Choose csv file  ${folder_name['csv_data']}        ${settarget['csv_file']['QTM-1056-invalid']}      ${file_extension['csv']}  
    common.Verify wording after choose file     
    common.Verify warning message items invalid    ${QTM_1056['item']}
    # case2 Export for Edit 
    common.Download file for edit and move to csv folder    ${QTM_1056['new_file_name']}    ${directory_download}
    ${export_id}    common.Get export file id
    ${export_details}    common.Get export file information    ${export_id}  
    ${reason}    forecast_page.Get the reason invalid file    ${QTM_1056['new_file_name']}    ${error_message['value_invalid']}           
    BuiltIn.Should be equal    ${reason}    ${error_message['value_invalid']}           strip_spaces=True
    ${actual_get_export_file}    common.Get notification message from email
                                    ...    ${reg_ex_page['export_msg']}
                                    ...    ${account['saleuser']['acc_03']['username']}
                                    ...    ${account['saleuser']['acc_03']['password']}
                                    ...    ${QTM_1056['folder_email']}
                                    ...    ${export_details} 

    ${expect_get_export_file}    common.Get expected notification message    
                                ...     ${notification_message['export_request_success']}    
                                ...     ${export_details}    
                                ...     ${page['settarget']}
    BuiltIn.Should be equal    ${actual_get_export_file}    ${expect_get_export_file}         strip_apaces=Tru
    DobbyWebCommon.Scroll to top of page using java script
    common.Click expand notification 
    ${noti_id}    common.Get notification id
    SeleniumLibrary.Double click element        ${common.terminate_dropdown}
    ${unexpected_id}        common.Get unexpected notification
    settarget_page.Verify settarget unexpected notification    ${unexpected_id}    ${QTM_1056['item']}     
    settarget_page.Click settarget unexpected notification    ${unexpected_id}    ${QTM_1056['item']}       

    ${actual_notifiction_mail}    common.Get notification message from email
                                    ...    ${reg_ex_page['settarget']}
                                    ...    ${account['saleuser']['acc_03']['username']}
                                    ...    ${account['saleuser']['acc_03']['password']}
                                    ...    ${QTM_1056['folder_email']}
                                    ...    ${unexpected_id}          
    ${expected_notification}    settarget_page.Get expected settarget notification unexpected message     ${notification_message['invalid_target_data']}    ${unexpected_id}
    ...   ${QTM_1056['item']}

    ${headles}    SeleniumLibrary.Get window handles
    SeleniumLibrary.Switch Window    ${headles}[1]
    settarget_feature.Verify system landing to settarget page properly
    BuiltIn.Should be equal     ${actual_notifiction_mail}      ${expected_notification}       strip_spaces=True     
    # case3 reimport successfully
    common.Expand MCH3 categoeis
    common.Clear fill input                 ${common.txt_search}    
    common.Select categories name           name_category=${MCH3_category['all_category']}  
    common.Click button using name          ${button_name['btn_apply']}
    common.Click button using name          ${button_name['btn_edit']}  
    common_feature.After click button edit all of these button should be display properly
    settarget_page.Update csv file before import file settarget
            ...     ${settarget['csv_file']['QTM-1056-valid']}
            ...     ${settarget['csv_1056']['row']}     
            ...     ${settarget['csv_1056']['col']} 
    settarget_page.Verify the button import file csv should be display
    common.Choose csv file  ${folder_name['csv_data']}        ${settarget['csv_file']['QTM-1056-valid']}      ${file_extension['csv']}  
    common.Verify wording upload successfully
    DobbyWebCommon.Scroll to top of page using java script
    common.Click expand notification 
    ${noti_id}    common.Get notification id
    common.Verify notification file has been imported  id_transaction=${noti_id}
    SeleniumLibrary.Double click element        ${common.terminate_dropdown}
    common_feature.Select action after upload file csv      ${button_name['btn_discard']}
    ${message_inmail}           common.Get notification message from email
                                    ...    ${reg_ex_page['settarget']}
                                    ...    ${account['saleuser']['acc_03']['username']}
                                    ...    ${account['saleuser']['acc_03']['password']}
                                    ...    ${QTM_1056['folder_email']}
                                    ...    ${noti_id}    
    ${expected_message}     common.Get expected notification message    ${notification_message['file_imported']}    ${noti_id}    ${QTM_1056['page']}
    BuiltIn.Should be equal    ${message_inmail}    ${expected_message}    strip_spaces=True