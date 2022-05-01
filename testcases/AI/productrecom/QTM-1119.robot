*** Settings ***
Resource    ${CURDIR}/../../../keywords/imports.robot
Test Setup         common.SCG suite setup
Test Teardown      common.SCG suite teardown

*** Test Cases ***
Verify when user imported success - user can came back to save draft
    [Tags]          QTM-1119
    login_feature.User login via email and password     ${account['superuser']['acc_01']['username']}        ${account['superuser']['acc_01']['password']}
    main_feature.Verify superuser login success
    main_page.User select AI feature
    AI_feature.Verify AI page is displayed correctly for user  
    AI_page.User clicks on menu         ${menu_name['ai_page']['menu_product_class_recom']}

    product_recom_page.Verify system landing to product recommendation page properly
    common.Close the popup system require update
    common.Input article Number     ${QTM_1119['article_num']}
    common_feature.Click expand and select MCH3 categories   
    common_feature.Click expand and select franchise store
    SeleniumLibrary.Press keys    None    ESC
    common.Click button using name            ${button_name['btn_apply']}
    common.Click button using name          ${button_name['btn_edit']}
    common_feature.After click button edit all of these button should be display properly
    common_feature.Click discard after check adjust price
    common.Click button using name          ${button_name['btn_edit']}
    
    product_recom_page.Verify the button import file csv should be display
    common.Choose csv file  ${folder_name['csv_data']}    ${productrecom_01['others']['franchisefile']}      ${file_extension['csv']}

    common.Verify wording after choose file
    common.Verify wording upload successfully
    BuiltIn.Wait until keyword succeeds    3x    2s    product_recom_page.Verify adjust letter should be show in blue
    BuiltIn.Wait until keyword succeeds    3x    2s    common.Click button using name         ${button_name['btn_cancel']}

    DobbyWebCommon.Scroll to top of page using java script
    AI_feature.Verify AI page is displayed correctly for user  
    AI_page.User clicks on menu         ${menu_name['ai_page']['menu_min_max']}
    AI_feature.Verify AI page is displayed correctly for user  
    AI_page.User clicks on menu         ${menu_name['ai_page']['menu_product_class_recom']}

    common.Input article Number     ${QTM_1119['article_num']}
    common_feature.Click expand and select MCH3 categories   
    common_feature.Click expand and select franchise store
    SeleniumLibrary.Press keys    None    ESC
    common.Click button using name            ${button_name['btn_apply']}
    common.Click button using name          ${button_name['btn_edit']}
    common_feature.After click button edit all of these button should be display properly
    BuiltIn.Wait until keyword succeeds    3x    2s    product_recom_page.Verify adjust letter should be show in blue
    common_feature.Click discard after check adjust price
