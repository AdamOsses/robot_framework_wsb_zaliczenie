*** Settings ***
Documentation    Zmienne i keywordy obslugujace logowanie uzytkownika

library    AppiumLibrary

*** Variables ***
${LOG_IN_INDEX}    //*[@id="login2"]
${POLE_USERNAME}    //*[@id="loginusername"]
${POLE_HASLO}    //*[@id="loginpassword"]
${LOG_IN_OKNO_LOGOWANIA}    //button[contains(text(),'Log in')]
${WELCOME_USER}    //*[@id="nameofuser"]

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
    #Alert Should Be Present        <- brak KW w Appium


Kliknij Log in
    AppiumLibrary.Click Element    ${LOG_IN_INDEX}
    Sleep    2

Wprowadz Nazwe Uzytkownika
    [Arguments]    ${nazwa_uzytkownika}
    Input Text    ${POLE_USERNAME}    ${nazwa_uzytkownika}
    #Log To Console    Input username - OK
    Sleep    2

Wprowadz Haslo
    [Arguments]    ${haslo}
    Input Password    ${POLE_HASLO}    ${haslo}
    Sleep    2

Kliknij Log in W Oknie Logowania
    Click Element    ${LOG_IN_OKNO_LOGOWANIA}
    #Log To Console    Klik Log In - OK
    Sleep    2

