*** Variables ***
${forecast.lbl_forecast}                xpath=//label[@aria-label="setForecast"]
${forecast.lbl_title_forecast}          xpath=//div[text()="FORECAST"]
${forecast.cb_categories_more_than}     xpath=(//span[contains(@class,"MuiTypography-root") and text()="categories_name"]//ancestor::span)
${forecast.td_number}                   xpath=//tbody/tr/td[text()="{categories_code}"]/following::td[text()="{brand_name}"]/following::td[.="ADJUST (value)"]/following-sibling::td//span[text()="{information}" or .="{information}"]
${forecast.td_background_color}                   xpath=//tbody/tr/td[text()="{categories_code}"]/following::td[text()="{brand_name}"]/following::td[.="ADJUST (value)"]/following-sibling::td//span[text()="{information}" or .="{information}"]/parent::td
${forecast.terminate_dropdown}          xpath=//div[@class="px-6"]
${forecast.txt_all_categories}          xpath=//span[text()='All Categories']/following-sibling::*[local-name()="svg"][contains(@class,"MuiChip-deleteIcon")]
${forecast.lbl_categories_ch2}          xpath=//input[contains(@class,"Input-inputAdornedStart")]
${forecast.txt_all_categories}    xpath=(//*[local-name()="svg"][contains(@class,"MuiChip-deleteIcon")])[2]
${forecast.td_information_table}    xpath=(//tbody/tr/td[text()="{categories_code}"]/following::td[text()="{brand_name}"]/following::td[.="ADJUST (value)"]/following-sibling::td//span[@class="text-info font-semibold" and text()="-"])
${forecast.td_table_error}    xpath=(//tbody/tr/td[text()="{categories_code}"]/following::td[text()="{brand_name}"]/following::td[.="ADJUST (value)"]//following-sibling::td[contains(@class,"MuiTableCell-root MuiTableCell-body {table_error}")])
${forecast.lbl_submit_forecast}    xpath=(//p[text()="Merchandise User for automate has submitted new forecast adjustments on {date}. For categories: {categories}. More detail."])[1]
${forecast.lbl_noti_merchandise_approve}    xpath=(//p[text()="Merchandise Approver for automate has approved new forecast adjustments. For categories: {categories}. Please approve within {day_remaining} day(s), it will be automatic approve. More detail."])[1]
${forecast.lbl_noti_super_user_approved}    xpath=(//p[text()="Superuser1 Automate has approved new forecast adjustments. For categories: {categories}. The approval process is complete. More detail."])[1]
${forecast.lbl_noti_mer_app_reject}    xpath=(//p[text()="Merchandise Approver for automate has rejected new forecast adjustments. For categories: {{categories}}. Reason: . More detail."])[1]
${forecast.lbl_noti_super_app_reject}    xpath=(//p[text()="Superuser1 Automate has rejected new forecast adjustments. For categories: {{categories}}. Reason: . More detail."])[1]

*** Keywords ***
Click menu forecast
    [Documentation]    Click to landing to forecast page.
    DobbyWebCommon.Click element when ready    ${forecast.lbl_forecast}

Verify system landing to forecast page properly
    SeleniumLibrary.Wait until element is visible    ${forecast.lbl_title_forecast}

Select categories name more than 2 type
    [Arguments]    ${categories_name}
    ${name}     String.Replace string    ${forecast.cb_categories_more_than}    categories_name    ${categories_name}
    ${count}    SeleniumLibrary.Get element count    ${name} 
    FOR    ${i}    IN RANGE   1    ${count}+1
        ${number}       BuiltIn.Convert to string    ${i}
        ${path}         BuiltIn.Catenate    ${forecast.cb_categories_more_than}\[{count}]
        ${catename}     String.Replace string    ${path}    categories_name    ${categories_name}
        ${count_run}    String.Replace string    ${catename}    {count}    ${number}
        DobbyWebCommon.Click element when ready    ${count_run}
    END
    SeleniumLibrary.Double click element    ${forecast.terminate_dropdown}

Verify adjust price should be display color blue
    [Arguments]    ${code}    ${brand}    ${information}    ${color}=rgba(0, 125, 255, 1)
    [Documentation]    ${code} is categories code in table 
    ...    ${brand} is categoeis brand in table
    ...    ${information} is adjust price or data according import file csv
    ...    ${color} is color wordding after import csv successfully
    ${categories_code}      String.Replace string    ${forecast.td_number}    {categories_code}    ${code}
    ${brand_name}           String.Replace string    ${categories_code}    {brand_name}    ${brand}
    ${information}          String.Replace string   ${brand_name}    {information}    ${information}    
    SeleniumLibrary.Wait until element is visible    ${information}
    ${elements}    SeleniumLibrary.Get WebElement    ${information}
    ${bg_color}    Call Method    ${elements}    value_of_css_property    color
    BuiltIn.Should be equal    ${bg_color}    ${color}

Clear all categories
    DobbyWebCommon.Click element when ready    ${forecast.txt_all_categories}
    
Get forecast of January from overview graph
    [Arguments]    ${path_file}
    ${forecast}=     Execute JavaScript      ${CURDIR}${/}..${/}..${/}..${/}resources${/}library${/}custom_script${/}${path_file}.js
    [Return]    ${forecast}

Get value from csv accroding column name
    [Arguments]    ${path_file}    ${name}
    ${path_name}    OperatingSystem.Join path    ${CURDIR}${/}..${/}..${/}..${/}resources${/}csv_data${/}${path_file}.csv
    ${csv_data}=    CSVLibrary.Read Csv File To List  ${path_name}
    ${value}    Create list
    ${starting_price}=   Set variable  0
    FOR    ${row}    IN    @{csv_data}
        ${index}=    BuiltIn.Set Variable    ${0}
        FOR    ${each}    IN    @{row}
            ${status}=    BuiltIn.Run keyword and return status    BuiltIn.Should be equal    ${each}    ${name}
            IF    ${status}
                ${ignore_index}=        BuiltIn.Evaluate    ${index} + 1
                ${next}=                Collections.Get From List    ${row}    ${ignore_index}
                ${next}                 BuiltIn.Evaluate      ${next}+${starting_price}
                ${starting_price}=      BuiltIn.Set variable    ${next}
                ${round_decimal}=       BuiltIn.Evaluate    "{:.3f}".format(${starting_price})
                
            END
            ${index}=    BuiltIn.Evaluate    ${index} + 1
        END
    END
    ${round_decimal}=   BuiltIn.Evaluate    "{:.2f}".format(${round_decimal})
    [Return]    ${round_decimal}

Get forecast table error field and verify border field
    [Arguments]    ${path_file}    ${code}    ${brand}    ${border_color}=2px solid rgb(244, 67, 54)
    ${table}=    Execute JavaScript     ${CURDIR}${/}..${/}..${/}..${/}resources${/}library${/}custom_script${/}${path_file}.js
    ${categories_code}    String.Replace string    ${forecast.td_table_error}    {categories_code}    ${code}
    ${brand_name}    String.Replace string    ${categories_code}    {brand_name}    ${brand}
    ${table_error}    String.Replace string    ${brand_name}    {table_error}    ${table}
    SeleniumLibrary.Wait until element is visible    ${table_error}
    ${count}    SeleniumLibrary.Get element count    ${table_error}
    FOR    ${i}    IN RANGE  1    ${count}+1
        ${error}    BuiltIn.Catenate    ${table_error}\[${i}]
        ${elements}    SeleniumLibrary.Get WebElement    ${error}
        ${border}    Call Method    ${elements}    value_of_css_property    border
        BuiltIn.Should be equal    ${border}    ${border_color}    msg=actual=${border},expected=${border_color}
    END
    [Return]    ${border}

Verify value in table should be display blue color
    [Arguments]    ${code}    ${brand}   ${color}=rgba(0, 125, 255, 1)
    ${categories_code}    String.Replace string    ${forecast.td_information_table}    {categories_code}    ${code}
    ${brand_name}    String.Replace string    ${categories_code}    {brand_name}    ${brand}
    SeleniumLibrary.Wait until element is visible    ${brand_name}
    ${count}    SeleniumLibrary.Get element count    ${brand_name}
    FOR    ${i}    IN RANGE  1  ${count}+1
        ${information}    BuiltIn.Catenate    ${brand_name}\[${i}]
        ${text}    DobbyWebCommon.Get text from element when ready    ${information}
        ${elements}    SeleniumLibrary.Get WebElement    ${information}
        ${bg_color}    Call Method    ${elements}    value_of_css_property    color
        BuiltIn.Should be equal    ${bg_color}    ${color}    msg=actual=${bg_color},expected=${color}
    END

Get the reason invalid file
    [Arguments]    ${path_file}    ${value_valid}
    ${path_name}    OperatingSystem.Join path    ${CURDIR}${/}..${/}..${/}..${/}resources${/}csv_data${/}${path_file}.csv
    ${csv_data}=    CSVLibrary.Read Csv File To List  ${path_name}
    FOR    ${row}    IN    @{csv_data}
        ${index}   BuiltIn.Set variable   ${0}
        FOR    ${coulumn}  IN  @{row}
            ${status}    BuiltIn.Run keyword and return status    BuiltIn.Should contain    ${coulumn}  ${value_valid}
            IF  ${status}
                ${value}=    Collections.Get From List    ${row}    ${index}
            END
        ${index}   BuiltIn.Evaluate  ${index} + 1
        END
    END
    [Return]    ${value}

Verify adjust background color should be display color
    [Arguments]    ${code}    ${brand}    ${information}    ${color}=rgba(0, 125, 255, 1)
    [Documentation]    ${code} is categories code in table 
    ...    ${brand} is categoeis brand in table
    ...    ${information} is adjust price or data according import file csv
    ...    ${color} is color wordding after import csv successfully
    ${categories_code}      String.Replace string    ${forecast.td_background_color}    {categories_code}    ${code}
    ${brand_name}           String.Replace string    ${categories_code}    {brand_name}    ${brand}
    ${information}          String.Replace string   ${brand_name}    {information}    ${information}    
    SeleniumLibrary.Wait until element is visible    ${information}
    ${elements}    SeleniumLibrary.Get WebElement    ${information}
    ${bg_color}    Call Method    ${elements}    value_of_css_property    background-color
    BuiltIn.Should be equal    ${bg_color}    ${color}

Verify notification merchandise user submit
    [Arguments]    ${categories}
    ${date}    DateTime.Get current date   time_zone=UTC   result_format=%Y-%m-%d 
    ${message}    String.Replace string    ${forecast.lbl_submit_forecast}    {date}    ${date}
    ${message}    String.Replace string    ${message}    {categories}    ${categories}
    SeleniumLibrary.Wait until element is visible    ${message}

Remove space from message
    [Documentation]    use for remove space 
    [Arguments]    ${message}
    ${message_result}    String.Remove string    ${message}    ${SPACE}
    ${message_result}    String.Remove string    ${message_result}    \n
    ${message_result}    String.Remove string    ${message_result}    \r
    [Return]    ${message_result}

Get expected adjustments are waiting for your approval
    [Arguments]    ${categories}    ${brand}
    ${date_end_month}    date_time.Current end month 
    ${current_date}    DateTime.Get current date    time_zone=UTC    result_format=%d
    ${day_remaining}    BuiltIn.Evaluate    ${date_end_month} - ${current_date}
    ${day_remaining}    BuiltIn.Convert to string    ${day_remaining}
    ${date}    DateTime.Get current date    time_zone=UTC    result_format=%d-%m-%Y
    ${message}    String.Replace string    ${body_email['waiting_for_your_approval']}    {current_date}    ${date}
    ${message}    String.Replace string    ${message}    {categories}    ${categories}
    ${message}    String.Replace string    ${message}    {brand}    ${brand}
    ${message}    String.Replace string    ${message}    {day_remaining}    ${day_remaining}
    [Return]    ${message}

Verify notification merchandise approve
    [Arguments]    ${categories}
    ${date_end_month}    date_time.Current end month 
    ${current_date}    DateTime.Get current date    time_zone=UTC    result_format=%d
    ${day_remaining}    BuiltIn.Evaluate    ${date_end_month} - ${current_date}
    ${day_remaining}    BuiltIn.Convert to string    ${day_remaining}
    ${notification}    String.Replace string    ${forecast.lbl_noti_merchandise_approve}    {categories}    ${categories}
    ${notification}    String.Replace string    ${notification}    {day_remaining}    ${day_remaining}
    SeleniumLibrary.Wait until element is visible    ${notification}

Get expected super user approval
    [Arguments]    ${categories}    ${brand}
    ${date_end_month}    date_time.Current end month 
    ${current_date}    DateTime.Get current date    time_zone=UTC    result_format=%d
    ${day_remaining}    BuiltIn.Evaluate    ${date_end_month} - ${current_date}
    ${day_remaining}    BuiltIn.Convert to string    ${day_remaining}
    ${date}    DateTime.Get current date    time_zone=UTC    result_format=%d-%m-%Y
    ${message}    String.Replace string    ${body_email['superuser_approval']}    {current_date}    ${date}
    ${message}    String.Replace string    ${message}    {categories}    ${categories}
    ${message}    String.Replace string    ${message}    {brand}    ${brand}
    ${message}    String.Replace string    ${message}    {day_remaining}    ${day_remaining}
    [Return]    ${message}

Verify notification super user approved
    [Arguments]    ${categories}
    ${notification}    String.Replace string    ${forecast.lbl_noti_super_user_approved}    {categories}    ${categories}
    SeleniumLibrary.Wait until element is visible    ${notification}

Get expected notification approved
    [Arguments]    ${categories}    ${brand}
    ${date_end_month}    date_time.Current end month 
    ${current_date}    DateTime.Get current date    time_zone=UTC    result_format=%d
    ${day_remaining}    BuiltIn.Evaluate    ${date_end_month} - ${current_date}
    ${day_remaining}    BuiltIn.Convert to string    ${day_remaining}
    ${date}    DateTime.Get current date    time_zone=UTC    result_format=%d-%m-%Y
    ${message}    String.Replace string    ${body_email['superuser_approval']}    {current_date}    ${date}
    ${message}    String.Replace string    ${message}    {categories}    ${categories}
    ${message}    String.Replace string    ${message}    {brand}    ${brand}
    ${message}    String.Replace string    ${message}    {day_remaining}    ${day_remaining}
    [Return]    ${message}

Verify notification merchandise has reject
    [Arguments]    ${categories}
    ${message}    String.Replace string    ${forecast.lbl_noti_mer_app_reject}    {{categories}}    ${categories}
    SeleniumLibrary.Wait until element is visible    ${message}

Get expected notification reject
    [Arguments]    ${categories}    ${brand}
    ${date}    DateTime.Get current date    time_zone=UTC    result_format=%d-%m-%Y
    ${message_reject}    String.Replace string    ${body_email['merchandise_rejected']}    {current_date}    ${date}
    ${message_reject}    String.Replace string    ${message_reject}    {categories}    ${categories}
    ${message_reject}    String.Replace string    ${message_reject}    {brand}    ${brand}
    [Return]    ${message_reject}

Verify notification superuser has reject
    [Arguments]    ${categories}
    ${message}    String.Replace string    ${forecast.lbl_noti_super_app_reject}    {{categories}}    ${categories}
    SeleniumLibrary.Wait until element is visible    ${message}

Get expected notification super user rejected
    [Arguments]    ${categories}    ${brand}
    ${date}    DateTime.Get current date    time_zone=UTC    result_format=%d-%m-%Y
    ${message_reject}    String.Replace string    ${body_email['superuser_rejected']}    {current_date}    ${date}
    ${message_reject}    String.Replace string    ${message_reject}    {categories}    ${categories}
    ${message_reject}    String.Replace string    ${message_reject}    {brand}    ${brand}
    [Return]    ${message_reject}
