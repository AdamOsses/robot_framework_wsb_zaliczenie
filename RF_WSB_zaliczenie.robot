*** Settings ***
library    SeleniumLibrary
Test Setup    Otworz Strone Demoblaze
Test Teardown    Zamknij Strone Demoblaze

*** Variables ***
${BROWSER}    firefox
${URL}    https://www.demoblaze.com/


*** Keywords ***
Otworz Strone Demoblaze
    Open browser    about:blank    ${BROWSER}
    Maximize Browser Window
    Go To    ${URL}
    Log to console    Otwieram strone demoblaze

Zamknij Strone Demoblaze
    Close All Browsers
    Log to console    Zamykam okno


*** Test Cases ***
Pierwszy Test
    Sleep    2

Drugi Test
    Sleep    2
