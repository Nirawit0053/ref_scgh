*** Settings ***
Resource            ${CURDIR}/../../../keywords/imports.robot
Suite Setup         common.SCG suite setup
Test Teardown       common.SCG suite teardown

** Test Cases ***
Verify that user unable to import successfully by case import text file 
    [Tags]          QTM-1060-01
    [Setup]         common.Get customer token    ${account['superuser']['acc_03']['username']}        ${account['superuser']['acc_03']['password']}
    
    common.Close alert 
    login_feature.User login via email and password                 ${account['superuser']['acc_03']['username']}        ${account['superuser']['acc_03']['password']}
    main_feature.Verify superuser login success
    main_page.User select AI feature
    AI_feature.Verify AI page is displayed correctly for user 
    AI_page.User clicks on menu                                     ${menu_name['ai_page']['menu_product_master']} 
    productmaster_feature.Landing to product master page properly             
    common.Expand franchise store
    common.Input franchise store name                               ${franchise_store['scgh_roiEt']}                                
    common.Select franchise store name                              ${franchise_store['scgh_roiE_8120']}
    common.Expand MCH3 categoeis
    common.Select categories name                                   ${MCH3_category['all_category']} 
    common.Expand MCH2 categoeis
    common.Select categories name                                   ${MCH2_category['all_category']}
    common.Input article name                                       ${Article_name['electric_stove']}  
    common.Click button using name                                          ${button_name['btn_apply']}
    common.Click button using name                                          ${button_name['btn_edit']} 
    common_feature.After click button edit all of these button should be display properly
    settarget_page.Verify the button import file csv should be display
    SeleniumLibrary.Wait until element is visible                           ${settarget.btn_import_csv}
    common.Choose csv file                                                  ${folder_name['productmaster']}      ${QTM_1060_01['file_name']}     ${file_extension['txt']}
    common.Verify error message when import file incorrect condition
    common.Verify button should be disabled using name                       ${button_name['btn_save']}
    DobbyWebCommon.Scroll to top of page using java script
    common.Click expand notification
    common.Click button view all notication
    ${noti_id}    common.Get notification id
    productmaster_page.Verify productmaster after import file filed notifiction should be warning       ${noti_id}
    productmaster_page.Click productmaster notification accroding transaction id                        ${noti_id}
    ${message_inmail}       common.Get notification message from email 
                            ...     ${reg_ex_page['tryagain']}
                            ...     ${account['superuser']['acc_03']['username']}
                            ...     ${account['superuser']['acc_03']['password']}
                            ...     ${folder_email['productmaster']}
                            ...     ${noti_id} 
    ${expected_message}     common.Get expected notification message        ${notification_message['import_request_productmaster']}    ${noti_id}    ${page['productmaster']}
    ${headles}    SeleniumLibrary.Get window handles
    SeleniumLibrary.Switch Window    ${headles}[1]
    productmaster_feature.Landing to product master page properly
    BuiltIn.Should be equal                                                 ${message_inmail}    ${expected_message}    msg=actual=${message_inmail},expected=${expected_message}

