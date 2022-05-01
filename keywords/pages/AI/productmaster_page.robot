*** Variables ***
${productmaster.lbl}                        xpath=//label[@aria-label="productMaster"]
${productmaster.lbl_title}                  xpath=//div[text()="Product Master"]  
${productmaster.new_product}                xpath=//td[text()="article_number"]//following-sibling::td[text()="new_product_replace"]
${productmaster.txt_notification}           xpath=//p[text()="Sorry, your import file for import product replacement event with {transaction_id} could not be completed. This file is invalid, Please try again."]
${productmaster.txt_notification_success}   xpath=//p[text()="Your import file for import product replacement event with {transaction_id} is has been imported."]
${productmaster.terminate_dropdown}         xpath=//div[@class="flex justify-between items-center pt-6 pb-1"]

*** keywords ***
Click menu product master
    SeleniumLibrary.Wait until element is visible       ${productmaster.lbl}   
    DobbyWebCommon.Click element when ready             ${productmaster.lbl}

Verify system landing to product master page properly
    SeleniumLibrary.Wait until element is visible       ${productmaster.lbl_title}  

New product replacement is active
    [Arguments]  ${article_number}  ${new_product_replace}  
    ${article_number_rep}    String.Replace string   ${productmaster.new_product}    article_number      ${article_number}
    ${new_product_rep}       String.Replace string   ${article_number_rep}           new_product_replace      ${new_product_replace}   
    SeleniumLibrary.Wait until element is visible    ${new_product_rep}

Page should not be display article number
    [Arguments]  ${article_number}  ${no_product_replace}  
    ${article_number_rep}    String.Replace string   ${productmaster.new_product}    article_number      ${article_number}
    ${no_product_rep}       String.Replace string    ${article_number_rep}           new_product_replace      ${no_product_replace}   
    SeleniumLibrary.Wait until element is visible    ${no_product_rep}

Verify productmaster after import file filed notifiction should be warning
    [Arguments]    ${id_transaction}
    ${transec}    String.Replace string    ${productmaster.txt_notification}     {transaction_id}    ${id_transaction}
    SeleniumLibrary.Wait until element is visible    ${transec}
    
Click productmaster notification accroding transaction id
    [Arguments]    ${id_transaction}
    ${transec}    String.Replace string    ${productmaster.txt_notification}      {transaction_id}    ${id_transaction}
    DobbyWebCommon.Click element when ready    ${transec}

Verify import file succeeded
    [Arguments]    ${id_transaction}
    ${transec}    String.Replace string    ${productmaster.txt_notification_success}    {transaction_id}    ${id_transaction}
    SeleniumLibrary.Wait until element is visible    ${transec}
    
Click productmaster notification succeeded accroding transaction id
    [Arguments]    ${id_transaction}
    ${transec}    String.Replace string    ${productmaster.txt_notification_success}      {transaction_id}    ${id_transaction}
    DobbyWebCommon.Click element when ready     ${transec}

Select productmaster franchise store name
    [Arguments]    ${franchises_name}
    ${name}    String.Replace string            ${common.franchises_name}    franchises_name    ${franchises_name}
    DobbyWebCommon.Click element when ready     ${name}
    SeleniumLibrary.Double click element        ${productmaster.terminate_dropdown} 

Get product master notification message from email
    [Arguments]    ${username}    ${password}    ${foloder}    ${noti_id}    ${sender}=${account['sender_email']['acc_01']}
    ImapLibrary2.Open Mailbox    host=imap.gmail.com    user=${username}    password=${password}
    ${mailbox}    ImapLibrary2.Wait for email    sender=${sender}    recipient=${username}   folder=${foloder}  status=unseen   text=${noti_id}
    ${mailbox}    ImapLibrary2.Get email body    ${mailbox}
    ${mailbox}    String.Replace string    ${mailbox}    \r\n    ${EMPTY}
    ${mailbox}    String.Replace string    ${mailbox}    "    ${EMPTY}
    ${mailbox}    String.Get regexp matches    ${mailbox}    (You'?.*Version.*?.)
    ${mailbox}    String.Get regexp matches    ${mailbox}[0]    (Import?.*imported.*?.)
    ${mailbox}    BuiltIn.Set variable    ${mailbox}[0]
    ${mailbox}    String.Replace string using regexp    ${mailbox}    ID     ID${SPACE}
    [Return]      ${mailbox}
    
