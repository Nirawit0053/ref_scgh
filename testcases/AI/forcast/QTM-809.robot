*** Settings ***
Resource    ${CURDIR}/../../../keywords/imports.robot
Test Teardown    common.SCG suite teardown

** Test Cases ***
Verify that system able to display when user import invalid case and valid case
    [Tags]    QTM-809
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
    common.Choose csv file    ${folder_name['csv_data']}    ${Qtm_809['csv_file']['csv_file']}
    common.Verify wording after choose file     
    common.Verify warning message items import successfully    ${Qtm_809['items']}
    common.Verify warning message items invalid    ${Qtm_809['items']}
    #Verify value invalid in table
    forecast_page.Verify value in table should be display blue color    ${Qtm_809['information']['code']}    ${Qtm_809['information']['brand']}
    forecast_page.Get forecast table error field and verify border field    ${Qtm_805['js_file']}    ${Qtm_809['information']['code']}    ${Qtm_809['information']['brand']}
    #Verify value success in table
    ${list}    common.Get data from csv file    ${Qtm_809['csv_file']['csv_file']}    ${forecast_01['data_csv']['column_name']}    ${forecast_01['data_csv']['index_file_csv'][0]}
    ${value_from_excel}    common.Get information in list    ${list}    ${Qtm_809['list']}
    ${millon_bath}    common.Convert price to million baht    ${value_from_excel}
    forecast_page.Verify adjust price should be display color blue    ${Qtm_809['information']['code']}    ${Qtm_809['information']['brand']}    ${millon_bath}

    common.Download file for edit and move to csv folder    ${Qtm_809['csv_file']['move_file']}    ${Directory_download}
    ${export_id}    common.Get export file id
    ${export_details}    common.Get export file information    ${export_id}
    ${actual_start_prepared}    common.Get notification message start preparing export data from email    ${account['meruser']['acc_02']['username']}    ${account['meruser']['acc_02']['password']}
    ...    ${folder_email['staff_notification']}    ${export_details}
    ${actual_get_export_file}    common.Get notification message export file from email    ${account['meruser']['acc_02']['username']}    ${account['meruser']['acc_02']['password']}
    ...    ${folder_email['staff_notification']}    ${export_details}
    ${start_prepared_msg}    common.Get expected notification message    ${notification_message['start_prepared_data']}    ${export_details}    ${page['forecast']}
    ${export_file_msg}    common.Get expected notification message    ${notification_message['export_request_success']}    ${export_details}    ${page['forecast']}
    BuiltIn.Should be equal    ${actual_start_prepared}    ${start_prepared_msg}
    BuiltIn.Should be equal    ${actual_get_export_file}    ${export_file_msg}
    #Verify value in csv file.
    ${reason}    forecast_page.Get the reason invalid file    ${Qtm_809['csv_file']['move_file']}    ${error_message['value_invalid']}
    BuiltIn.Should be equal    ${reason}    ${error_message['value_invalid']}

    common_feature.Click discard after check adjust price
    DobbyWebCommon.Scroll to top of page using java script
    common.Click expand notification 
    common.Click button view all notication
    ${unexpected_id}    common.Get unexpected notification
    common.Verify unexpected notification    ${page['forecast']}    ${unexpected_id}    ${Qtm_809['items']}
    ${actual_notifiction_mail}    common.Get notification message from email
                                    ...    ${reg_ex_page['forecast']}
                                    ...    ${account['meruser']['acc_02']['username']}
                                    ...    ${account['meruser']['acc_02']['password']}
                                    ...    ${folder_email['staff_notification']}
                                    ...    ${unexpected_id}
    ${expected_notification}    common.Get expected notification unexpected message    ${notification_message['unexpected_noti']}
    ...    ${unexpected_id}    ${page['forecast']}    ${Qtm_809['items']}
    common.Remove the whitespace from messages then compare    ${actual_notifiction_mail}    ${expected_notification}  
