*** Settings ***
Resource    ${CURDIR}/../../../../keywords/imports.robot
Test Teardown    common.SCG suite teardown

** Test Cases ***
Verify that User able to re-import CSV file successfully
    [Tags]    QTM-1090
    [Setup]    common.Get customer token    ${account['superuser']['acc_02']['username']}    ${account['superuser']['acc_02']['password']}
    ${Directory_download}    common.SCG suite setup
    login_feature.User login via email and password    ${account['superuser']['acc_02']['username']}    ${account['superuser']['acc_02']['password']}
    common.Close the popup system require update
    main_page.User select configuration feature
    common_feature.Select franchise store    ${EMPTY}    ${franchise_store['all_store']}
    common.Click button using name    ${button_name['btn_apply']}
    common.Click button using name    ${button_name['btn_edit']}
    common_feature.Click discard after check adjust price
    common.Click button using name    ${button_name['btn_edit']}
    common_feature.After click button edit all of these button should be display properly
    common.Choose csv file    ${folder_name['csv_data']}    ${QTM_1090['csv_file']}
    common.Verify wording after choose file
    common.Verify warning message items invalid    ${QTM_1090['item']}

    common.Click expand notification 
    ${unexpected_occured}    common.Get unexpected notification
    dcrc_page.Verify notification unexpected occurred id from notification page    ${unexpected_occured}    ${QTM_1090['item']}

    common.Click expand notification
    common.Click export file for edit
    ${actual_import_successed}    common.Get notification message from email    ${reg_ex_page['import_draf_success']}    ${account['superuser']['acc_02']['username']}    ${account['superuser']['acc_02']['password']}
    ...    ${folder_email['staff_notification']}    ${unexpected_occured}
    ${expected_notification}    common.Get expected notification unexpected message    ${notification_message['occurrend_items_main_rcdc']}    ${unexpected_occured}    ${page['main']}    1
    common.Remove the whitespace from messages then compare    ${actual_import_successed}   ${expected_notification}   
    
    ${noti_id}    common.Get notification id
    common.Click button discard on modal popup
    common.Click expand notification
    dcrc_page.Download the file through the notification export file    ${noti_id}    ${QTM_1090['csv_reimport']}    ${Directory_download}  
    ${reason}    forecast_page.Get the reason invalid file    ${QTM_1090['csv_reimport']}     ${error_message['configuration_invalid_reason']}
    BuiltIn.Should be equal    ${reason}    ${error_message['configuration_invalid_reason']}
    common.Click expand notification
    common.Update csv file from column and row    ${QTM_1090['csv_reimport']}    ${QTM_1090['column_name'][0]}    ${4}   ${QTM_1090['value_update']}
    common.Update csv file from column and row    ${QTM_1090['csv_reimport']}    ${QTM_1090['column_name'][1]}    ${4}   ${QTM_1090['time_lead']}
    common_feature.Click discard after check adjust price
    common.Click button using name    ${button_name['btn_edit']}

    common.Choose csv file    ${folder_name['csv_data']}    ${QTM_1090['csv_reimport']} 
    common.Verify wording after choose file
    common.Verify wording upload successfully
    common_feature.Click discard after check adjust price
    DobbyWebCommon.Scroll to top of page using java script
    common.Click expand notification 
    common.Click button view all notication
    #Verify email import file successed
    ${noti_id}    common.Get notification id
    dcrc_page.Verify notification import file draf successfully    ${noti_id}
    ${message_inmail}    common.Get notification message from email    ${reg_ex_page['import_draf_success']}    ${account['superuser']['acc_02']['username']}    
    ...    ${account['superuser']['acc_02']['password']}    ${folder_email['staff_notification']}    ${noti_id} 
    ${message_expected}    common.Get expected notification message    ${notification_message['import_draf_success']}    ${noti_id}    ${QTM_1805['page']}
    common.Remove the whitespace from messages then compare    ${message_inmail}   ${message_expected}
