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

*** Keywords ***
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
    Sleep    5
    Alert Should Be Present    Please fill out Username and Password.
    Sleep    4


