import psycopg2

# def sendQuery(query,user="onnetwork",password="admin",host="localhost",port="5432",database="ondb"):
def sendQuery(query,user="nroaebnofikkng",password="ec6bcf8a00a2de5395f9f9879356d384fe626d0942e912c8f43fa202066a7049",host="ec2-52-203-165-126.compute-1.amazonaws.com",port="5432",database="dd2cmtp3thasia"):
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




