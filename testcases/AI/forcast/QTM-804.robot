*** Settings ***
Resource            ${CURDIR}/../../../keywords/imports.robot
Test Setup         common.SCG suite setup
Test Teardown      common.SCG suite teardown

** Test Cases ***
Client should be able import csv file successfully
    [Tags]    QTM-804

    login_feature.User login via email and password     ${account['meruser']['acc_01']['username']}    ${account['meruser']['acc_01']['password']} 
    main_page.User select AI feature 
    forecast_feature.Landing to forecast page properly
    common.Close the popup system require update
    forecast_feature.Select category same name more than two name    ${MCH2_category['sink_equipment']}
    forecast_page.Clear all categories

    common_feature.Select MCH1 categories    ${MCH1_category['sink_counter_k301']['search']}    ${MCH1_category['sink_counter_k301']['categories_code']}
    common_feature.Select MCH1 categories    ${MCH1_category['sink_k302']['search']}     ${MCH1_category['sink_k302']['categories_code']}
    common.Click button using name            ${button_name['btn_apply']}

    ${value_csv}        forecast_page.Get value from csv accroding column name    ${forecast_01['csv_file']}    ${forecast_01['csv_value']}
    ${value_graph}      forecast_page.Get forecast of January from overview graph    ${forecast_01['js_file']}
    BuiltIn.Should be equal    ${value_csv}    ${value_graph}
    
    common.Click button using name    ${button_name['btn_edit']}
    common_feature.After click button edit all of these button should be display properly
    common.Choose csv file    ${folder_name['csv_data']}    ${forecast_01['csv_file']}
    common.Verify wording after choose file
    common.Verify wording upload successfully
    # #case1
    ${list}    common.Get data from csv file    ${forecast_01['csv_file']}    ${forecast_01['data_csv']['column_name']}    ${forecast_01['data_csv']['index_file_csv'][0]}
    ${value_from_excel}    common.Get information in list    ${list}    ${forecast_01['data_csv']['index_file_csv'][1]}
    ${real_price}    common.Convert value to currency    ${value_from_excel}
    forecast_page.Verify adjust price should be display color blue    ${forecast_01['information']['code']}    ${forecast_01['information']['brand']}    ${real_price}
    
    # #case2 
    ${value_from_excel}    common.Get information in list    ${list}    ${forecast_01['data_csv']['index_file_csv'][2]}
    ${round_decimal}    common.Round decimal value    ${value_from_excel}
    forecast_page.Verify adjust price should be display color blue    ${forecast_01['information']['code']}    ${forecast_01['information']['brand']}    ${round_decimal}   
    
    # #case3
    ${value_from_excel}    common.Get information in list    ${list}    ${forecast_01['data_csv']['index_file_csv'][3]}
    ${millon_bath}    common.Convert price to million baht    ${value_from_excel}
    forecast_page.Verify adjust price should be display color blue    ${forecast_01['information']['code']}    ${forecast_01['information']['brand']}    ${millon_bath}  
    
    # #Short term code
    common_feature.Click discard after check adjust price
