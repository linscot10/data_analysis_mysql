import mysql.connector

mydb=mysql.connector.connect(
    host= "localhost",
    user="root",
    password="lawrence254#####",
    database="learn"
)

mycursor= mydb.cursor()
# CREATE TABBLES
# mycursor.execute("create table customers(name VARCHAR(255),address VARCHAR(255))")


# mycursor.execute("SHOW TABLES")

# for x in mycursor:
#     print(x)

# mycursor.execute("ALTER TABLE customers ADD column id int auto_increment primary key")

# sql="INSERT INTO customers( name,address) values(%s,%s)"
# # insert one record
# val=("Scott","Haileselassie avenue") 
# val=[
#     ("peter",'Moi Avenue'),
#     ('Amy', 'Apple st 652'),
#   ('Hannah', 'Mountain 21'),
#   ('Michael', 'Valley 345'),
#   ('Sandy', 'Ocean blvd 2'),
#   ('Betty', 'Green Grass 1'),
#   ('Richard', 'Sky st 331'),
#   ('Susan', 'One way 98'),
#   ('Vicky', 'Yellow Garden 2'),
#   ('Ben', 'Park Lane 38'),
#   ('William', 'Central st 954'),
#   ('Chuck', 'Main Road 989'),
#   ('Viola', 'Sideway 1633')
# ]

# mycursor.execute(sql,val)
# # mycursor.executemany(sql,val)

# mydb.commit()

# print(mycursor.rowcount,"record inserted")
# print("1 record inserted ",mycursor.lastrowid)

# mycursor.execute("SELECT * FROM customers")
# mycursor.execute("SELECT name,address FROM customers")
# # myResult=mycursor.fetchall()    

# # for x in myResult :
# #     print(x)


# myresult = mycursor.fetchone()
# print(myresult)


sql="SELECT * FROM customers where address = 'Park Lane 38'"
mycursor.execute(sql)
myresult = mycursor.fetchall()

for x in myresult:
    print(x)
    
    
    