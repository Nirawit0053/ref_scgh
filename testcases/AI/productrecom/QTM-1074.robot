*** Settings ***
Resource    ${CURDIR}/../../../keywords/imports.robot
Test Setup         common.SCG suite setup
Test Teardown      common.SCG suite teardown

** Test Cases ***
Verify that user able import data successfully by valid and invalid data - reimport
    [Tags]          QTM-1074
    [Setup]    common.Get customer token    ${account['superuser']['acc_03']['username']}    ${account['superuser']['acc_03']['password']}
    ${Directory_download}    common.SCG suite setup
    login_feature.User login via email and password     ${account['superuser']['acc_03']['username']}        ${account['superuser']['acc_03']['password']}
    main_feature.Verify superuser login success
    main_page.User select AI feature
    AI_feature.Verify AI page is displayed correctly for user  
    AI_page.User clicks on menu         ${menu_name['ai_page']['menu_product_class_recom']}

    product_recom_page.Verify system landing to product recommendation page properly
    common.Close the popup system require update
    common.Input article Number     ${QTM_1074['article_num']}
    common_feature.Click expand and select MCH3 categories   
    common_feature.Click expand and select franchise store
    SeleniumLibrary.Press keys    None    ESC
    common.Click button using name            ${button_name['btn_apply']}
    common.Click button using name          ${button_name['btn_edit']}
    common_feature.Click discard after check adjust price
    common.Click button using name          ${button_name['btn_edit']}

    common_feature.After click button edit all of these button should be display properly
    product_recom_page.Verify the button import file csv should be display
    common.Choose csv file  ${folder_name['others']}  ${productrecom_01['others']['franchiseinvalid']}   ${file_extension['csv']}
    common.Verify warning message items invalid  ${QTM_1074['iteminvalid']}
    DobbyWebCommon.Scroll to top of page using java script
    common.Click expand notification
    
    ${unexpected_id}    common.Get unexpected notification
    product_recom_page.Verify unexpected notification for productrecom    ${page['productrecom']}    ${unexpected_id}    ${QTM_1074['item']}

    ${actual_notifiction_mail}    common.Get notification message from email
                                    ...    ${reg_ex_page['productrecom']}
                                    ...    ${account['superuser']['acc_03']['username']}
                                    ...    ${account['superuser']['acc_03']['password']}
                                    ...    ${folder_email['productmaster']}
                                    ...    ${unexpected_id}
    ${expected_notification}    common.Get expected notification unexpected message    ${notification_message['unexpected_noti_productrecom']}    ${unexpected_id}
    ...   ${page['productrecom']}   ${QTM_1074['item']}
    common.Remove the whitespace from messages then compare    ${actual_notifiction_mail}    ${expected_notification}

    common.Download file for edit and move to csv folder    ${QTM_1074['csv_file']['export_file']}    ${Directory_download}
    common.Copy file to directory    ${QTM_1074['csv_file']['export_file']}    ${QTM_1074['csv_file']['reimport_file']}

    common.Update csv file from column and row     ${QTM_1074['csv_file']['reimport_file']}    ${QTM_1074['column_name'][0]}    ${4}    ${QTM_1074['new_value'][0]}
    common_feature.Click discard after check adjust price
    common.Click button using name            ${button_name['btn_edit']}
    common.Choose csv file  ${folder_name['csv_data']}        ${QTM_1074['csv_file']['reimport_file']}      ${file_extension['csv']}
    
    common.Verify wording after choose file
    common.Verify wording upload successfully
    common_feature.Click discard after check adjust price
    DobbyWebCommon.Scroll to top of page using java script
    common.Click expand notification
    common.Click button view all notication
    ${noti_id}    common.Get notification id
    product_recom_page.Verify notification import file successfully should be displayed  ${page['productrecom']}  ${noti_id}
    ${message_inmail}    common.Get notification message from email    ${reg_ex_page['productrecom']}    ${account['superuser']['acc_03']['username']}    ${account['superuser']['acc_03']['password']}    ${folder_email['staff_notification']}    ${noti_id} 
    ${message_expected}    common.Get expected notification message    ${notification_message['import_succeeded_productrecom']}    ${noti_id}    ${page['productrecom']}
    common.Remove the whitespace from messages then compare   ${message_inmail}  ${message_expected}