*** Settings ***
Resource    ${CURDIR}/../../../keywords/imports.robot
Test Teardown    common.SCG suite teardown

** Test Cases ***
Verify that merchandise approver and Super user able to approved adjustment successfully
    [Tags]    QTM-813
    [Setup]    common.Get customer token    ${account['meruser']['acc_02']['username']}    ${account['meruser']['acc_02']['password']}
    ${Directory_download}    common.SCG suite setup
    login_feature.User login via email and password    ${account['superuser']['acc_02']['username']}    ${account['superuser']['acc_02']['password']}
    main_page.User select AI feature 
    forecast_feature.Landing to forecast page properly
    common.Close the popup system require update
    common_feature.Select MCH2 categories    ${MCH2_category['electrical']}    ${MCH2_category['electrical']}
    forecast_page.Clear all categories
    common_feature.Select MCH1 categories    ${MCH1_category['electrical_k1202']['search']}    ${MCH1_category['electrical_k1202']['categories_code']}
    AI_page.Click delete all brands filter
    common_feature.Find brands of categories  ${Brand_name['AXIA']}
    common.Click button using name            ${button_name['btn_apply']}
    common.Click button using name            ${button_name['btn_edit']}
    common_feature.Click discard after check adjust price
    AI_feature.Click reject information    ${page['forecast']} 
    common.Click button user
    common.Click button logout
    login_feature.User login via email and password    ${account['meruser']['acc_02']['username']}    ${account['meruser']['acc_02']['password']}
    main_page.User select AI feature 
    forecast_feature.Landing to forecast page properly
    common_feature.Select MCH2 categories    ${MCH2_category['electrical']}    ${MCH2_category['electrical']}
    forecast_page.Clear all categories
    common_feature.Select MCH1 categories    ${MCH1_category['electrical_k1202']['search']}    ${MCH1_category['electrical_k1202']['categories_code']}
    AI_page.Click delete all brands filter
    common_feature.Find brands of categories  ${Brand_name['AXIA']}
    common.Click button using name            ${button_name['btn_apply']}
    common.Click button using name            ${button_name['btn_edit']}
    common_feature.Click discard after check adjust price
    common.Click button using name            ${button_name['btn_edit']}
    common_feature.After click button edit all of these button should be display properly
    ${value}    String.Generate random string    length=5    chars=[NUMBERS]
    common.Update csv file    ${Qtm_813['csv_file']}    ${Qtm_813['column']}    ${8}   ${value}
    ${data}    common.Get data from csv file    ${Qtm_813['csv_file']}    ${Qtm_813['column']}    ${8}  
    ${price}    common.Get information in list    ${data}    ${14}
    ${real_price}    common.Convert value to currency    ${price}
    common.Choose csv file    ${folder_name['csv_data']}    ${Qtm_813['csv_file']}
    common.Verify wording after choose file
    common.Verify wording upload successfully
    forecast_page.Verify adjust price should be display color blue    ${Qtm_813['code']}    ${Brand_name['AXIA']}    ${real_price}
    ${noti_id}    common.Get notification id
    AI_feature.Click saved information
    DobbyWebCommon.Scroll to bottom of page using java script
    ${actual_import_successed}    common.Get notification message from email    
    ...     ${reg_ex_page['import_request_forecast']}    
    ...     ${account['meruser']['acc_02']['username']}    
    ...     ${account['meruser']['acc_02']['password']}
    ...     ${folder_email['staff_notification']}
    ...     ${noti_id}
    ${expected_import_successed}     common.Get expected notification message    ${notification_message['import_succeeded']}    ${noti_id}    ${page['forecast']}
    BuiltIn.Should be equal    ${actual_import_successed}    ${expected_import_successed}    msg=actual=${actual_import_successed},  msg=${expected_import_successed}
    forecast_page.Verify adjust background color should be display color    ${Qtm_813['code']}    ${Brand_name['AXIA']}    ${real_price}    ${color['grey_color']}

    DobbyWebCommon.Scroll to top of page using java script
    common.Click expand notification 
    common.Verify notification import file successfully should be displayed    ${page['forecast']}    ${noti_id}

    #som to wrap it in dobby open and switch to new tab
    Execute Javascript    window.open('NewTabUrl');
    ${headles}    SeleniumLibrary.Get window handles
    SeleniumLibrary.Switch Window    ${headles}[1]
    #som to wrap it in dobby open and switch to new tab
    common.Click button user
    common.Click button logout
    login_feature.User login via email and password    ${account['mer_approve']['acc_01']['username']}    ${account['mer_approve']['acc_01']['password']}
    main_page.User select AI feature 
    forecast_feature.Landing to forecast page properly
    common_feature.Select MCH2 categories    ${MCH2_category['electrical']}    ${MCH2_category['electrical']}
    forecast_page.Clear all categories
    common_feature.Select MCH1 categories    ${MCH1_category['electrical_k1202']['search']}    ${MCH1_category['electrical_k1202']['categories_code']}
    AI_page.Click delete all brands filter
    common_feature.Find brands of categories  ${Brand_name['AXIA']}
    common.Click button using name    ${button_name['btn_apply']}
    forecast_page.Verify adjust background color should be display color    ${Qtm_813['code']}    ${Brand_name['AXIA']}    ${real_price}    ${color['grey_color']}
    DobbyWebCommon.Scroll to top of page using java script
    common.Click expand notification 
    forecast_page.Verify notification merchandise user submit    ${MCH2_category['electrical']}
    common.Click expand notification 
    DobbyWebCommon.Scroll to bottom of page using java script
    AI_feature.Click approve information
    ${body_email}    common.Get email body then return to text      ${account['mer_approve']['acc_01']['username']}    
    ...   ${account['mer_approve']['acc_01']['password']}    ${folder_email['Merchandise_submit']}
    ${actual_email}    forecast_page.Remove space from message    ${body_email}
    ${expected_email}    forecast_page.Get expected adjustments are waiting for your approval    ${MCH2_category['electrical']}   ${Brand_name['AXIA']}
    BuiltIn.Should be equal    ${actual_email}   ${expected_email}
    forecast_page.Verify adjust background color should be display color    ${Qtm_813['code']}    ${Brand_name['AXIA']}    ${real_price}    ${color['orange_color']}
    common.Click button user
    common.Click button logout
    login_feature.User login via email and password    ${account['superuser']['acc_02']['username']}    ${account['superuser']['acc_02']['password']}
    main_page.User select AI feature 
    forecast_feature.Landing to forecast page properly
    common_feature.Select MCH2 categories    ${MCH2_category['electrical']}    ${MCH2_category['electrical']}
    forecast_page.Clear all categories
    common_feature.Select MCH1 categories    ${MCH1_category['electrical_k1202']['search']}    ${MCH1_category['electrical_k1202']['categories_code']}
    AI_page.Click delete all brands filter
    common_feature.Find brands of categories  ${Brand_name['AXIA']}
    common.Click button using name    ${button_name['btn_apply']}
    common.Click expand notification 
    forecast_page.Verify notification merchandise approve    ${MCH2_category['electrical']}
    common.Click expand notification
    AI_feature.Click approve information
    ${body_email}    common.Get email body then return to text    ${account['superuser']['acc_02']['username']}    ${account['superuser']['acc_02']['password']}  
    ...    ${folder_email['super_approved']}
    ${actual_email_super}    forecast_page.Remove space from message    ${body_email}
    ${expected_mai_super}    forecast_page.Get expected super user approval    ${MCH2_category['electrical']}   ${Brand_name['AXIA']}
    BuiltIn.Should be equal    ${actual_email_super}   ${expected_mai_super}
    DobbyWebCommon.Scroll to bottom of page using java script
    forecast_page.Verify adjust background color should be display color    ${Qtm_813['code']}    ${Brand_name['AXIA']}    ${real_price}    ${color['blue_color']}
    ${headles}    SeleniumLibrary.Get window handles
    SeleniumLibrary.Switch Window    ${headles}[0]
    forecast_page.Verify notification super user approved    ${MCH2_category['electrical']}
    common.Click expand notification
    common.Click button using name    ${button_name['btn_edit']}
    common_feature.Click discard after check adjust price
    ${body_email}    common.Get email body then return to text    ${account['meruser']['acc_02']['username']}    ${account['meruser']['acc_02']['password']}    
    ...    ${folder_email['sp_approved']}
    ${actual_email_noti}   forecast_page.Remove space from message    ${body_email}
    ${expected_email_noti}   Get expected super user approval    ${MCH2_category['electrical']}   ${Brand_name['AXIA']}
    BuiltIn.Should be equal    ${actual_email_noti}   ${actual_email_noti}
    DobbyWebCommon.Scroll to bottom of page using java script
    forecast_page.Verify adjust background color should be display color    ${Qtm_813['code']}    ${Brand_name['AXIA']}    ${real_price}    ${color['blue_color']}
