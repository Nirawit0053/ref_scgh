*** Settings ***
Resource    ${CURDIR}/../../../keywords/imports.robot
Test Setup         common.SCG suite setup
Test Teardown      common.SCG suite teardown

** Test Cases ***
Verify that user unable import successfully by invalid file
    [Tags]          QTM-1071-1      QTM-1071-2      QTM-1071-3      QTM-1071-4      QTM-1071-5      QTM-1071-6
    login_feature.User login via email and password     ${account['superuser']['acc_01']['username']}        ${account['superuser']['acc_01']['password']}
    main_feature.Verify superuser login success
    main_page.User select AI feature
    AI_feature.Verify AI page is displayed correctly for user  
    AI_page.User clicks on menu         ${menu_name['ai_page']['menu_product_class_recom']}

    product_recom_page.Verify system landing to product recommendation page properly
    common.Close the popup system require update
    common.Input article Number     ${productrecom_01['article_number']}
    common_feature.Click expand and select MCH3 categories   
    common_feature.Click expand and select franchise store
    SeleniumLibrary.Press keys    None    ESC
    common.Click button using name            ${button_name['btn_apply']}
    common.Click button using name          ${button_name['btn_edit']}
    common_feature.After click button edit all of these button should be display properly
    product_recom_page.Verify the button import file csv should be display
    common.Choose csv file  ${folder_name['others']}  ${productrecom_01['others']['xls']}   ${file_extension['xls']}
    common.Verify error message when import file incorrect condition
    
    common_feature.Click discard after check adjust price
    common.Click button using name          ${button_name['btn_edit']}

    common_feature.After click button edit all of these button should be display properly
    product_recom_page.Verify the button import file csv should be display
    common.Choose csv file  ${folder_name['others']}  ${productrecom_01['others']['txt']}   ${file_extension['txt']}
    common.Verify error message when import file incorrect condition

    SeleniumLibrary.Press keys    None    ESC
    common_feature.Click discard after check adjust price
    common.Click button using name          ${button_name['btn_edit']}
    common_feature.After click button edit all of these button should be display properly
    product_recom_page.Verify the button import file csv should be display
    common.Choose csv file  ${folder_name['others']}  ${productrecom_01['others']['pdf']}   ${file_extension['pdf']}
    common.Verify error message when import file incorrect condition

    SeleniumLibrary.Press keys    None    ESC
    common_feature.Click discard after check adjust price
    common.Click button using name          ${button_name['btn_edit']}
    common_feature.After click button edit all of these button should be display properly
    product_recom_page.Verify the button import file csv should be display
    common.Choose csv file  ${folder_name['others']}  ${productrecom_01['others']['doc']}   ${file_extension['doc']}
    common.Verify error message when import file incorrect condition

    SeleniumLibrary.Press keys    None    ESC
    common_feature.Click discard after check adjust price
    common.Click button using name          ${button_name['btn_edit']}
    common_feature.After click button edit all of these button should be display properly
    product_recom_page.Verify the button import file csv should be display
    common.Choose csv file  ${folder_name['others']}  ${productrecom_01['others']['jpg']}   ${file_extension['jpg']}
    common.Verify error message when import file incorrect condition

    SeleniumLibrary.Press keys    None    ESC
    common_feature.Click discard after check adjust price
    common.Click button using name          ${button_name['btn_edit']}
    common_feature.After click button edit all of these button should be display properly
    product_recom_page.Verify the button import file csv should be display
    common.Choose csv file  ${folder_name['others']}  ${productrecom_01['others']['csv']}   ${file_extension['csv']}
    common.Verify error message when import file incorrect condition

    SeleniumLibrary.Press keys    None    ESC
    common_feature.Click discard after check adjust price
