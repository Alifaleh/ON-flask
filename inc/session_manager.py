import random,string   
import inc.db as db


# this function is used to create a new session using cookies:
def setSession(username,user_agent,resp):
    # generating a unique session_key for email verification.
    code=''.join(random.choice(string.ascii_lowercase + string.digits) for _ in range(64))
    q='''
        select * from sessions where session_key = '{code}'
    '''.format(code=code)
    res=db.sendQuery(q)
    while len(res)>0:
        code=''.join(random.choice(string.ascii_lowercase + string.digits) for _ in range(64))
        q='''
            select * from sessions where session_key = '{code}'
        '''.format(code=code)
        res=db.sendQuery(q)

    # getting the user id of the user that loged in:
    q='''
        select id from users where username= '{username}'
    '''.format(username=username)
    user_id=db.sendQuery(q)[0][0]

    # inserting the new session information into the database:
    q='''
        INSERT INTO sessions (u_id,user_agent, session_key, time)
        VALUES ( '{user_id}','{user_agent}', '{code}',now());
        delete from sessions where id = (
        select users.id from users,sessions where (users.id = sessions.u_id) and (time < now()-'30 day'::interval) 
        );
    '''.format(user_id=user_id,user_agent=user_agent,code=code)
    res=db.sendQuery(q)

    # returning the response with the cookies:
    resp.set_cookie('onenetworkcookie', '{}/**/{}'.format(username,code),httponly = True,max_age=60 * 60 * 24 * 30)
    return resp

# this function is used to check if the user has an active session or not:
def hasSession(cookieValue,user_agent):
    try:
        username=cookieValue.split('/**/')[0]
        session_key=cookieValue.split('/**/')[1]
        q='''
            select * from sessions where u_id=(select users.id from users where users.username='{}') and session_key='{}' and user_agent='{}' 
        '''.format(username,session_key,user_agent)
        res=db.sendQuery(q)
        if len(res)==1:
            return True
        else:
            return False
    except:
        return False

# this function is used to delete the session:
def delSession(resp,cookieValue):
    q='''
        delete from sessions where session_key = '{}'
    '''.format(cookieValue.split('/**/')[1])
    res=db.sendQuery(q)
    resp.set_cookie('onenetworkcookie', 'del', max_age=0)
    return resp