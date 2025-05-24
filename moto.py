# import mysql.connector
from mysql.connector import pooling
from dotenv import load_dotenv
import os
import pandas as pd 


load_dotenv()


dbconfig={
    "host" :os.getenv("DB_HOST"),
    "user":os.getenv("DB_USER"),
    "password":os.getenv("DB_PASS"),
    "database":os.getenv("DB_NAME")
}

pool=pooling.MySQLConnectionPool(pool_name='mypool',pool_size=5,**dbconfig)




# crud operation

def create_student(name,age,grade):
    conn=pool.get_connection()
    cursor= conn.cursor(prepared=True)
    query = "INSERT INTO students (name, age, grade) VALUES (%s, %s, %s)"
    cursor.execute(query, (name, age, grade))
    conn.commit()
    print("Student Added")
    cursor.close()
    conn.close()
    
def read_student():
    conn = pool.get_connection()
    cursor =conn.cursor()
    cursor.execute("SELECT * FROM students")
    for row in cursor.fetchall():
        print(row)
    cursor.close()
    conn.close()
    
def update_student(name, age, grade, student_id):
    conn=pool.get_connection()
    cursor=conn.cursor(prepared=True)
    query = "UPDATE students SET name=%s, age=%s, grade=%s WHERE id=%s"
    cursor.execute(query, (name, age, grade, student_id))
    conn.commit()
    print("Student updated.")
    cursor.close()
    conn.close()
    
def delete_student(student_id):
    conn = pool.get_connection()
    cursor = conn.cursor(prepared=True)
    query = "DELETE FROM students WHERE id=%s"
    cursor.execute(query, (student_id,))
    conn.commit()
    print("Student deleted.")
    cursor.close()
    conn.close()

# export and creating excel and csv

def export_to_csv():
    conn=pool.get_connection()
    df=pd.read_sql("SELECT * FROM students",conn)
    df.to_csv("students.csv",index=False)
    print("exported to csv")
    conn.close()
    
def export_to_excel():
    conn=pool.get_connection()
    df = pd.read_sql("SELECT * FROM students",conn)
    df.to_excel("students.xlsx", index=False)
    print("Exported to Excel.")
    conn.close()
