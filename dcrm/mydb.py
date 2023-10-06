import mysql.connector
from pathlib import Path
import environ
env = environ.Env()
environ.Env.read_env()


dataBase = mysql.connector.connect(
host = env('DATABASE_HOST'),
user = env('DATABASE_USER'), 
passwd = env('DATABASE_PASS')
)

#prepare a cursos object
cursorObject = dataBase.cursor()

#Create a database
cursorObject.execute ("CREATE DATABASE datadenzel")

print ("All Done!")