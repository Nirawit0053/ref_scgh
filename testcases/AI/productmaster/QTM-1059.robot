*** Settings ***
Resource    ${CURDIR}/../../../keywords/imports.robot
Test Setup         common.SCG suite setup
Test Teardown      common.SCG suite teardown

** Test Cases ***
Verify that super user able to input Replacement Start date and Replacement End date column with valid data
    [Tags]          QTM-1059
    common.Close alert 
    login_feature.User login via email and password                 ${account['superuser']['acc_01']['username']}        ${account['superuser']['acc_01']['password']}
    main_feature.Verify superuser login success
    main_page.User select AI feature
    AI_feature.Verify AI page is displayed correctly for user  
    productmaster_feature.Landing to product master page properly
    common.Expand franchise store
    common.Input franchise store name                               ${franchise_store['scgh_roiEt']}                                 
    common.Select franchise store name                              ${franchise_store['scgh_roiE_8120']}
    common.Expand MCH3 categoeis
    common.Select categories name                               ${MCH3_category['all_category']} 
    common.Expand MCH2 categoeis
    common.Select categories name                               ${MCH2_category['all_category']} 
    common.Input article name                                       ${Article_name['electric_stove']}                               
    common.Click button using name                                  ${button_name['btn_apply']}
    common.Click button using name                                  ${button_name['btn_edit']}
    common_feature.After click button edit all of these button should be display properly                                     
    common.Choose csv file      ${folder_name['csv_data']}        ${productmaster_case1['csv_file']}      ${file_extension['csv']}
    common.Verify wording after choose file 

    #CASE 1 : Replacement Start date and Replacement End date column with valid data.
    productmaster_page.New product replacement is active            ${productmaster_case1['article_number']}     ${productmaster_case1['new_product_replace']}         
   
    #CASE 3 : Verify user input Replacement Start Date > current date.
    productmaster_page.Page should not be display article number    ${productmaster_case3['article_number']}     ${productmaster_case3['no_product_replace']}   

    #CASE 4 : Verify user input Replacement End Date < current date.
    productmaster_page.Page should not be display article number    ${productmaster_case4['article_number']}     ${productmaster_case3['no_product_replace']}   

    common.Click button using name                                  ${button_name['btn_discard']}
    common.Click button discard on modal popup

