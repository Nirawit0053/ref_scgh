*** Settings ***
Resource    ${CURDIR}/../../../keywords/imports.robot
Test Teardown    common.SCG suite teardown

** Test Cases ***
Verify that system able to re-import CSV file with error reason column when user import invalid case
    [Tags]    QTM-812
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
    common.Choose csv file  ${folder_name['csv_data']}    ${Qtm_812['csv_file']['import_file']}
    common.Verify wording after choose file
    common.Verify warning message items invalid    ${Qtm_812['item']}

    forecast_page.Verify value in table should be display blue color    ${forecast_01['information']['code']}    ${forecast_01['information']['brand']}
    forecast_page.Get forecast table error field and verify border field    ${Qtm_805['js_file']}    ${forecast_01['information']['code']}    ${forecast_01['information']['brand']}
    common.Download file for edit and move to csv folder    ${Qtm_812['csv_file']['export_file']}    ${Directory_download}
    ${reason}    forecast_page.Get the reason invalid file    ${Qtm_811['csv_data']['export_file']}     ${error_message['value_invalid']}
    BuiltIn.Should be equal    ${reason}    ${error_message['value_invalid']}

    common.Copy file to directory    ${Qtm_812['csv_file']['export_file']}    ${Qtm_812['csv_file']['reimport_file']}
    common.Update csv file from column and row     ${Qtm_812['csv_file']['reimport_file']}    ${Qtm_812['column_name'][0]}    ${7}   ${Qtm_812['new_value'][0]}
    common.Update csv file from column and row     ${Qtm_812['csv_file']['reimport_file']}    ${Qtm_812['column_name'][1]}    ${7}   ${Qtm_812['new_value'][1]}
    common_feature.Click discard after check adjust price
    common.Click button using name    ${button_name['btn_edit']}

    common.Choose csv file    ${folder_name['csv_data']}    ${Qtm_812['csv_file']['reimport_file']}
    common.Verify wording after choose file
    common.Verify wording upload successfully
    common_feature.Click discard after check adjust price
    DobbyWebCommon.Scroll to top of page using java script
    common.Click expand notification 
    common.Click button view all notication
    #Verify email import file successed
    ${noti_id}    common.Get notification id
    common.Verify notification import file successfully should be displayed    ${page['forecast']}    ${noti_id}
    ${actual_import_successed}    common.Get notification message from email    ${reg_ex_page['import_request_forecast']}    ${account['meruser']['acc_02']['username']}    ${account['meruser']['acc_02']['password']}
    ...    ${folder_email['staff_notification']}    ${noti_id}
    ${expected_import_successed}     common.Get expected notification message    ${notification_message['import_succeeded']}    ${noti_id}    ${page['forecast']}
    common.Remove the whitespace from messages then compare    ${actual_import_successed}    ${expected_import_successed}
    #Verify email import file unexpected
    ${unexpected_id}    common.Get unexpected notification
    common.Verify unexpected notification    ${page['forecast']}    ${unexpected_id}    ${Qtm_812['item']}
    common.Click unexpected notification    ${page['forecast']}    ${unexpected_id}    ${Qtm_812['item']}
    ${actual_notifiction_mail}    common.Get notification message from email
                                    ...    ${reg_ex_page['forecast']}
                                    ...    ${account['meruser']['acc_02']['username']}
                                    ...    ${account['meruser']['acc_02']['password']}
                                    ...    ${folder_email['staff_notification']}
                                    ...    ${unexpected_id}
    ${expected_notification}    common.Get expected notification unexpected message    ${notification_message['unexpected_noti']}    ${unexpected_id}
    ...   ${page['forecast']}   ${Qtm_812['item']}
    common.Remove the whitespace from messages then compare    ${actual_notifiction_mail}    ${expected_notification} 

