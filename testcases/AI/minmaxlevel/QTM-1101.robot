*** Settings ***
Resource    ${CURDIR}/../../../keywords/imports.robot
Suite Setup         common.SCG suite setup
Test Teardown      common.SCG suite teardown

*** Test Cases ***
Verify that user able to import successfully by valid case
    [Setup]     common.Get customer token    ${account['superuser']['acc_02']['username']}    ${account['superuser']['acc_02']['password']}
    [Tags]    QTM-1101-1    QTM-1101-2
    login_feature.User login via email and password    ${account['superuser']['acc_02']['username']}    ${account['superuser']['acc_02']['password']}
    main_page.User select AI feature
    AI_feature.Verify AI page is displayed correctly for user  
    common.Close the popup system require update
    AI_page.User clicks on menu         ${menu_name['ai_page']['menu_min_max']}

    common.Input article Number     ${QTM_1101['article_number']}
    common_feature.Click expand and select MCH3 categories   
    common_feature.Click expand and select franchise store
    SeleniumLibrary.Press keys    None    ESC
    common.Click button using name            ${button_name['btn_apply']}
    common.Click button using name          ${button_name['btn_edit']}
    common_feature.After click button edit all of these button should be display properly

    min_max_level.Verify the button import file csv should be display
    common.Choose csv file  ${folder_name['csv_data']}    ${QTM_1101['csv_file']}      ${file_extension['csv']}
    common.Verify wording after choose file
    #Waiting for color changed not have animation for wait.
    BuiltIn.Wait until keyword succeeds    3x    2s    min_max_level.Verify adjust letter should be show in blue
    SeleniumLibrary.Press keys    None    ESC
    common_feature.Click discard after check adjust price

    common.Click button using name          ${button_name['btn_edit']}
    common_feature.After click button edit all of these button should be display properly

    min_max_level.Verify the button import file csv should be display
    common.Choose csv file  ${folder_name['csv_data']}    ${QTM_1101['csv_file']}      ${file_extension['csv']}
    common.Verify wording after choose file
    #Waiting for color changed not have animation for wait.
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