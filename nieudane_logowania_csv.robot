*** Settings ***
Documentation    WSB - Tester Oprogramowania
...              Praca zaliczeniowa z Robot Framework
...              Testy przy uzyciu "Test Template" i danych zapisanych w pliku csv
...              Wykorzystana biblioteka: DataDriver (robotframework-datadriver)
Metadata     Autor: Adam Osses <adam.osses.ao@gmail.com>
...         Wersja: 1.0

library    DataDriver    file=resources/hasla.csv

resource    resources/base.robot
resource    resources/logowanie.robot

Test Setup       Otworz Strone Demoblaze
Test Teardown    Zamknij Strone Demoblaze

Test Template    Niepoprawne Haslo

*** Variables ***

*** Keywords ***
Niepoprawne Haslo
    [Arguments]    ${haslo}
    Kliknij Log in
    Wprowadz Nazwe Uzytkownika    ${POPRAWNA_NAZWA_UZYTKOWNIKA}
    Wprowadz Haslo    ${haslo}
    Kliknij Log in W Oknie Logowania
    Alert Should Be Present


*** Test Cases ***
Proba Logowania Uzytkownik: WSB_tester Haslo: -->${haslo}<--