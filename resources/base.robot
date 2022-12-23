*** Settings ***
Documentation    Podstawowe zmienne i keywordy

library    AppiumLibrary

*** Variables ***
${REMOTE_URL}    http://localhost:4723/wd/hub
${PLATFORM_NAME}      Android
${PLATFORM_VERSION}   9
${DEVICE_NAME}    10.0.2.5:5555
${AUTOMATION_NAME}    Appium
${BROWSER_NAME}    Chrome
${CHROMEDRIVER_EXECUTABLE}    /home/tester/PycharmProjects/Appium_zajecia/chromedriver

${URL}    https://www.demoblaze.com/
${BROWSER}    Chrome
${PRODUKT}    //img[@class="card-img-top img-fluid"]    # w testach 002 i 003 wyrzuca blad: ?
                                            #ValueError: Element locator with prefix '(//img[@class' is not supported

*** Keywords ***
Uruchom Przegladarke
  Open Application    ${REMOTE_URL}
  ...    platformName=${PLATFORM_NAME}
  ...    platformVersion=${PLATFORM_VERSION}
  ...    deviceName=${DEVICE_NAME}
  ...    automationName=${AUTOMATION_NAME}
  ...    browserName=${BROWSER_NAME}
  ...    chromedriverExecutable=${CHROMEDRIVER_EXECUTABLE}
  Go To Url    ${URL}

Otworz Strone Demoblaze
    Uruchom Przegladarke
    Sleep  5

Zamknij Strone Demoblaze
    Close Application

