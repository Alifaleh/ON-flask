import inc.db as db

def getAccountInfo(username,with_id=False):
    account_types=['User','Operator','Admin','Manager','Super User']
    q='''
        select email from users where username= '{username}'
    '''.format(username=username)
    email=db.sendQuery(q)[0][0]

    q='''
        select id from users where username= '{username}'
    '''.format(username=username)
    user_id=db.sendQuery(q)[0][0]

    q='''
        select acc_type from account_type where u_id= '{user_id}'
    '''.format(user_id=user_id)
    acc_type=db.sendQuery(q)[0][0]
    if with_id:
        return email,account_types[acc_type],acc_type,user_id
    else:
        return email,account_types[acc_type],acc_type