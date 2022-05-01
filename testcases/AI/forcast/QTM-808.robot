*** Settings ***
Resource            ${CURDIR}/../../../keywords/imports.robot
Suite Setup         common.SCG suite setup
Test Teardown       common.SCG suite teardown

** Test Cases ***
Verify when client import file with excel file should be got notification correctly.
    [Tags]    QTM-808
    [Setup]    common.Get customer token    ${account['meruser']['acc_02']['username']}    ${account['meruser']['acc_02']['password']}
    
    login_feature.User login via email and password    ${account['meruser']['acc_02']['username']}    ${account['meruser']['acc_02']['password']}
    main_page.User select AI feature 
    forecast_feature.Landing to forecast page properly
    common.Close the popup system require update
    forecast_feature.Select category same name more than two name    ${MCH2_category['sink_equipment']}
    forecast_page.Clear all categories

    common_feature.Select MCH1 categories    ${MCH1_category['sink_counter_k301']['search']}    ${MCH1_category['sink_counter_k301']['categories_code']}
    common_feature.Select MCH1 categories    ${MCH1_category['sink_k302']['search']}     ${MCH1_category['sink_k302']['categories_code']}
    common.Click button using name    ${button_name['btn_apply']}
    common.Click button using name    ${button_name['btn_edit']}
    common_feature.Click discard after check adjust price
    common.Click button using name    ${button_name['btn_edit']}
    common_feature.After click button edit all of these button should be display properly
    common.Choose csv file    ${folder_name['csv_data']}    ${Qtm_808['file_name']}    ${Qtm_808['file_extension']}
    common.Verify error message when import file incorrect condition
    common.Verify button should be disabled using name       ${button_name['btn_save_and_submit']}
    common_feature.Click discard after check adjust price
    DobbyWebCommon.Scroll to top of page using java script
    common.Click expand notification 
    common.Click button view all notication
    ${noti_id}    common.Get notification id
    common.Verify after import file filed notifiction should be warning    ${noti_id}
    common.Click notification accroding transaction id    ${noti_id}
    ${message_inmail}    common.Get notification message from email
                            ...    ${reg_ex_page['forecast']}
                            ...    ${account['meruser']['acc_02']['username']}
                            ...    ${account['meruser']['acc_02']['password']}
                            ...    ${folder_email['staff_notification']}
                            ...    ${noti_id} 
    ${expected_message}     common.Get expected notification message    ${notification_message['import_request']}    ${noti_id}    ${page['forecast']}
    ${headles}    SeleniumLibrary.Get window handles
    SeleniumLibrary.Switch Window    ${headles}[1]
    forecast_feature.Landing to forecast page properly
    common.Verify categories ch2 should be display
    common.Remove the whitespace from messages then compare    ${message_inmail}    ${expected_message}
