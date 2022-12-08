*** Settings ***
library    SeleniumLibrary

Test Setup    Otworz Strone Demoblaze
Test Teardown    Zamknij Strone Demoblaze

*** Variables ***
${BROWSER}    firefox
${URL}    https://www.demoblaze.com/
${NAZWA_UZYTKOWNIKA}    WSB_tester

${LOG_IN_INDEX}    //*[@id="login2"]
${USERNAME_OKNO_LOGOWANIA}    //*[@id="loginusername"]
${LOG_IN_OKNO_LOGOWANIA}    //button[contains(text(),'Log in')]

${ADD_TO_A_CART_BTN}    //*[@class="btn btn-success btn-lg"]

*** Keywords ***
Zamow Produkt
    [Arguments]    ${produkt}
    Wait Until Page Contains Element    ${produkt}
    Click Link    ${produkt}
    Wait Until Page Contains Element    ${ADD_TO_A_CART_BTN}
    Click Link    ${ADD_TO_A_CART_BTN}
    Handle Alert
    Go To    ${URL}


Kliknij Log in
    Click Element    ${LOG_IN_INDEX}

Wprowadz Nazwe Uzytkownika
    Input Text    ${USERNAME_OKNO_LOGOWANIA}    ${NAZWA_UZYTKOWNIKA}

Kliknij Log in W Oknie Logowania
    Click Button    ${LOG_IN_OKNO_LOGOWANIA}

Otworz Strone Demoblaze
    Open browser    about:blank    ${BROWSER}
    Maximize Browser Window
    Go To    ${URL}
    Log to console    Otwieram strone demoblaze

Zamknij Strone Demoblaze
    Close All Browsers
    Log to console    Zamykam okno

*** Test Cases ***
ID 001 Logowanie Bez Wprowadzenia Hasla
    Kliknij Log in
    Wprowadz Nazwe Uzytkownika
    Kliknij Log in W Oknie Logowania
    Sleep    2
    Alert Should Be Present    Please fill out Username and Password.
    Sleep    2

ID 002 Poprawnosc Kwoty Do Zaplaty
    Zamow Produkt    //a[@href="prod.html?idp_=1"]
