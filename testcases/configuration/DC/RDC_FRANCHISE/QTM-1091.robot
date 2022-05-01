*** Settings ***
Resource    ${CURDIR}/../../../../keywords/imports.robot
Test Teardown    common.SCG suite teardown

** Test Cases ***
Verify that User able to re-import CSV file successfully
    [Tags]    QTM-1091
    [Setup]    common.Get customer token    ${account['superuser']['acc_02']['username']}    ${account['superuser']['acc_02']['password']}
    ${Directory_download}    common.SCG suite setup
    login_feature.User login via email and password    ${account['superuser']['acc_02']['username']}    ${account['superuser']['acc_02']['password']}
    common.Close the popup system require update
    main_page.User select configuration feature
    dcrc_page.Click expand inventory target
    dcrc_page.Select inventory rdc
    common_feature.Select RDC inventory    ${EMPTY}    ${RDC_category['all_category']}
    common.Click button using name    ${button_name['btn_apply']}
    common.Click button using name    ${button_name['btn_edit']}
    common_feature.Click discard after check adjust price
    common.Click button using name    ${button_name['btn_edit']}
    common_feature.After click button edit all of these button should be display properly
    common.Choose csv file    ${folder_name['csv_data']}    ${QTM_1091['csv_file']}
    common.Verify wording after choose file
    common.Verify wording upload successfully

    ${milion_baht}    common.Convert price to million baht    ${QTM_1091['value_intable'][0]}
    dcrc_page.Verify information in table row should be display blue color    ${QTM_1091['store_name'][0]}    ${milion_baht}
    dcrc_page.Verify information in table row should be display blue color    ${QTM_1091['store_name'][0]}    ${QTM_1091['time_lead'][0]}

    ${demical_price}    common.Round decimal value    ${QTM_1091['value_intable'][1]}
    dcrc_page.Verify information in table row should be display blue color    ${QTM_1091['store_name'][1]}    ${demical_price}
    dcrc_page.Verify information in table row should be display blue color    ${QTM_1091['store_name'][1]}    ${QTM_1091['time_lead'][1]}

    dcrc_page.Click change to next page
    ${milion_baht}    common.Convert price to million baht    ${QTM_1091['value_intable'][2]}
    dcrc_page.Verify information in table row should be display blue color    ${QTM_1091['store_name'][2]}    ${milion_baht}
    dcrc_page.Verify information in table row should be display blue color    ${QTM_1091['store_name'][2]}    ${QTM_1091['time_lead'][2]}
    common_feature.Click discard after check adjust price
    DobbyWebCommon.Scroll to top of page using java script
    common.Click expand notification 
    common.Click button view all notication
    ${noti_id}    common.Get notification id
    dcrc_page.Verify notification import file draf successfully    ${noti_id}
    ${message_inmail}    common.Get notification message from email    ${reg_ex_page['import_draf_success']}    ${account['superuser']['acc_02']['username']}    
    ...    ${account['superuser']['acc_02']['password']}    ${folder_email['staff_notification']}    ${noti_id} 
    ${message_expected}    common.Get expected notification message    ${notification_message['import_draf_success']}    ${noti_id}    ${page['main']}
    common.Remove the whitespace from messages then compare    ${message_inmail}    ${message_expected}
