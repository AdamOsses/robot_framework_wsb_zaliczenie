## WSB Tester Oprogramowania
## Automatyzacja przypadków testowych przy pomocy Robot Framework #  

Testowana strona internetowa: https://www.demoblaze.com/  
Przeglądarka: Firefox
---  
## Środowisko: ##  

---  
### 1. Virtualenv: ###
```commandline
$ python3 -m venv .venv
$ source .venv/bin/activate
$ pip install -r requirements.txt
```
### 2. Sterownik Geckodriver: <https://github.com/mozilla/geckodriver/releases/download/v0.31.0/geckodriver-v0.31.0-linux64.tar.gz> ###  
```net  
wget -N https://github.com/mozilla/geckodriver/releases/download/v0.31.0/geckodriver-v0.31.0-linux64.tar.gz -P ~/
tar -xvf ~/geckodriver-v0.31.0-linux64.tar.gz
rm ~/geckodriver-v0.31.0-linux64.tar.gz.asc
sudo mv -f ~/geckodriver /usr/local/bin
chmod +x geckodriver*
```  
