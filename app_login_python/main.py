import time
import os.path
from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.options import Options

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
browser.find_element(By.NAME,"password").send_keys(userpass)
time.sleep(2)
browser.find_element(By.NAME,"submit").click

time.sleep(5300)
driver.quit()
