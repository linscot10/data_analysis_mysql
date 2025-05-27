import pyodbc
# print(pyodbc.drivers())
conn = pyodbc.connect(
    "Driver={ODBC Driver 17 for SQL Server};"
    "Server=DESKTOP-SP4K7S3;"
    "Trusted_Connection=yes;" ,
    autocommit=True 
)

# print("Connected to SQL Server")
cursor = conn.cursor()

db_name="sqlDB";
create_db_sql=f"CREATE DATABASE {db_name}";

try: 
    cursor.execute(create_db_sql)
    conn.commit()
    print(f"database '{db_name}' created successfully")
except Exception as e:
    print("Error Creating database",e)
finally:
    cursor.close()
    conn.close()

