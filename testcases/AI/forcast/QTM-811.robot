*** Settings ***
Resource    ${CURDIR}/../../../keywords/imports.robot
Test Teardown    common.SCG suite teardown

** Test Cases ***
Verify that User able to receive CSV file correct error position and have error reason correctly
    [Tags]    QTM-811
    [Setup]    common.Get customer token    ${account['meruser']['acc_02']['username']}    ${account['meruser']['acc_02']['password']}  
    ${Directory_download}    common.SCG suite setup
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
    common.Choose csv file    ${folder_name['csv_data']}    ${Qtm_811['csv_data']['import_file']}
    common.Verify warning message item invalid displayed    ${Qtm_811['items']}
    common.Verify button should be disabled using name       ${button_name['btn_save_and_submit']}
    forecast_page.Verify value in table should be display blue color    ${forecast_01['information']['code']}    ${forecast_01['information']['brand']}
    forecast_page.Get forecast table error field and verify border field    ${Qtm_805['js_file']}    ${forecast_01['information']['code']}    ${forecast_01['information']['brand']}
    common.Download file for edit and move to csv folder    ${Qtm_811['csv_data']['export_file']}    ${Directory_download}
    ${reason}    forecast_page.Get the reason invalid file    ${Qtm_811['csv_data']['export_file']}     ${error_message['value_invalid']}
    BuiltIn.Should be equal    ${reason}    ${error_message['value_invalid']}
    common_feature.Click discard after check adjust price
    DobbyWebCommon.Scroll to top of page using java script
    common.Click expand notification 
    common.Click button view all notication
    ${unexpected_id}    common.Get unexpected notification
    common.Verify unexpected notification    ${page['forecast']}    ${unexpected_id}    ${Qtm_811['items']}
    ${actual_notifiction_mail}    common.Get notification message from email
                                        ...    ${reg_ex_page['forecast']}
                                        ...    ${account['meruser']['acc_02']['username']}
                                        ...    ${account['meruser']['acc_02']['password']}
                                        ...    ${folder_email['staff_notification']}
                                        ...    ${unexpected_id}
    ${expected_notification}    common.Get expected notification unexpected message    ${notification_message['unexpected_noti']}    ${unexpected_id}
    ...   ${page['forecast']}    ${Qtm_811['items']}
    common.Remove the whitespace from messages then compare    ${actual_notifiction_mail}    ${expected_notification}
