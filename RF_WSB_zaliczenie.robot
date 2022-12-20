*** Settings ***
Documentation    WSB - Tester Oprogramowania
...              Praca zaliczeniowa z Robot Framework
...              Skrypt automatyzujacy przypadki testowe
...              Testowana strona: https://www.demoblaze.com
Metadata     Autor: Adam Osses
...         Wersja: 1.0

library    SeleniumLibrary

resource    resources/base.robot
resource    resources/logowanie.robot
resource    resources/koszyk.robot

Test Setup    Otworz Strone Demoblaze
Test Teardown    Zamknij Strone Demoblaze


*** Test Cases ***
ID 001 Logowanie Bez Wprowadzenia Hasla
    Kliknij Log in
    Wprowadz Nazwe Uzytkownika    WSB_tester
    Kliknij Log in W Oknie Logowania
    Alert Should Be Present    Please fill out Username and Password.

ID 002 Poprawnosc Kwoty Do Zaplaty
    Zamow Kilka Produktow
    Przejdz Do Koszyka
    Kwota TOTAL I Suma Kwot Z Kolumny Price Powinny Byc Rowne

ID 003 Usuwanie Wszystkich Produktow Z Koszyka
    Zamow Kilka Produktow
    Przejdz Do Koszyka
    Usun Z Koszyka Zamowione Produkty
    Koszyk Powinien Byc Pusty

