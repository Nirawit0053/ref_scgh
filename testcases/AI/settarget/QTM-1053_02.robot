*** Settings ***
Resource            ${CURDIR}/../../../keywords/imports.robot
Suite Setup         common.SCG suite setup
Test Teardown       common.SCG suite teardown

** Test Cases ***
Verify that sale user unable to import file success by case import text file
    [Tags]          QTM-1053-02     BUG
    [Setup]         common.Get customer token    ${account['saleuser']['acc_02']['username']}        ${account['saleuser']['acc_02']['password']}

    common.Close alert
    login_feature.User login via email and password     ${account['saleuser']['acc_02']['username']}        ${account['saleuser']['acc_02']['password']}
    main_feature.Verify saleuser login success
    main_page.User select AI feature
    AI_feature.Verify AI page is displayed correctly for user
    AI_page.User clicks on menu                         ${menu_name['ai_page']['menu_settarget']}
    settarget_feature.Verify system landing to settarget page properly
    common.Expand MCH3 categoeis
    common.Select categories name                       name_category=${MCH3_category['all_category']}      
    common.Click button using name                      ${button_name['btn_apply']}
    common.Click button using name                      ${button_name['btn_edit']}
    common_feature.Click discard after check adjust price
    common.Click button using name                      ${button_name['btn_edit']} 
    common_feature.After click button edit all of these button should be display properly
    settarget_page.Verify the button import file csv should be display
    SeleniumLibrary.Wait until element is visible       ${settarget.btn_import_csv}
    common.Choose csv file                              ${folder_name['csv_data']}      ${QTM_1053_02['file_name']}     ${file_extension['txt']}
    common.Verify error message when import file incorrect condition
    # 2022-04-28, button Save and Submit is still enabled, report bug to manual team
    common.Verify button should be disabled using name       ${button_name['btn_save_and_submit']}
    common_feature.Click discard after check adjust price
    DobbyWebCommon.Scroll to top of page using java script
    common.Click expand notification
    common.Click button view all notication
    ${noti_id}    common.Get notification id
    settarget_page.Verify settarget after import file filed notifiction should be warning       ${noti_id}
    settarget_page.Click settarget notification accroding transaction id                        ${noti_id}
    ${message_inmail}       common.Get notification message from email 
                            ...     ${reg_ex_page['tryagain']}
                            ...     ${account['saleuser']['acc_02']['username']}
                            ...     ${account['saleuser']['acc_02']['password']}
                            ...     ${folder_email['settarget']}
                            ...     ${noti_id} 
    ${expected_message}     common.Get expected notification message            ${notification_message['import_request_settarget']}    ${noti_id}    ${page['settargets']}
    ${headles}    SeleniumLibrary.Get window handles
    SeleniumLibrary.Switch Window    ${headles}[1]
    settarget_feature.Verify system landing to settarget page properly
    BuiltIn.Should be equal                                                     ${message_inmail}    ${expected_message}    msg=actual=${message_inmail},expected=${expected_message}
