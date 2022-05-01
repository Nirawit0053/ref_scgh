*** Settings ***
Resource    ${CURDIR}/../../../../keywords/imports.robot
Suite Setup    common.SCG suite setup
Test Teardown    common.SCG suite teardown

** Test Cases ***
Verify that User able to import CSV file successfully By valid case
    [Tags]    QTM-1085
    [Setup]    common.Get customer token    ${account['superuser']['acc_02']['username']}    ${account['superuser']['acc_02']['password']}
    login_feature.User login via email and password    ${account['superuser']['acc_02']['username']}    ${account['superuser']['acc_02']['password']}
    common.Close the popup system require update
    main_page.User select configuration feature
    common_feature.Select franchise store    ${EMPTY}    ${franchise_store['all_store']}
    common.Click button using name    ${button_name['btn_apply']}
    common.Click button using name    ${button_name['btn_edit']}
    common_feature.Click discard after check adjust price
    common.Click button using name    ${button_name['btn_edit']}
    common_feature.After click button edit all of these button should be display properly
    common.Choose csv file    ${folder_name['csv_data']}    ${QTM_1805['csv_file']}
    common.Verify wording after choose file
    common.Verify wording upload successfully

    ${demical_price}    common.Round decimal value    ${QTM_1805['price_value'][0]}
    dcrc_page.Verify information in table row should be display blue color    ${QTM_1805['store_name']['korat_test']}    ${demical_price}
    dcrc_page.Verify information in table row should be display blue color    ${QTM_1805['store_name']['korat_test']}    ${QTM_1805['time_lead'][0]}
    dcrc_page.Click change to next page
    ${demical_price}    common.Convert value to currency    ${QTM_1805['price_value'][1]}
    dcrc_page.Verify information in table row should be display blue color    ${QTM_1805['store_name']['empty_store']}    ${demical_price}
    dcrc_page.Verify information in table row should be display blue color    ${QTM_1805['store_name']['empty_store']}    ${QTM_1805['time_lead'][1]}
    dcrc_page.Click change to next page
    ${milion_baht}    Convert price to million baht    ${QTM_1805['price_value'][2]}
    dcrc_page.Verify information in table row should be display blue color    ${QTM_1805['store_name']['korat_store']}    ${milion_baht}
    dcrc_page.Verify information in table row should be display blue color    ${QTM_1805['store_name']['korat_store']}    ${QTM_1805['time_lead'][1]}
    DobbyWebCommon.Scroll to top of page using java script
    common.Click expand notification 
    ${noti_id}    common.Get notification id
    dcrc_page.Verify notification import file draf successfully    ${noti_id}
    ${message_inmail}    common.Get notification message from email    ${reg_ex_page['import_draf_success']}    ${account['superuser']['acc_02']['username']}    ${account['superuser']['acc_02']['password']}    ${folder_email['staff_notification']}    ${noti_id} 
    ${message_expected}    common.Get expected notification message    ${notification_message['import_draf_success']}    ${noti_id}    ${QTM_1805['page']}
    common.Remove the whitespace from messages then compare    ${message_inmail}   ${message_expected}
