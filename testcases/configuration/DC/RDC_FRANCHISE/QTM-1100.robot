*** Settings ***
Resource    ${CURDIR}/../../../../keywords/imports.robot
Test Teardown    common.SCG suite teardown

** Test Cases ***
Verify that User able to import CSV file successfully By valid case
    [Tags]    QTM-1100
    [Setup]    common.Get customer token    ${account['superuser']['acc_02']['username']}    ${account['superuser']['acc_02']['password']}
    ${Directory_download}    common.SCG suite setup
    login_feature.User login via email and password    ${account['superuser']['acc_02']['username']}    ${account['superuser']['acc_02']['password']}
    common.Close the popup system require update
    main_page.User select configuration feature
    dcrc_page.Click expand inventory target
    dcrc_page.Select inventory dc

    common_feature.Select DC inventory    ${EMPTY}    ${DC_category['all_category']}
    common.Click button using name    ${button_name['btn_apply']}
    common.Click button using name    ${button_name['btn_edit']}
    common_feature.Click discard after check adjust price
    common.Click button using name    ${button_name['btn_edit']}
    common_feature.After click button edit all of these button should be display properly
    common.Choose csv file    ${folder_name['csv_data']}    ${QTM_1100['csv_file']}
    common.Verify wording after choose file
    common.Verify warning message items invalid    ${QTM_1100['item_invalid']}
    common.Click export file for edit
    common.Click button discard on modal popup
    common.Click expand notification 

    ${unexpected_occured}    common.Get unexpected notification
    dcrc_page.Verify notification unexpected occurred id from notification page    ${unexpected_occured}    ${QTM_1100['item_invalid']}
    ${actual_import_successed}    common.Get notification message from email    ${reg_ex_page['import_draf_success']}    ${account['superuser']['acc_02']['username']}    ${account['superuser']['acc_02']['password']}
    ...   ${folder_email['staff_notification']}    ${unexpected_occured}
    ${expected_notification}    common.Get expected notification unexpected message    ${notification_message['occurrend_items_main_rcdc']}    ${unexpected_occured}    ${page['main']}    ${QTM_1100['item_invalid']}
    common.Remove the whitespace from messages then compare    ${actual_import_successed}   ${expected_notification}   

    ${noti_id}    common.Get notification id
    ${actual_mail}    common.Get notification message export file from email    ${account['superuser']['acc_02']['username']}    ${account['superuser']['acc_02']['password']}
    ...   ${folder_email['staff_notification']}    ${noti_id}
    ${expected_mail}    common.Get expected notification message    ${notification_message['msg_export_file_request_configuration_dc']}    ${noti_id}    ${page['channels']}
    common.Remove the whitespace from messages then compare    ${actual_mail}   ${expected_mail}
    common.Verify notification export file is ready should be displayed   ${page['channels']}    ${noti_id}

    ${email_export_file}    common.Get notification message start preparing export data from email    ${account['superuser']['acc_02']['username']}    ${account['superuser']['acc_02']['password']}
    ...   ${folder_email['staff_notification']}    ${noti_id}
    ${notification_id}    String.Replace string    ${noti_id}    ID${SPACE}    ${EMPTY}
    ${message_expected}    common.Get expected notification message    ${notification_message['msg_start_prepared_configuration_dc']}    ${notification_id}    ${page['channels']}
    common.Remove the whitespace from messages then compare    ${email_export_file}   ${message_expected}
    common.Verify notification request export file should be displayed    ${page['channels']}    ${notification_id}

    ${noti_id}    common.Get notification id
    dcrc_page.Download the file through the notification export file    ${noti_id}    ${QTM_1100['csv_reimport']}    ${Directory_download}  
    ${reason}    forecast_page.Get the reason invalid file    ${QTM_1100['csv_reimport']}     ${error_message['invalid_reason_2_decimal']}
    BuiltIn.Should be equal    ${reason}    ${error_message['configuration_invalid_reason']}
    common.Click expand notification

    common.Update csv file from column and row    ${QTM_1100['csv_reimport']}    ${QTM_1100['column_name'][0]}    ${4}   ${QTM_1100['new_value']}
    common.Update csv file from column and row    ${QTM_1100['csv_reimport']}    ${QTM_1100['column_name'][1]}    ${4}   ${QTM_1100['time_lead']}
    common_feature.Click discard after check adjust price
    common.Click button using name    ${button_name['btn_edit']}

    common.Choose csv file    ${folder_name['csv_data']}    ${QTM_1100['csv_reimport']}
    common.Verify wording after choose file
    common.Verify wording upload successfully
    common_feature.Click discard after check adjust price
    common.Click expand notification 
    common.Click button view all notication
    ${noti_id}    common.Get notification id
    dcrc_page.Verify notification import file draf successfully    ${noti_id}
    ${message_inmail}    common.Get notification message from email    ${reg_ex_page['import_draf_success']}    ${account['superuser']['acc_02']['username']}    
    ...    ${account['superuser']['acc_02']['password']}    ${folder_email['staff_notification']}    ${noti_id} 
    ${message_expected}    common.Get expected notification message    ${notification_message['import_draf_success']}    ${noti_id}    ${page['main']}
    common.Remove the whitespace from messages then compare    ${message_inmail}   ${message_expected}