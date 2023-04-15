# crud operation and test all

# api create

# app

import mysql.connector

def close_connection(mydb):
    mydb.close()
    print("Connection closed")


def create_connection():
    try:
        # create a connection to the database
        mydb = mysql.connector.connect(
            host="127.0.0.1",
            port='3306',
            user="root",
            password="Hello12345",
            database = "ehrms"
        )  
        
        return mydb
    except mysql.connector.Error as error:
            print("Error: {}".format(error))
