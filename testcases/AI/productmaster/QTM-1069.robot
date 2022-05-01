*** Settings ***
Resource            ${CURDIR}/../../../keywords/imports.robot
Suite Setup         common.SCG suite setup
Test Teardown       common.SCG suite teardown

** Test Cases ***
Verify when user imported success, user can came back to save draft 
    [Tags]          QTM-1069
    [Setup]         common.Get customer token    ${account['superuser']['acc_03']['username']}        ${account['superuser']['acc_03']['password']}
    
    common.Close alert 
    login_feature.User login via email and password                 ${account['superuser']['acc_03']['username']}        ${account['superuser']['acc_03']['password']}
    main_feature.Verify superuser login success
    main_page.User select AI feature
    AI_feature.Verify AI page is displayed correctly for user 
    AI_page.User clicks on menu                                     ${menu_name['ai_page']['menu_product_master']} 
    productmaster_feature.Landing to product master page properly             
    common.Expand franchise store                              
    common.Select franchise store name                              ${franchise_store['all_store']}   
    common.Expand MCH3 categoeis
    common.Select categories name                                   ${MCH3_category['all_category']} 
    common.Expand MCH2 categoeis
    common.Select categories name                                   ${MCH2_category['all_category']}
    common.Input article Number                                     ${QTM_1069['article_number']}   
    common.Click button using name                                  ${button_name['btn_apply']}
    common.Click button using name                                  ${button_name['btn_edit']} 
    common_feature.After click button edit all of these button should be display properly
    settarget_page.Verify the button import file csv should be display
    SeleniumLibrary.Wait until element is visible                           ${settarget.btn_import_csv}
    common.Choose csv file                                                  ${folder_name['csv_data']}      ${QTM_1069['csv_file']}     ${file_extension['csv']}
    common.Verify wording upload successfully  
    common.Click button using name                                  ${button_name['btn_cancel']}
    AI_page.User clicks on menu                                     ${menu_name['ai_page']['menu_min_max']}
    AI_page.User clicks on menu                                     ${menu_name['ai_page']['menu_product_master']} 
    productmaster_feature.Landing to product master page properly             
    common.Expand franchise store                              
    common.Select franchise store name                              ${franchise_store['all_store']}   
    common.Expand MCH3 categoeis
    common.Select categories name                                   ${MCH3_category['all_category']} 
    common.Expand MCH2 categoeis
    common.Select categories name                                   ${MCH2_category['all_category']}
    common.Input article Number                                     ${QTM_1069['article_number']}   
    common.Click button using name                                  ${button_name['btn_apply']}
    common.Click button using name                                  ${button_name['btn_edit']} 
    common_feature.Select action after upload file csv      ${button_name['btn_discard']}
    DobbyWebCommon.Scroll to top of page using java script
    common.Click expand notification
    common.Click button view all notication
    ${noti_id}    common.Get notification id   
    productmaster_page.Verify import file succeeded       ${noti_id}
    productmaster_page.Click productmaster notification succeeded accroding transaction id             ${noti_id}
    
    ${message_inmail}       common.Get notification message from email 
                            ...     ${reg_ex_page['productmaster']}
                            ...     ${account['superuser']['acc_03']['username']}
                            ...     ${account['superuser']['acc_03']['password']}
                            ...     ${folder_email['productmaster']}
                            ...     ${noti_id} 
    ${expected_message}     common.Get expected notification message        ${notification_message['import_productmaster_succeeded']}    ${noti_id}    ${page['productmaster']}
    BuiltIn.Should be equal        ${message_inmail}    ${expected_message}    strip_spaces=True  
    ${handles}    SeleniumLibrary.Get window handles
    SeleniumLibrary.Switch Window    ${handles}[1]
    productmaster_feature.Landing to product master page properly


