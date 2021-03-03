import psycopg2

def sendQuery(query,user="onenetwork",password="admin",host="localhost",port="5432",database="ondb"):
    connection=0
    try:
        connection = psycopg2.connect(user=user,
                                      password=password,
                                      host=host,
                                      port=port,
                                      database=database)

        cursor = connection.cursor()

        create_table_query = query

        cursor.execute(create_table_query)
        connection.commit()
        try:
            res=cursor.fetchall()
            return res
        except:
            return 0

    except (Exception,  psycopg2.DatabaseError) as error :
        print ("Error:\n", error)
    finally:
        if (connection):
            cursor.close()
            connection.close()




