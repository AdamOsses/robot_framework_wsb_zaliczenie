*** Settings ***
resource    logowanie.resource

Test Setup    Otworz Strone Demoblaze
Test Teardown    Zamknij Strone Demoblaze

*** Variables ***

*** Keywords ***

*** Test Cases ***
Test 1
    Zalogoj Sie    koza    z_nosa

Test 2
    Zalogoj Sie    ${EMPTY}    nieempty
