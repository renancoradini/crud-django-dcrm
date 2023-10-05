import mysql.connector

dataBase = mysql.connector.connect(
host = 'localhost',
user = 'admin', 
passwd = 'admin123456'
)

#prepare a cursos object
cursorObject = dataBase.cursor()

#Create a database
cursorObject.execute ("CREATE DATABASE datadenzel")

print ("All Done!")