*** Settings ***
Documentation    Zmienne i keywordy obslugujace logowanie uzytkownika

library    SeleniumLibrary

*** Variables ***
${LOG_IN_INDEX}    //*[@id="login2"]
${POLE_USERNAME}    //*[@id="loginusername"]
${POLE_HASLO}    //*[@id="loginpassword"]
${LOG_IN_OKNO_LOGOWANIA}    //button[contains(text(),'Log in')]

${POPRAWNA_NAZWA_UZYTKOWNIKA}    WSB_tester
${POPRAWNE_HASLO}    WSB_tester
${NIEPOPRAWNA_NAZWA_UZYTKOWNIKA}    niepoprawny_uzytkownik
${NIEPOPRAWNE_HASLO}    niepoprawne_haslo


*** Keywords ***
Zaloguj Sie
    [Arguments]    ${login}    ${haslo}
    Kliknij Log in
    Wprowadz Nazwe Uzytkownika    ${login}
    Wprowadz Haslo    ${haslo}
    Kliknij Log in W Oknie Logowania
    Alert Should Be Present


Kliknij Log in
    Click Element    ${LOG_IN_INDEX}

Wprowadz Nazwe Uzytkownika
    [Arguments]    ${nazwa_uzytkownika}
    Input Text    ${POLE_USERNAME}    ${nazwa_uzytkownika}

Wprowadz Haslo
    [Arguments]    ${haslo}
    Input Text    ${POLE_HASLO}    ${haslo}

Kliknij Log in W Oknie Logowania
    Click Button    ${LOG_IN_OKNO_LOGOWANIA}

