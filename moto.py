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

def create_table_if_not_exists():
    conn = pool.get_connection()
    cursor = conn.cursor()
    query = """
    CREATE TABLE IF NOT EXISTS students (
        id INT AUTO_INCREMENT PRIMARY KEY,
        name VARCHAR(100),
        age INT,
        grade VARCHAR(10)
    );
    """
    cursor.execute(query)
    conn.commit()
    print("Checked or created 'students' table.")
    cursor.close()
    conn.close()


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



def menu():
    while True:
        print("\n1. Add Student\n2. View All\n3. Update\n4. Delete\n5. Export CSV\n6. Export Excel\n0. Exit")
        choice=input("choose : ")
        if choice=="1":
            create_student(input("Name:"),input("Age:"),input("Grade:"))   
        elif choice=="2":
            read_student() 
        elif choice =="3":
            update_student(input("Name:"),input("Age:"),input("Grade:"),input("Student_id:"))
        elif choice =="4":
           delete_student(input("Student_id:"))
        elif choice =="5":
           export_to_csv()
        elif choice =="6":
           export_to_excel()
           
menu()