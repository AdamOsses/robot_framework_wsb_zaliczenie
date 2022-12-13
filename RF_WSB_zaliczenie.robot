*** Settings ***
Documentation    WSB - Tester Oprogramowania
...              Praca zaliczeniowa z Robot Framework
...              Skrypt automatyzujcy przypadki testowe
...              Testowana strona: https://www.demoblaze.com

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

${PRODUKT}    //a[@class="hrefch"]
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
    Wait Until Page Contains Element    ${PRODUKT}

Zamknij Strone Demoblaze
    Close All Browsers

Zamow Produkt
    [Arguments]    ${produkt}
    Wait Until Page Contains Element    ${produkt}
    Click Link    ${produkt}
    Wait Until Page Contains Element    ${ADD_TO_A_CART_BTN}
    Click Link    ${ADD_TO_A_CART_BTN}
    Handle Alert
    Go To    ${URL}

Zamow Kilka Produktow
    ${liczba_wyswietlonych_produktow}=    Get Element Count    ${PRODUKT}
    ${nr}=    Convert To Number    ${liczba_wyswietlonych_produktow}
    ${ile_produktow_zamowic}=    Evaluate    random.randint(2,9)    random

    FOR    ${i}    IN RANGE    ${ile_produktow_zamowic}
        ${wylosowany_produkt}=    Evaluate    random.randint(1, ${nr})    random
        Zamow Produkt    (${PRODUKT})[${wylosowany_produkt}]
    END
    RETURN    ${ile_produktow_zamowic}

Podlicz Kwote Do Zaplaty
    Click Link    ${CART}
    Wait Until Page Contains Element    ${PRICE}
    @{ceny}=    Get Webelements    ${PRICE}
    ${kwota_do_zaplaty}=   Set Variable    ${0}
    FOR    ${cena_produktu}    IN    @{ceny}
        ${cena}=    Get Text    ${cena_produktu}
        ${kwota_do_zaplaty}=   Evaluate    ${kwota_do_zaplaty} + ${cena}
    END
    RETURN    ${kwota_do_zaplaty}

Usun Z Koszyka Zamowione Produkty
    [Arguments]    ${liczba_produktow}
    FOR    ${i}    IN RANGE   ${liczba_produktow}
      Wait Until Page Does Not Contain Element    ${DELETE}
      Wait Until Page Contains Element    ${DELETE}    error=W koszyku powinien byc jeszcze co najmniej jeden produkt.
      Click Link    ${DELETE}
    END

*** Test Cases ***
ID 001 Logowanie Bez Wprowadzenia Hasla
    Kliknij Log in
    Wprowadz Nazwe Uzytkownika
    Kliknij Log in W Oknie Logowania
    Alert Should Be Present    Please fill out Username and Password.


ID 002 Poprawnosc Kwoty Do Zaplaty
    Zamow Kilka Produktow
    ${do_zaplaty}=    Podlicz Kwote Do Zaplaty
    ${kwota_total}=    Get Text    ${TOTAL}
    Should Be Equal As Integers   ${do_zaplaty}    ${kwota_total}    Kwota "TOTAL" rozni sie od calkowitej ceny zamawionych produktow.


ID 003 Usuwanie Wszystkich Produktow Z Koszyka
    ${liczba_zamowionych_produktow}=    Zamow Kilka Produktow
    Click Link    ${CART}
    Usun Z Koszyka Zamowione Produkty    ${liczba_zamowionych_produktow}
    Wait Until Page Does Not Contain Element    ${DELETE}
    Run Keyword And Ignore Error    Wait Until Page Contains Element    ${DELETE}
    Page Should Not Contain Element    ${DELETE}    Koszyk powinien byc pusty.

