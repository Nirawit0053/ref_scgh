*** Settings ***
Resource            ${CURDIR}/../../../keywords/imports.robot
Suite Setup         common.SCG suite setup
Test Teardown       common.SCG suite teardown

** Test Cases ***
Verify user can replace a new product replacement when the previous item was expired
    [Tags]          QTM-1066
    [Setup]         common.Get customer token    ${account['superuser']['acc_03']['username']}        ${account['superuser']['acc_03']['password']}

    common.Close alert 
    login_feature.User login via email and password                 ${account['superuser']['acc_03']['username']}        ${account['superuser']['acc_03']['password']}
    main_feature.Verify superuser login success
    main_page.User select AI feature
    AI_feature.Verify AI page is displayed correctly for user 
    AI_page.User clicks on menu                                     ${menu_name['ai_page']['menu_product_master']} 
    productmaster_feature.Landing to product master page properly  
    common.Expand franchise store                              
    productmaster_page.Select productmaster franchise store name    ${franchise_store['all_store']}
    common.Expand MCH3 categoeis
    common.Select categories name                                   ${MCH3_category['all_category']} 
    common.Expand MCH2 categoeis
    common.Select categories name                                   ${MCH2_category['all_category']}
    common.Input article Number                                     ${QTM_1066['article_number']}
    common.Click button using name                                  ${button_name['btn_apply']}
    common.Click button using name                                  ${button_name['btn_edit']} 
    common_feature.After click button edit all of these button should be display properly
    SeleniumLibrary.Wait until element is visible                   ${settarget.btn_import_csv}
    common.Choose csv file                                          ${folder_name['productmaster']}      ${QTM_1066['file_name']}     ${file_extension['csv']}
    common.Verify wording upload successfully
    productmaster_page.New product replacement is active            ${QTM_1066['article_number']}     ${QTM_1066['new_product_replace']}
    common_feature.Click discard after check adjust price

    DobbyWebCommon.Scroll to top of page using java script
    common.Click expand notification
    common.Click button view all notication
    ${noti_id}    common.Get notification id
    productmaster_page.Verify import file succeeded       ${noti_id}
    productmaster_page.Click productmaster notification succeeded accroding transaction id                ${noti_id}
    ${message_inmail}       productmaster_page.Get product master notification message from email      ${account['superuser']['acc_03']['username']}              ${account['superuser']['acc_03']['password']}    ${folder_email['productmaster']}    ${noti_id} 
    ${expected_message}     common.Get expected notification message        ${notification_message['import_succeeded_productmaster']}    ${noti_id}    ${page['productmaster']}
    ${headles}    SeleniumLibrary.Get window handles
    SeleniumLibrary.Switch Window    ${headles}[1]
    productmaster_feature.Landing to product master page properly
    BuiltIn.Should be equal                                                 ${message_inmail}    ${expected_message}    msg=actual=${message_inmail},expected=${expected_message}
