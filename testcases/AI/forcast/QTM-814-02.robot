*** Settings ***
Resource    ${CURDIR}/../../../keywords/imports.robot
Test Teardown    common.SCG suite teardown

** Test Cases ***
Verify that Merchandise approver and super user able to reject adjustment successfully
    [Tags]    QTM-814
    [Setup]    common.Get customer token    ${account['meruser']['acc_02']['username']}    ${account['meruser']['acc_02']['password']}
    ${Directory_download}    common.SCG suite setup
    login_feature.User login via email and password    ${account['superuser']['acc_02']['username']}    ${account['superuser']['acc_02']['password']}
    main_page.User select AI feature 
    forecast_feature.Landing to forecast page properly
    common.Close the popup system require update

    common_feature.Select MCH2 categories    ${MCH2_category['Handle_knob']}    ${MCH2_category['Handle_knob']}
    forecast_page.Clear all categories
    common_feature.Select MCH1 categories    ${MCH1_category['handle']['search']}    ${MCH1_category['handle']['categories_code']}
    AI_page.Click delete all brands filter
    common_feature.Find brands of categories  ${Brand_name['LIDO']}

    common.Click button using name            ${button_name['btn_apply']}
    common.Click button using name            ${button_name['btn_edit']}
    common_feature.Click discard after check adjust price
    AI_feature.Click reject information    ${page['forecast']}
    
#Merchandise user submit
    common.Click button user
    common.Click button logout

    login_feature.User login via email and password    ${account['meruser']['acc_02']['username']}    ${account['meruser']['acc_02']['password']}
    main_page.User select AI feature 
    forecast_feature.Landing to forecast page properly

    common_feature.Select MCH2 categories    ${MCH2_category['Handle_knob']}    ${MCH2_category['Handle_knob']}
    forecast_page.Clear all categories
    common_feature.Select MCH1 categories    ${MCH1_category['handle']['search']}    ${MCH1_category['handle']['categories_code']}
    AI_page.Click delete all brands filter
    common_feature.Find brands of categories  ${Brand_name['LIDO']}

    common.Click button using name            ${button_name['btn_apply']}
    common.Click button using name            ${button_name['btn_edit']}
    common_feature.Click discard after check adjust price
    common.Click button using name            ${button_name['btn_edit']}
    common_feature.After click button edit all of these button should be display properly

    ${value}    String.Generate random string    length=5    chars=[NUMBERS]
    common.Update csv file    ${Qtm_814['csv_file'][1]}    ${Qtm_813['column']}    ${8}   ${value}
    ${data}    common.Get data from csv file    ${Qtm_814['csv_file'][1]}    ${Qtm_813['column']}    ${8}  
    ${price}    common.Get information in list    ${data}    ${14}
    ${real_price}    common.Convert value to currency    ${price}

    common.Choose csv file    ${folder_name['csv_data']}    ${Qtm_814['csv_file'][1]}
    common.Verify wording after choose file
    common.Verify wording upload successfully
    AI_feature.Click saved information

#Merchandise approved
    Execute Javascript    window.open('NewTabUrl');
    ${headles}    SeleniumLibrary.Get window handles
    SeleniumLibrary.Switch Window    ${headles}[1]
    common.Click button user
    common.Click button logout
    login_feature.User login via email and password    ${account['mer_approve']['acc_01']['username']}    ${account['mer_approve']['acc_01']['password']}
    main_page.User select AI feature 
    forecast_feature.Landing to forecast page properly

    common_feature.Select MCH2 categories    ${MCH2_category['Handle_knob']}    ${MCH2_category['Handle_knob']}
    forecast_page.Clear all categories
    common_feature.Select MCH1 categories    ${MCH1_category['handle']['search']}    ${MCH1_category['handle']['categories_code']}
    AI_page.Click delete all brands filter
    common_feature.Find brands of categories  ${Brand_name['LIDO']}
    common.Click button using name    ${button_name['btn_apply']}
    AI_feature.Click approve information

#Super super reject
    common.Click button user
    common.Click button logout
    login_feature.User login via email and password    ${account['superuser']['acc_02']['username']}    ${account['superuser']['acc_02']['password']}
    main_page.User select AI feature 
    forecast_feature.Landing to forecast page properly

    common_feature.Select MCH2 categories    ${MCH2_category['Handle_knob']}    ${MCH2_category['Handle_knob']}
    forecast_page.Clear all categories
    common_feature.Select MCH1 categories    ${MCH1_category['handle']['search']}    ${MCH1_category['handle']['categories_code']}
    AI_page.Click delete all brands filter
    common_feature.Find brands of categories  ${Brand_name['LIDO']}

    common.Click button using name            ${button_name['btn_apply']}
    AI_feature.Click reject information    ${page['forecast']}
    DobbyWebCommon.Scroll to bottom of page using java script

    #Waiting for color changed not have animation for wait.
    BuiltIn.Wait until keyword succeeds    3x    2s    forecast_page.Verify adjust background color should be display color    ${Qtm_814['code']}    ${Brand_name['LIDO']}
    ...    ${real_price}    ${color['red_color']}
    SeleniumLibrary.Switch Window    ${headles}[0]
    common.Click expand notification
    forecast_page.Verify notification superuser has reject    ${MCH2_category['Handle_knob']}
    ${actual_notification_email}    common.Get email body then return to text    ${account['meruser']['acc_02']['username']}    
    ...    ${account['meruser']['acc_02']['password']}    ${folder_email['merchandise_reject']}
    ${actual_email}    forecast_page.Remove space from message    ${actual_notification_email}
    ${expected_email}    forecast_page.Get expected notification super user rejected    ${MCH2_category['Handle_knob']}    ${Brand_name['LIDO']}
    BuiltIn.Should be equal    ${actual_email}    ${expected_email}
    common.Click expand notification
    DobbyWebCommon.Scroll to bottom of page using java script
    common.Click button using name            ${button_name['btn_edit']}
    common_feature.Click discard after check adjust price
