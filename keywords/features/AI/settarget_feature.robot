*** keywords ***
Verify system landing to settarget page properly
    settarget_page.Verify settarget title is visible   
    settarget_page.Verify settarget label is visible 
    settarget_page.Verify settarget combo categories is visible
    settarget_page.Verify settarget combo status data is visible

Saleuser save and submit target
    [Documentation]   
    common.Verify button using name     ${button_name['btn_save_and_submit']}
    common.Click button using name      ${button_name['btn_save_and_submit']}
    common.Verify notification on modal popup while action        ${button_msg['btn_save_submit_ask']}
    common.Click button action on modal popup
    common.Click button ok on modal popup after action successfully


