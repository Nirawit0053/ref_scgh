*** Variables ***
${min_max_level_page.row}        xpath=//tr[@class='MuiTableRow-root'][1]
${min_max.td_information_table}     xpath=//tr[@class="MuiTableRow-root"]/td[contains(text(),"{code}")]/following-sibling::td[contains(text(),"{fc_store}")]/following-sibling::td[div[contains(@class,"h-full")]]//div[contains(@class,"h-full") and text()="{value}"]
${min_max_level_page.row}        xpath=//tr[@class='MuiTableRow-root'][1]
${min_max_level_page.result}     (//span[.="Min Level (QTY)"]//ancestor::table//tbody[@class="MuiTableBody-root"])//ancestor::table//tr[2]//div[contains(@class,"h-full flex items-center")][4]
${min_max_level_page.label_min_max}     xpath=//span[@class='mr-2']
${min_max_level_page.label_name_min_max}    xpath=//li[contains(@class,"MuiButtonBase-root") and text()="{label_name}"]
${min_max.td_information_table_2}     xpath=//tr[@class="MuiTableRow-root"]/td[contains(text(),"{rdc_code}")]/following-sibling::td[contains(text(),"{article_number}")]/following-sibling::td[div[contains(@class,"h-full")]]//div[contains(@class,"h-full") and text()="{value}"]

*** Keywords ***
Verify the button import file csv should be display
    [Documentation]   Verify the button import file csv should be display
    SeleniumLibrary.Wait until element is visible    ${productrecom.btn_import_csv}

Verify min max by code and store value in table should be display blue color
    [Arguments]    ${code}    ${fc_store}   ${value}    ${color}=rgba(0, 125, 255, 1)
    ${categories_code}    String.Replace string    ${min_max.td_information_table}    {code}    ${code}
    ${brand_name}    String.Replace string    ${categories_code}    {fc_store}    ${fc_store}
    ${value_total}    String.Replace string    ${brand_name}    {value}    ${value}
    SeleniumLibrary.Wait until element is visible    ${value_total}
    ${text}    DobbyWebCommon.Get text from element when ready    ${value_total}
    ${elements}    SeleniumLibrary.Get WebElement    ${value_total}
    ${bg_color}    Call Method    ${elements}    value_of_css_property    color
    BuiltIn.Should be equal    ${bg_color}    ${color}    msg=actual=${bg_color},expected=${color}

Verify adjust letter should be show in blue
    [Documentation]   Verify adjust letter should be show in blue
    [Arguments]    ${color}=rgba(0, 125, 255, 1)
    SeleniumLibrary.Wait until element is visible    ${min_max_level_page.result}
    ${elements}    SeleniumLibrary.Get WebElement    ${min_max_level_page.result}
    ${bg_color}    Call Method    ${elements}    value_of_css_property    color
    BuiltIn.Should be equal    ${bg_color}    ${color}

Select min and max level by label name
    [Arguments]    ${label_name}
    DobbyWebCommon.Click element when ready     ${min_max_level_page.label_min_max}
    ${new_label_name}       String.Replace string   ${min_max_level_page.label_name_min_max}    {label_name}    ${label_name}   
    DobbyWebCommon.Click element when ready    ${new_label_name}

Verify min max by rdc code and article number in table should be display blue color
    [Arguments]    ${rdc_code}    ${article_number}   ${value}    ${color}=rgba(0, 125, 255, 1)
    ${categories_code}    String.Replace string    ${min_max.td_information_table_2}   {rdc_code}    ${rdc_code}
    ${brand_name}    String.Replace string    ${categories_code}    {article_number}    ${article_number}
    ${value_total}    String.Replace string    ${brand_name}    {value}    ${value}
    SeleniumLibrary.Wait until element is visible    ${value_total}
    ${text}    DobbyWebCommon.Get text from element when ready    ${value_total}
    ${elements}    SeleniumLibrary.Get WebElement    ${value_total}
    ${bg_color}    Call Method    ${elements}    value_of_css_property    color
    BuiltIn.Should be equal    ${bg_color}    ${color}    msg=actual=${bg_color},expected=${color}

Verify notification import file import product min max should be displayed
    [Arguments]    ${page}    ${transection_id}
    ${page}    String.Replace string    ${common.lbl_import_file_min_max}    {page}    ${page}
    ${id}    String.Replace string    ${page}    {transection_id}    ${transection_id}
    SeleniumLibrary.Wait until element is visible    ${id}