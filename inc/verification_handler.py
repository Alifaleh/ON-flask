import inc.db as db

def verify(username,code):
    # verifing if the username has a this vc by using sql join query.
    q='''
    delete from users where id = (
        select users.id from users,verification_codes where (users.id = verification_codes.user_id) and (time < now()-'1 day'::interval) 
    );
    select *
    from(select username,vc from users , verification_codes where users.id = verification_codes.user_id ) as temp
    where temp.username='{username}' and temp.vc= '{code}'; 
    '''.format(username=username,code=code)
    res=db.sendQuery(q)

    # if there are such a record update the verifyed column to true and delete the vc record. else abort.
    if len(res)==1:
        q='''
            update users
            set verified=true
            where username= '{username}'
        '''.format(username=username)
        res=db.sendQuery(q) 
        q='''
            select id from users where username= '{username}'
        '''.format(username=username)

        q='''
            delete from verification_codes where vc= '{code}'
        '''.format(code=code)
        res=db.sendQuery(q) 
        return True
    else:
        return False
