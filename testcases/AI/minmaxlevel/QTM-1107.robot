*** Settings ***
Resource    ${CURDIR}/../../../keywords/imports.robot
Suite Setup         common.SCG suite setup
Test Teardown      common.SCG suite teardown

*** Test Cases ***
Verify that user able to import successfully by valid case
    [Documentation]     ai min max level by rdc
    [Setup]     common.Get customer token    ${account['superuser']['acc_02']['username']}    ${account['superuser']['acc_02']['password']}
    [Tags]    QTM-1107-1    QTM-1107-2
    ${Directory_download}    common.SCG suite setup
    login_feature.User login via email and password    ${account['superuser']['acc_02']['username']}    ${account['superuser']['acc_02']['password']}
    main_page.User select AI feature 
    AI_page.User clicks on menu         ${menu_name['ai_page']['menu_min_max']}
    min_max_level.Select min and max level by label name    ${class_level['rdc']}
    common.Close the popup system require update

    common.Input article name     ${QTM_1107['article_name']}
    common_feature.Click expand and select RDC categories
    SeleniumLibrary.Press keys    None    ESC
    common_feature.Click expand and select MCH3 categories
    SeleniumLibrary.Press keys    None    ESC
    common.Click button using name            ${button_name['btn_apply']}
    common.Click button using name          ${button_name['btn_edit']}
    common_feature.After click button edit all of these button should be display properly

    min_max_level.Verify the button import file csv should be display
    common.Choose csv file  ${folder_name['csv_data']}    ${QTM_1107['csv_file']}      ${file_extension['csv']}
    common.Verify wording after choose file

    BuiltIn.Wait until keyword succeeds    3x    2s    min_max_level.Verify adjust letter should be show in blue
    SeleniumLibrary.Press keys    None    ESC
    common_feature.Click discard after check adjust price

    common.Click button using name          ${button_name['btn_edit']}
    common_feature.After click button edit all of these button should be display properly

    min_max_level.Verify the button import file csv should be display
    common.Choose csv file  ${folder_name['csv_data']}    ${QTM_1107['csv_file']}      ${file_extension['csv']}
    common.Verify wording after choose file

    BuiltIn.Wait until keyword succeeds    3x    2s    min_max_level.Verify adjust letter should be show in blue
    SeleniumLibrary.Press keys    None    ESC
    common_feature.Click discard after check adjust price

    common.Click expand notification 
    common.Click button view all notication
    ${noti_id}    common.Get notification id
    ${message_inmail}       common.Get notification message from email
                            ...     ${reg_ex_page['min_max_level']}
                            ...     ${account['superuser']['acc_02']['username']}
                            ...     ${account['superuser']['acc_02']['password']}
                            ...     ${folder_email['staff_notification']}
                            ...     ${noti_id} 
    ${expected_message}     common.Get expected notification message    ${notification_message['import_succeeded_min_max']}    ${noti_id}    ${page['product_min_max']}
    common.Remove the whitespace from messages then compare    ${message_inmail}    ${expected_message}