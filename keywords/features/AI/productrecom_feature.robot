*** keywords ***
Select class level name
    [Arguments]    ${level}
    ${name}    String.Replace string            ${productrecom.lbl_level_name}    level_name    ${level}   
    DobbyWebCommon.Click element when ready     ${name}
    SeleniumLibrary.Double click element        ${common.terminate_dropdown}