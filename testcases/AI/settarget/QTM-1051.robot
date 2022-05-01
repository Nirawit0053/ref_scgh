*** Settings ***
Resource    ${CURDIR}/../../../keywords/imports.robot
Test Setup         common.SCG suite setup
Test Teardown      common.SCG suite teardown

** Test Cases ***
Verify that sales user able to import file successfully by valid case
    [Tags]          QTM-1051
    login_feature.User login via email and password     ${account['saleuser']['acc_01']['username']}        ${account['saleuser']['acc_01']['password']}
    main_feature.Verify saleuser login success
    common.Close the popup system require update
    main_page.User select AI feature
    AI_feature.Verify AI page is displayed correctly for user  
    AI_page.User clicks on menu         ${menu_name['ai_page']['menu_settarget']}
    settarget_feature.Verify system landing to settarget page properly
    common.Expand MCH3 categoeis
    common.Clear fill input                 ${common.txt_search}
    common.Input search categories name  categories_name=${MCH3_category['paint']}      
    common.Select categories name       name_category=${MCH3_category['paint']}    
    common.Click button using name          ${button_name['btn_apply']}
    common.Click button using name          ${button_name['btn_edit']}
    common_feature.After click button edit all of these button should be display properly
    settarget_page.Verify the button import file csv should be display
    common.Choose csv file  ${folder_name['csv_data']}        ${settarget['csv_file']['QTM-1051']}      ${file_extension['csv']}
    common.Verify wording after choose file 
    settarget_page.Verify sale target should be displayed in blue    ${settarget['sale_target']['jan']}      ${settarget['sale_target']['feb']}       ${settarget['sale_target']['mar']}   
    common.Click button using name    ${button_name['btn_discard']}
    common.Click button discard on modal popup
