*** Settings ***
Resource    ${CURDIR}/../../../keywords/imports.robot
Test Setup         common.SCG suite setup
Test Teardown      common.SCG suite teardown

*** Test Cases ***
Verify user able to import CSV file successfully by valid and invalid data, And then re-import success
    [Documentation]     ai-product master
    [Setup]     common.Get customer token    ${account['superuser']['acc_03']['username']}    ${account['superuser']['acc_03']['password']}
    [Tags]          QTM-1068
    ${Directory_download}    common.SCG suite setup
    common.Close alert 
    login_feature.User login via email and password                 ${account['superuser']['acc_03']['username']}        ${account['superuser']['acc_03']['password']}
    main_feature.Verify superuser login success
    main_page.User select AI feature
    AI_feature.Verify AI page is displayed correctly for user  
    productmaster_feature.Landing to product master page properly

    common_feature.Select franchise store    ${EMPTY}    ${franchise_store['all_store']}
    common_feature.Click expand and select MCH3 categories
    common_feature.Select MCH2 categories    ${EMPTY}    ${MCH2_category['all_category']}
    common.Input article Number     ${QTM_1068['article_number']}                            
    common.Click button using name                                  ${button_name['btn_apply']}
    common.Click button using name                                  ${button_name['btn_edit']}

    common_feature.After click button edit all of these button should be display properly                                     
    common.Choose csv file      ${folder_name['csv_data']}    ${QTM_1068['csv_file']['import_file']}      ${file_extension['csv']}
    common.Verify wording after choose file

    common.Choose csv file     ${folder_name['csv_data']}        ${QTM_1068['csv_file']['reimport_file']}      ${file_extension['csv']}
    common.Verify wording after choose file

    common.Download file for edit and move to csv folder    ${QTM_1068['csv_file']['export_file']}    ${Directory_download}
    ${reason}    forecast_page.Get the reason invalid file    ${QTM_1068['csv_file']['export_file']}     ${error_message['replacement_start_date_error']}
    BuiltIn.Should be equal    ${reason}    ${error_message['replacement_start_date_error']}

    common.Click expand notification 
    common.Click button view all notication
    ${noti_id}    common.Get notification id
    ${message_inmail}       common.Get notification message from email
                            ...     ${reg_ex_page['import_productmaster']}
                            ...     ${account['superuser']['acc_03']['username']}
                            ...     ${account['superuser']['acc_03']['password']}
                            ...     ${folder_email['productmaster']}
                            ...     ${noti_id} 
    ${expected_message}     common.Get expected notification message        ${notification_message['import_succeeded_product']}    ${noti_id}    ${page['product_master_download']}
    common.Remove the whitespace from messages then compare    ${message_inmail}    ${expected_message}