*** Settings ***
Resource    ${CURDIR}/../../../keywords/imports.robot
Test Setup         common.SCG suite setup    
Test Teardown      common.SCG suite teardown

** Test Cases ***
Verify that sale user unable to import file success by invalid case
    [Tags]          QTM-1054
    login_feature.User login via email and password     ${account['saleuser']['acc_03']['username']}        ${account['saleuser']['acc_03']['password']}
    common.Get customer token    ${account['saleuser']['acc_03']['username']}        ${account['saleuser']['acc_03']['password']}
    main_feature.Verify saleuser login success
    common.Close the popup system require update
    main_page.User Select AI Feature
    AI_feature.Verify AI page is displayed correctly for user 
    AI_page.User Clicks On Menu         ${menu_name['ai_page']['menu_settarget']}
    settarget_feature.Verify system landing to settarget page properly
    common.Expand MCH3 categoeis
    common.Clear fill input                 ${common.txt_search}
    common.Input search categories name     categories_name=${MCH3_category['hardware']}     
    common.Select categories name           name_category=${MCH3_category['hardware']}
    common.Expand MCH3 categoeis
    common.Clear fill input                 ${common.txt_search}
    common.Input search categories name     categories_name=${MCH3_category['kitchen']}     
    common.Select categories name           name_category=${MCH3_category['kitchen']}
    common.Expand MCH3 categoeis
    common.Clear fill input                 ${common.txt_search}
    common.Input search categories name     categories_name=${MCH3_category['paint']}     
    common.Select categories name           name_category=${MCH3_category['paint']}
    common.Expand MCH3 categoeis
    common.Clear fill input                 ${common.txt_search}
    common.Input search categories name     categories_name=${MCH3_category['restroom']}     
    common.Select categories name           name_category=${MCH3_category['restroom']}    
    common.Click button using name          ${button_name['btn_apply']}
    common.Click button using name          ${button_name['btn_edit']} 
    common_feature.After click button edit all of these button should be display properly
    settarget_page.Verify the button import file csv should be display
    common.Choose csv file  ${folder_name['csv_data']}        ${settarget['csv_file']['QTM-1054']}      ${file_extension['csv']}  
    common.Verify wording after choose file 
    DobbyWebCommon.Scroll to top of page using java script
    common.Click expand notification 
    common.Click button view all notication
    ${noti_id}    common.Get notification id
    ${unexpected_id}    common.Get unexpected notification
    settarget_page.Verify settarget unexpected notification    ${unexpected_id}    ${QTM_1054['item']}  
    settarget_page.Click settarget unexpected notification    ${unexpected_id}    ${QTM_1054['item']}       

    ${actual_notifiction_mail}    common.Get notification message from email
                                    ...    ${reg_ex_page['settarget']}
                                    ...    ${account['saleuser']['acc_03']['username']}
                                    ...    ${account['saleuser']['acc_03']['password']}
                                    ...    ${QTM_1054['folder_email']}
                                    ...    ${unexpected_id}          
    ${expected_notification}    settarget_page.Get expected settarget notification unexpected message     ${notification_message['invalid_target_data']}    ${unexpected_id}
    ...   ${QTM_1054['item']}
    BuiltIn.Should be equal     ${actual_notifiction_mail}      ${expected_notification}       strip_spaces=True

