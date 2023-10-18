## Run selenium and chrome driver to scrape data from cloudbytes.dev
import time
import os.path
from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.options import Options

## Setup chrome options
chrome_options = Options()
chrome_options.add_argument("--headless") # Ensure GUI is off
chrome_options.add_argument("--no-sandbox")

# Set path to chromedriver as per your configuration
homedir = os.path.expanduser("~")
webdriver_service = Service("./driver/chromedriver")



# Choose Chrome Browser
browser = webdriver.Chrome(service=webdriver_service, options=chrome_options)

usermail = "renanps@gmail.com"
userpass = "Xul1p4!!"

# Get page

# head to github login page
browser.get('https://www.facebook.com/')

time.sleep(10)
browser.find_element(By.NAME,"email").send_keys(usermail)
time.sleep(2)
browser.find_element(By.NAME,"pass").send_keys(userpass)
time.sleep(2)
browser.find_element(By.NAME,"login").click

# browser.find_element(By.ID,"1-password").send_keys("abCD1234")
# browser.find_element(By.ID,"1-submit").click()



# # find username/email field and send the username itself to the input field
# browser.find_element("id", "login_field").send_keys(username)
# # find password input field and insert password as well
# browser.find_element("id", "password").send_keys(password)
# # click login button
# browser.find_element("name", "commit").click()

# browser.find_element

# alt-image-w-arrow

# # Extract description from page and print
# description = browser.find_element(By.NAME, "description").get_attribute("content")
# print(description)

#Wait for 10 seconds
time.sleep(10)
browser.quit()