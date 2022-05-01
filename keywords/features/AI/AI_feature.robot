
*** Keywords ***
Verify AI page is displayed correctly for user
    AI_page.Verify AI wording is visible in top bar 
    AI_page.Menu should be visible      ${menu_name['ai_page']['menu_settarget']}
    AI_page.Menu should be visible      ${menu_name['ai_page']['menu_display_target']}
    AI_page.Menu should be visible      ${menu_name['ai_page']['menu_product_master']}
    AI_page.Menu should be visible      ${menu_name['ai_page']['menu_forcast']}
    AI_page.Menu should be visible      ${menu_name['ai_page']['menu_dashboard']}
    AI_page.Menu should be visible      ${menu_name['ai_page']['menu_product_class_criteria']}
    AI_page.Menu should be visible      ${menu_name['ai_page']['menu_product_class_recom']}
    AI_page.Menu should be visible      ${menu_name['ai_page']['menu_min_max']}

Click saved information
    common.Click button using name    ${button_name['btn_save_and_submit']}
    AI_page.Verify confirmation when save and submit
    AI_page.Verify approve message
    AI_page.Click button submit
    AI_page.Verify successfully saved 
    AI_page.Click button submit

Click approve information
    common.Click button using name    ${button_name['btn_approve']}
    AI_page.Verify message approve
    AI_page.Click button submit
    AI_page.Verify message successfully approved
    AI_page.Click button submit

Click reject information
    [Arguments]    ${page}
    common.Click button using name    ${button_name['btn_reject']}
    AI_page.Verify reject warning message   ${page}
    AI_page.Click button submit
    AI_page.Verify successfully reject message
    AI_page.Click button submit

Click save and approve
    common.Click button using name    ${button_name['btn_save_and_approve']}
    AI_page.Verify confirmation save and approve
    AI_page.Click button submit
    AI_page.Verify successfully saved
    AI_page.Click button submit
