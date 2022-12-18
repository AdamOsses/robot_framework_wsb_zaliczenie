*** Settings ***
Documentation    WSB - Tester Oprogramowania
...              Praca zaliczeniowa z Robot Framework
...              Testy przy uzyciu "Test Template"

resource    base.resource
resource    logowanie.resource

Test Setup    Otworz Strone Demoblaze
Test Teardown    Zamknij Strone Demoblaze

Test Template    Zaloguj sie


*** Variables ***
*** Keywords ***
*** Test Cases ***                          USERNAME                            PASSWORD
Poprawny Uzytkownik Brak Hasla              ${POPRAWNA_NAZWA_UZYTKOWNIKA}       ${EMPTY}
Poprawny Uzytkownik Niepoprawne Haslo       ${POPRAWNA_NAZWA_UZYTKOWNIKA}       ${NIEPOPRAWNE_HASLO}
Niepoprawny Uzytkownik Brak Hasla           ${NIEPOPRAWNA_NAZWA_UZYTKOWNIKA}    ${EMPTY}
Niepoprawny Uzytkownik Niepoprawne Haslo    ${NIEPOPRAWNA_NAZWA_UZYTKOWNIKA}    ${NIEPOPRAWNE_HASLO}
Niepoprawny Uzytkownik Poprawne Haslo       ${NIEPOPRAWNA_NAZWA_UZYTKOWNIKA}    ${POPRAWNE_HASLO}
Brak Uzytkownika Brak Hasla                 ${EMPTY}                            ${EMPTY}
Brak Uzytkownika Niepoprawne Haslo          ${EMPTY}                            ${NIEPOPRAWNE_HASLO}
Brak Uzytkownika Poprawne Haslo             ${EMPTY}                            ${POPRAWNE_HASLO}
