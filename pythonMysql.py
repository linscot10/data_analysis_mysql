import mysql.connector

mydb= mysql.connector.connect(
    host = "localhost",
    user="root",
    password='lawrence254#####'
)
mycursor= mydb.cursor()

# CREATING DATABASE USING PYTHON
# mycursor.execute(" CREATE DATABASE learn")

# LIST OF SYSTEM DATABASES 
# mycursor.execute("SHOW DATABASES")
# for x in mycursor:
#     print(x)
# print(mydb)


# CREATE TABLES

mycursor.execute("create table customers(name VARCHAR(255),address VARCHAR(255))")

