*** Settings ***
Resource    ${CURDIR}/../../../keywords/imports.robot
Test Teardown    common.SCG suite teardown

*** Test Cases ***
Verify user able to re-import successfully
    [Documentation]     ai min max level by dc
    [Tags]    QTM-1117
    [Setup]    common.Get customer token     ${account['superuser']['acc_02']['username']}     ${account['superuser']['acc_02']['password']}
    ${Directory_download}    common.SCG suite setup
    login_feature.User login via email and password    ${account['superuser']['acc_02']['username']}    ${account['superuser']['acc_02']['password']}
    main_page.User select AI feature 
    AI_page.User clicks on menu         ${menu_name['ai_page']['menu_min_max']}
    min_max_level.Select min and max level by label name    ${class_level['dc']}
    common.Close the popup system require update

    common.Input article Number     ${QTM_1117['article_number']}
    common_feature.Click expand and select DC categories
    SeleniumLibrary.Press keys    None    ESC
    common_feature.Click expand and select MCH3 categories
    SeleniumLibrary.Press keys    None    ESC
    common.Click button using name            ${button_name['btn_apply']}
    common.Click button using name          ${button_name['btn_edit']}
    common_feature.After click button edit all of these button should be display properly

    min_max_level.Verify the button import file csv should be display
    common.Choose csv file    ${folder_name['csv_data']}    ${QTM_1117['csv_file']['import_file']}      ${file_extension['csv']}
    common.Verify wording after choose file
    common.Download file for edit and move to csv folder    ${QTM_1117['csv_file']['export_file']}    ${Directory_download}
    ${reason}    forecast_page.Get the reason invalid file    ${QTM_1117['csv_file']['export_file']}     ${error_message['both_min_max_numeric_error']}
    BuiltIn.Should be equal    ${reason}    ${error_message['both_min_max_numeric_error']}

    common.Copy file to directory    ${QTM_1117['csv_file']['export_file']}    ${QTM_1117['csv_file']['reimport_file']}
    common.Update csv file from column and row         ${QTM_1117['csv_file']['reimport_file']}    ${QTM_1117['column_name'][0]}     ${4}      ${QTM_1117['new_value'][0]}
    common.Update csv file from column and row         ${QTM_1117['csv_file']['reimport_file']}    ${QTM_1117['column_name'][1]}     ${4}      ${QTM_1117['new_value'][1]}
    common_feature.Click discard after check adjust price
    common.Click button using name            ${button_name['btn_edit']}

    common.Choose csv file  ${folder_name['csv_data']}        ${QTM_1117['csv_file']['reimport_file']}      ${file_extension['csv']}
    common.Verify wording after choose file
    common.Verify wording upload successfully
    min_max_level.Verify min max by code and store value in table should be display blue color      ${QTM_1117['store'][0]}      ${QTM_1117['store'][1]}    ${QTM_1117['store'][2]}
    common_feature.Click discard after check adjust price

    common.Click expand notification 
    common.Click button view all notication

    #Verify email import file successed
    ${noti_id}    common.Get notification id
    min_max_level.Verify notification import file import product min max should be displayed    ${QTM_1111['min_max_page']}    ${noti_id}
    ${message_inmail}       common.Get notification message from email
                            ...     ${reg_ex_page['min_max_level']}
                            ...     ${account['superuser']['acc_02']['username']}
                            ...     ${account['superuser']['acc_02']['password']}
                            ...     ${folder_email['staff_notification']}
                            ...     ${noti_id} 
    ${expected_message}     common.Get expected notification message    ${notification_message['import_succeeded_min_max']}    ${noti_id}    ${page['product_min_max']}
    common.Remove the whitespace from messages then compare    ${message_inmail}    ${expected_message}