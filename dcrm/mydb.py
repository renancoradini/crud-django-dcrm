import mysql.connector
from pathlib import Path
import os


dataBase = mysql.connector.connect(
host = os.getenv('DATABASE_HOST'),
user = os.getenv('DATABASE_USER'), 
passwd = os.getenv('DATABASE_PASS')
)

#prepare a cursos object
cursorObject = dataBase.cursor()

#Create a database
cursorObject.execute ("CREATE DATABASE datadenzel")

print ("All Done!")