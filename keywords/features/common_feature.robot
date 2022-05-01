*** Keywords ***
Click discard after check adjust price
    [Documentation]    Reject adjust price after import file csv successfully
    common.Click button using name    ${button_name['btn_discard']}
    common.Verify notification on modal popup while discard
    common.Click button discard on modal popup
    common.Verify notification on modal popup while discard successfully
    common.Click button ok on modal popup

#SAVE #REJECT  #DISCARD #APPROVE
Select action after upload file csv
    [Documentation]    Action discard/save/rejct after import file csv successfully
    [Arguments]     ${action}    
    IF  ('${action}' == '${button_name['btn_discard']}')
        ${ask_msg} =     Builtin.Set variable       ${button_msg['btn_discard_ask']}        
        ${done_msg} =    Builtin.Set variable       ${button_msg['btn_discard_done']} 
    ELSE IF     ('${action}' == '${button_name['btn_save']}')
        ${ask_msg} =     Builtin.Set variable       ${button_msg['btn_save_ask']}        
        ${done_msg} =    Builtin.Set variable       ${button_msg['btn_save_done']}
    ELSE IF     ('${action}' == '${button_name['btn_reject']}')
        ${ask_msg} =     Builtin.Set variable       ${button_msg['btn_reject_ask']}        
        ${done_msg} =    Builtin.Set variable       ${button_msg['btn_reject_done']}
    ELSE IF     ('${action}' == '${button_name['btn_approve']}')
        ${ask_msg} =     Builtin.Set variable       ${button_msg['btn_approve_ask']}        
        ${done_msg} =    Builtin.Set variable       ${button_msg['btn_approve_done']}
    END

    common.Verify button using name     ${action}
    common.Click button using name         ${action}
    common.Verify notification on modal popup while action        ${ask_msg}
    common.Click button action on modal popup
    common.Verify notification on modal popup while action successfully       ${done_msg}
    common.Click button ok on modal popup after action successfully

After click button edit all of these button should be display properly
    [Documentation]    After click button edit after choose categories button should be display
    common.Verify button using name    ${button_name['btn_import_file']}
    common.Verify button using name    ${button_name['btn_discard']}
    common.Verify button using name    ${button_name['btn_cancel']}

Select franchise store
    [Documentation]    Use this keyword for select franchise store
    [Arguments]    ${input}    ${select_name}
    common.Expand franchise store
    common.Input search categories name    ${input}
    common.Select categories name    ${select_name}
    SeleniumLibrary.Press Keys    NONE   ESC

Select MCH2 categories
    [Documentation]    Use this keyword for find categories of MCH2
    [Arguments]    ${input}    ${categories_name}
    common.Expand MCH2 categoeis
    common.Input search categories name    ${input}
    common.Select categories name    ${categories_name}
    SeleniumLibrary.Press keys    None    ESC

Select MCH1 categories
    [Documentation]     Use this keyword for find categories of MCH1
    [Arguments]    ${categories_input}    ${categories} 
    common.Expand MCH1 categoeis
    common.Clear fill input    ${forecast.lbl_categories_ch2}
    common.Input search categories name    ${categories_input}
    common.Select categories name    ${categories}
    SeleniumLibrary.Press keys    None    ESC

Find brands of categories
    [Documentation]    Use this keyword for find brands of categories
    [Arguments]    ${brands}
    AI_page.Click expand filter brands
    common.Input search categories name    ${brands}
    common.Select categories name    ${brands}
    SeleniumLibrary.Press keys    None    ESC

Select RDC inventory
    [Documentation]    Select RDC inventory
    [Arguments]    ${input}    ${categories}
    dcrc_page.Expand RDC inventory
    common.Input search categories name    ${input}
    common.Select categories name    ${categories}
    SeleniumLibrary.Press keys    None    ESC

Select DC inventory
    [Documentation]    Select DC inventory
    [Arguments]    ${input}    ${categories}
    dcrc_page.Expand DC inventory
    common.Input search categories name    ${input}
    common.Select categories name    ${categories}
    SeleniumLibrary.Press keys    None    ESC

Click expand and select MCH3 categories
    common.Expand MCH3 categoeis
    common.Select categories name       name_category=${MCH3_category['all_category']}

Click expand and select franchise store
    common.Expand franchise store
    common.Select categories name       name_category=${franchise_store['all_store']}

Click expand and select RDC categories
    common.Expand RDC categories
    common.Select categories name       name_category=${RDC_category['all_category']}

Click expand and select DC categories
    common.Expand DC categories
    common.Select categories name       name_category=${DC_category['all_category']}
