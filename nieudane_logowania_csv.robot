*** Settings ***
Documentation    WSB - Tester Oprogramowania
...              Praca zaliczeniowa z Robot Framework
...              Testy przy uzyciu "Test Template" i danych zapisanych w pliku csv
...              Wykorzystana biblioteka: DataDriver (robotframework-datadriver)

library    SeleniumLibrary
library    DataDriver    file=hasla.csv

resource    base.resource
resource    logowanie.resource

Test Setup    Otworz Strone Demoblaze
Test Teardown    Zamknij Strone Demoblaze

Test Template    Niepoprawne Haslo

*** Variables ***

*** Keywords ***
Niepoprawne Haslo
    [Arguments]    ${haslo}
    Kliknij Log in
    Wprowadz Nazwe Uzytkownika    WSB_tester
    Wprowadz Haslo    ${haslo}
    Kliknij Log in W Oknie Logowania
    Alert Should Be Present

*** Test Cases ***
Proba Logowania Uzytkownik: WSB_tester Haslo: -->${haslo}<--