*** keywords ***
Landing to forecast page properly
    forecast_page.Click menu forecast
    forecast_page.Verify system landing to forecast page properly

Select category same name more than two name
    [Arguments]    ${name_category}  
    common.Expand MCH2 categoeis
    common.Wait until all categories appear
    common.Input search categories name   ${name_category}                                                                                                                    
    forecast_page.Select categories name more than 2 type    ${name_category}  
