*** Settings ***
Documentation    Podstawowe zmienne i keywordy

library    SeleniumLibrary

*** Variables ***
${BROWSER}    firefox
${URL}    https://www.demoblaze.com/
${PRODUKT}    //a[@class="hrefch"]


*** Keywords ***
Otworz Strone Demoblaze
    Open browser    about:blank    ${BROWSER}
    Maximize Browser Window
    Go To    ${URL}
    Wait Until Page Contains Element    ${PRODUKT}

Zamknij Strone Demoblaze
    Close All Browsers

