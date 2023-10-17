import time
import os.path
from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.options import Options
import mypass  # criar mypass.py e atribuir as duas variaveis username="test" e userpass="test"

service = Service()
options = webdriver.ChromeOptions()
driver = webdriver.Chrome(service=service, options=options)


driver.get("https://learn.acloud.guru/")
# ...
time.sleep(5)

# driver.find_element(By.NAME, "auth0-lock-social-button-text").click
driver.find_element(By.NAME, "email").send_keys(mypass.username)
time.sleep(1)
driver.find_element(By.NAME, "password").send_keys(mypass.userpass)
time.sleep(2)
driver.find_element(By.CLASS_NAME, "auth0-lock-social-button-text").click()

time.sleep(5300)
driver.quit()
