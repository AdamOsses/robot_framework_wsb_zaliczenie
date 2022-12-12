*** Settings ***
library    SeleniumLibrary
library    String

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
${CART}    //*[@id="cartur"]
${PRICE}    //*[@class="success"]//td[3]
${TOTAL}    //*[@id="totalp"]
${DELETE}    //a[contains(text(), "Delete")]


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
    Sleep    4
    Log to console    Otwieram strone demoblaze

Zamknij Strone Demoblaze
    Close All Browsers
    Log to console    Zamykam okno

Zamow Produkt
    [Arguments]    ${produkt}
    Wait Until Page Contains Element    ${produkt}
    Click Link    ${produkt}
    Wait Until Page Contains Element    ${ADD_TO_A_CART_BTN}
    Click Link    ${ADD_TO_A_CART_BTN}
    Handle Alert
    Go To    ${URL}

Zamow Kilka Produktow
    ${liczba_wyswietlonych_produktow}=    Get Element Count    //a[@class="hrefch"]
    ${nr}=    Convert To Number    ${liczba_wyswietlonych_produktow}
    ${ile_produktow_zamowic}=    Evaluate    random.randint(2,9)    random

    FOR    ${i}    IN RANGE    ${ile_produktow_zamowic}
        ${wylosowany_produkt}=    Evaluate    random.randint(1, ${nr})    random
        Zamow Produkt    (//a[@class="hrefch"])[${wylosowany_produkt}]
    END
    RETURN    ${ile_produktow_zamowic}

Podlicz Kwote Do Zaplaty
    Click Link    ${CART}
    Wait Until Page Contains Element    ${PRICE}
    @{ceny}=    Get Webelements    ${PRICE}
    ${kwota_do_zaplaty}=   Set Variable    ${0}
    FOR    ${cena_produktu}    IN    @{ceny}
        ${cena}=    Get Text    ${cena_produktu}
        Log to console    Cena produktu: ${cena}
        ${kwota_do_zaplaty}=   Evaluate    ${kwota_do_zaplaty} + ${cena}
    END
    Log to console    SUMA: ${kwota_do_zaplaty}
    RETURN    ${kwota_do_zaplaty}


*** Test Cases ***
ID 001 Logowanie Bez Wprowadzenia Hasla
    Kliknij Log in
    Wprowadz Nazwe Uzytkownika
    Kliknij Log in W Oknie Logowania
    Sleep    2
    Alert Should Be Present    Please fill out Username and Password.
    Sleep    2

ID 002 Poprawnosc Kwoty Do Zaplaty
    Zamow Kilka Produktow
    ${do_zaplaty}=    Podlicz Kwote Do Zaplaty
    ${kwota_total}=    Get Text    //*[@id="totalp"]
    Log to console    DO ZAPLATY: ${do_zaplaty} i TOTAL: ${kwota_total}
    Should Be Equal As Integers   ${do_zaplaty}    ${kwota_total}    Kwota "TOTAL" rozni sie od calkowitej ceny zamawionych produktow.

ID 003 Usuwanie Wszystkich Produktow Z Koszyka
    ${liczba_zamowionych_produktow}=    Zamow Kilka Produktow
    Log To Console    Produkty do usuniecia: ${liczba_zamowionych_produktow}
    Click Link    ${CART}
    FOR    ${i}    IN RANGE   ${liczba_zamowionych_produktow}+3
      Wait Until Page Does Not Contain Element    ${DELETE}
      Wait Until Page Contains Element    ${DELETE}    error=W koszyku powinien byc jeszcze co najmniej jeden produkt.
      Click Link    ${DELETE}
      Log To Console    Klikam DELETE ${i}
    END

    Wait Until Page Does Not Contain Element    ${DELETE}
    Run Keyword And Ignore Error    Wait Until Page Contains Element    ${DELETE}
    Page Should Not Contain Element    ${DELETE}    Koszyk powinien byc pusty.

