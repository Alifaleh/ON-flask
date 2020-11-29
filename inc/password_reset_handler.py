import inc.db as db
from inc.registeration_handler import host
import inc.email_handler as EH
import random,string

def verify(email):
    q='''
        select username from users
        where email= '{}'
    '''.format(email)
    res=db.sendQuery(q)
    if len(res)==1:
        return True
    else:
        return False

def setPROperation(email):
    q='''
        select id,username from users
        where email= '{}'
    '''.format(email)
    res=db.sendQuery(q)
    u_id=res[0][0]
    username=res[0][1]

    code=''.join(random.choice(string.ascii_lowercase + string.digits) for _ in range(64))
    q='''
        select * from pw_reset where reset_key = '{code}'
    '''.format(code=code)
    res=db.sendQuery(q)
    while len(res)>0:
        code=''.join(random.choice(string.ascii_lowercase + string.digits) for _ in range(64))
        q='''
            select * from pw_reset where reset_key = '{code}'
        '''.format(code=code)
        res=db.sendQuery(q)


    q='''
        delete from pw_reset where u_id={user_id};
        INSERT INTO pw_reset (u_id, reset_key, time)
        VALUES ( '{user_id}', '{code}',now());
    '''.format(user_id=u_id,code=code)
    res=db.sendQuery(q)

    # sending the email using the email_handler.py

    EH.sendPRE(username,email,host,code)

def verifyPRRequest(username,code):
    # verifing if the username has a this reset_key by using sql join query.
    q='''
    delete from pw_reset where (time < now()-'1 day'::interval);
    select *
    from(select username,reset_key from users , pw_reset where users.id = pw_reset.u_id ) as temp
    where temp.username='{username}' and temp.reset_key= '{code}';
    '''.format(username=username,code=code)
    res=db.sendQuery(q)

    if len(res)==1:
        return True
    else:
        return False


def proceed(username,password):
    q='''
        delete from pw_reset where u_id = (select id from users where username = '{username}');
        UPDATE users
        SET password = '{password}'
        WHERE username='{username}';
    '''.format(username=username,password=password)
    res=db.sendQuery(q)