*** Settings ***
Documentation    Zmienne i keywordy obslugujace koszyk

library    SeleniumLibrary

*** Variables ***
${ADD_TO_A_CART_BTN}    //*[@class="btn btn-success btn-lg"]
${CART}    //*[@id="cartur"]
${PRICE}    //*[@class="success"]//td[3]
${TOTAL}    //*[@id="totalp"]
${DELETE}    //a[contains(text(), "Delete")]
${LICZBA_ZAMOWIONYCH_PRODUKTOW}    ${0}


*** Keywords ***
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
    ${nr}=    Convert To Integer    ${liczba_wyswietlonych_produktow}
    ${LICZBA_ZAMOWIONYCH_PRODUKTOW}=    Evaluate    random.randint(2, 9)    random
    Set Global Variable    ${LICZBA_ZAMOWIONYCH_PRODUKTOW}
    FOR    ${i}    IN RANGE    ${LICZBA_ZAMOWIONYCH_PRODUKTOW}
        ${wylosowany_produkt}=    Evaluate    random.randint(1, ${nr})    random
        Zamow Produkt    (${PRODUKT})[${wylosowany_produkt}]
    END

Podlicz Kwote Do Zaplaty
    Click Link    ${CART}
    Wait Until Page Contains Element    (${PRICE})[${LICZBA_ZAMOWIONYCH_PRODUKTOW}]    # Ostatni produkt na liscie
    @{ceny}=    Get Webelements    ${PRICE}
    ${kwota_do_zaplaty}=   Set Variable    ${0}
    FOR    ${cena_produktu}    IN    @{ceny}
        ${cena}=    Get Text    ${cena_produktu}
        ${kwota_do_zaplaty}=   Evaluate    ${kwota_do_zaplaty} + ${cena}
    END
    RETURN    ${kwota_do_zaplaty}

Usun Z Koszyka Zamowione Produkty
    Click Link    ${CART}
    IF    ${LICZBA_ZAMOWIONYCH_PRODUKTOW} < 1
        Should Be True    False    W koszyku brak produktow!
    END
    FOR    ${i}    IN RANGE   ${LICZBA_ZAMOWIONYCH_PRODUKTOW}
      Wait Until Page Does Not Contain Element    ${DELETE}
      Wait Until Page Contains Element    ${DELETE}    error=W koszyku powinien byc jeszcze co najmniej jeden produkt.
      Click Link    ${DELETE}
    END

Koszyk Powinien Byc Pusty
    Wait Until Page Does Not Contain Element    ${DELETE}
    Run Keyword And Ignore Error    Wait Until Page Contains Element    ${DELETE}
    Page Should Not Contain Element    ${DELETE}    Koszyk powinien byc pusty.

Kwota TOTAL I Suma Kwot Z Kolumny Price Powinny Byc Rowne
    ${suma_kwot_z_kol_price}=    Podlicz Kwote Do Zaplaty
    ${kwota_total}=    Get Text    ${TOTAL}
    Should Be Equal As Integers   ${suma_kwot_z_kol_price}    ${kwota_total}    Kwota "TOTAL" rozni sie od calkowitej ceny zamawionych produktow.
