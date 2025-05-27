import pyodbc

conn = pyodbc.connect(
    "Driver={ODBC Driver 17 for SQL Server};"
    "Server=DESKTOP-SP4K7S3;"
    "database=sqlDB;"
    "Trusted_Connection=yes;" 
)

print("connected to database succesfully")
cursor= conn.cursor()


# creating table

# create_table_sql="""
#  CREATE TABLE students(
#      ID INT PRIMARY KEY IDENTITY(1,1),
#      Name VARCHAR(100),
#      Age INT,
#      Grade VARCHAR(10)
#  )
# """

# try:
#     cursor.execute(create_table_sql)
#     conn.commit()
#     print("Table 'students' created successfully.")
# except Exception as e:
#     print("Error creating table:", e)
# finally:
#     cursor.close()
#     conn.close()
    
# inserting data 

# insert_data_sql="""
# INSERT INTO students (Name,Age ,Grade) VALUES(?,?,?)

# """

# # student_data=("Lawrence Osuru",24,"A")
# student_data=[
#  ("Alice Johnson", 22, "B"),
#     ("Brian Smith", 30, "A"),
#     ("Carla Gomez", 28, "C"),
#     ("David Lee", 35, "B"),
#     ("Eva Martinez", 26, "A"),
#     ("Frank Chen", 24, "B")
# ]

# try:
#     # cursor.execute(insert_data_sql,student_data) one data
#     cursor.executemany(insert_data_sql,student_data)
#     conn.commit()
#     print("Data Inserte successfully")
# except Exception as e:
#     print("something happened ", e)
# finally:
#     cursor.close()
#     conn.close()
    

# read data

# read_data_sql="""
# SELECT * FROM students
# """

# try:
#     cursor.execute(read_data_sql)
#     row=cursor.fetchall()
    
#     for row in row :
#         # print(row)
#         print(f"ID: {row.ID}, Name: {row.Name}, Age: {row.Age}, Grade: {row.Grade}")
# except Exception as e:
#     print(e)
# finally:
#     cursor.close()
#     conn.close()
    
    
    
cursor.execute("{CALL GetStudentByGrade (?)}", ("A",))
rows = cursor.fetchall()
for row in rows:
    print(row)