*** Settings ***
Resource    ${CURDIR}/../../../keywords/imports.robot
Test Teardown    common.SCG suite teardown

** Test Cases ***
Verify that super user able to import successfully and save and approve successfully
    [Tags]    QTM-815
    ${Directory_download}    common.SCG suite setup 
    login_feature.User login via email and password    ${account['superuser']['acc_02']['username']}    ${account['superuser']['acc_02']['password']}
    main_page.User select AI feature 
    forecast_feature.Landing to forecast page properly
    common.Close the popup system require update

    common_feature.Select MCH2 categories    ${MCH2_category['Handle_knob']}    ${MCH2_category['Handle_knob']}
    forecast_page.Clear all categories
    common_feature.Select MCH1 categories    ${MCH1_category['handle']['search']}    ${MCH1_category['handle']['categories_code']}
    AI_page.Click delete all brands filter
    common_feature.Find brands of categories  ${Brand_name['HAFELE']}

    common.Click button using name            ${button_name['btn_apply']}
    common.Click button using name            ${button_name['btn_edit']}
    common_feature.Click discard after check adjust price
    AI_feature.Click reject information    ${page['forecast']}
    common.Click button using name            ${button_name['btn_edit']}
    common_feature.After click button edit all of these button should be display properly

    ${value}    String.Generate random string    length=5    chars=[NUMBERS]
    common.Update csv file    ${QTM_815['csv_file']}    ${Qtm_813['column']}    ${8}   ${value}
    ${data}    common.Get data from csv file    ${QTM_815['csv_file']}    ${Qtm_813['column']}    ${8}  
    ${price}    common.Get information in list    ${data}    ${14}
    ${real_price}    common.Convert value to currency    ${price}

    common.Choose csv file    ${folder_name['csv_data']}    ${QTM_815['csv_file']}
    common.Verify wording after choose file
    common.Verify wording upload successfully
    forecast_page.Verify adjust price should be display color blue      ${QTM_815['code']}    ${Brand_name['HAFELE']}   ${real_price}

    AI_feature.Click save and approve
    DobbyWebCommon.Scroll to top of page using java script
    common.Click expand notification
    forecast_page.Verify notification super user approved    ${MCH2_category['Handle_knob']}
    
