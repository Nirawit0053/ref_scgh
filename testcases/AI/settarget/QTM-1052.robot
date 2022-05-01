*** Settings ***
Resource    ${CURDIR}/../../../keywords/imports.robot
Test Setup         common.SCG suite setup
Test Teardown      common.SCG suite teardown

** Test Cases ***
Verify that super user able to import file and save successfully
    [Tags]          QTM-1052
    login_feature.User login via email and password     ${account['superuser']['acc_03']['username']}        ${account['superuser']['acc_03']['password']}
    common.Get customer token    ${account['superuser']['acc_03']['username']}        ${account['superuser']['acc_03']['password']}
    main_feature.Verify saleuser login success
    common.Close the popup system require update
    main_page.User select AI feature
    AI_feature.Verify AI page is displayed correctly for user   
    AI_page.User clicks on menu         ${menu_name['ai_page']['menu_settarget']}
    settarget_feature.Verify system landing to settarget page properly
    settarget_page.Update csv file before import file settarget
                ...     ${settarget['csv_file']['QTM-1052']}
                ...     ${settarget['csv_1052']['row']}
                ...     ${settarget['csv_1052']['col']}
    common.Expand MCH3 categoeis
    common.Clear fill input                 ${common.txt_search}
    common.Input search categories name     categories_name=${MCH3_category['paint']}     
    common.Select categories name           name_category=${MCH3_category['paint']}
    common.Click button using name          ${button_name['btn_apply']}
    common.Click button using name          ${button_name['btn_edit']} 
    common_feature.After click button edit all of these button should be display properly
    settarget_page.Verify the button import file csv should be display
    common.Choose csv file  ${folder_name['csv_data']}        ${settarget['csv_file']['QTM-1052']}      ${file_extension['csv']}  
    common.Verify wording after choose file        
    settarget_page.Verify sale target is displayed correctly  
                ...     ${settarget.adjustment_cell}
                ...     ${settarget['csv_file']['QTM-1052']}   
                ...     ${settarget['csv_1052']['row']}
                ...     ${settarget['csv_1052']['col']}
                ...     ${settarget['csv_1052']['target_year']}
                ...     ${settarget['csv_1052']['target_month']}
                ...     font_color=rgba(0, 125, 255, 1)
                ...     background_color=rgba(0, 0, 0, 0)

    DobbyWebCommon.Scroll to top of page using java script
    common.Click expand notification 
    ${noti_id}    common.Get notification id
    common.Verify notification file has been imported  id_transaction=${noti_id}
    SeleniumLibrary.Double click element        ${common.terminate_dropdown}
    ${message_inmail}       common.Get notification message from email
                            ...     ${reg_ex_page['settarget']}
                            ...     ${account['superuser']['acc_03']['username']}
                            ...     ${account['superuser']['acc_03']['password']}
                            ...     ${QTM_1052['folder_email']}
                            ...     ${noti_id} 
    ${expected_message}     common.Get expected notification message    ${notification_message['file_imported']}    ${noti_id}    ${QTM_1052['page']}
    BuiltIn.Should be equal    ${message_inmail}    ${expected_message}    strip_spaces=True
    common_feature.Select action after upload file csv      ${button_name['btn_save']}
    common_feature.Select action after upload file csv      ${button_name['btn_reject']}