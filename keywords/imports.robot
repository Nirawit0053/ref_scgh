*** Settings ***
Library    OperatingSystem
Library    String
Library    DebugLibrary
Library    SeleniumLibrary    
Library    pabot.PabotLib
Library    ExcelLibrary
Library    CSVLibrary
Library    Collections
Library    DateTime
Library    JSONLibrary
Library    REST
Library    RequestsLibrary
Library    ${CURDIR}/../resources/library/custom_script/extract_file.py
Library    ${CURDIR}/../resources/library/custom_script/date_time.py

Variables     ${CURDIR}/../resources/testdata/test_data.yaml
Variables     ${CURDIR}/../resources/setting.yaml

#Dobby common
Resource      ${CURDIR}/../keywords/common.robot
Resource       DobbyCommonLibrary/DobbyCommon.robot
Resource       DobbyCommonLibrary/DobbyWebCommon.robot

#PAGE
Resource      ${CURDIR}/../keywords/pages/login_page.robot
Resource      ${CURDIR}/../keywords/pages/main_page.robot
Resource      ${CURDIR}/../keywords/pages/AI/AI_page.robot
Resource      ${CURDIR}/../keywords/pages/AI/forecast_page.robot
Resource      ${CURDIR}/../keywords/pages/AI/settarget_page.robot
Resource      ${CURDIR}/../keywords/pages/AI/product_recom_page.robot
Resource      ${CURDIR}/../keywords/pages/AI/productmaster_page.robot
Resource      ${CURDIR}/../keywords/pages/AI/min_max_level.robot
Resource      ${CURDIR}/../keywords/pages/configuration/dcrc_page.robot

#FEATURE
Resource      ${CURDIR}/../keywords/features/login_feature.robot
Resource      ${CURDIR}/../keywords/features/main_feature.robot
Resource      ${CURDIR}/../keywords/features/common_feature.robot
Resource      ${CURDIR}/../keywords/features/AI/forecast_feature.robot
Resource      ${CURDIR}/../keywords/features/AI/AI_feature.robot
Resource      ${CURDIR}/../keywords/features/AI/settarget_feature.robot
Resource      ${CURDIR}/../keywords/features/AI/productmaster_feature.robot
Resource      ${CURDIR}/../keywords/features/AI/productrecom_feature.robot

#JSON DATA
Resource      ${CURDIR}/../resources/testdata/json_file/jsondata.robot
