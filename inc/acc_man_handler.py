import inc.db as db

import inc.email_handler as EH

from inc.registeration_handler import host

import random,string

import inc.validator as val

import inc.password_reset_handler as PRH

import hashlib 

def search(search):
    q='''
        select users.id,username,email,verified,acc_type from users,account_type
        where users.id=account_type.u_id and (username like '%{search}%' or email like '%{search}%') LIMIT 20;
    '''.format(search=search)
    res1=db.sendQuery(q)

    q='''
        select users.id,user_agent,session_key,time from users,sessions 
        where users.id=sessions.u_id and (username like '%{search}%' or email like '%{search}%') LIMIT 20;
    '''.format(search=search)
    res2=db.sendQuery(q)

    q='''
        select users.id,reset_key,time from users,pw_reset
        where users.id=pw_reset.u_id and (username like '%{search}%' or email like '%{search}%') LIMIT 20;
    '''.format(search=search)
    res3=db.sendQuery(q)

    q='''
        select users.id,vc,time from users,verification_codes 
        where users.id=verification_codes.user_id and (username like '%{search}%' or email like '%{search}%') LIMIT 20;
    '''.format(search=search)
    res4=db.sendQuery(q)
    resp=[]
    for user in res1:
        cu=[]
        cu.append(user)
        id=user[0]
        userSessions=[]
        for session in res2:
            if session[0]==id:
                session=list(session)
                session[2] = hashlib.md5(session[2].encode("utf-8")).hexdigest()
                userSessions.append(session)
        cu.append(userSessions)

        userResetKey=[]
        for reset_key in res3:
            if reset_key[0]==id:
                reset_key=list(reset_key)
                reset_key[1] = hashlib.md5(reset_key[1].encode("utf-8")).hexdigest()
                userResetKey.append(reset_key)
        cu.append(userResetKey)
        
        userVerificationKeys=[]
        for v_key in res4:
            if v_key[0]==id:
                v_key=list(v_key)
                v_key[1] = hashlib.md5(v_key[1].encode("utf-8")).hexdigest()
                userVerificationKeys.append(v_key)
        cu.append(userVerificationKeys)

        resp.append(cu)
    
    us='/***/'
    ds='*/*'
    ss='*///*'
    iss='*//*'
    userResp=''
    for nn,user in enumerate(resp):
        for n,i in enumerate(user):
            if n==0:
                userResp+=str(i[1])+ds+str(i[2])+ds+str(i[3])+ds+str(i[4])+ds+str(i[0])+ss
            elif n==1:
                for n2,i2 in enumerate(i):
                    userResp+=str(i2[1])+ds+str(i2[2])+ds+str(i2[3])
                    if n2+1 < len(i):
                        userResp+=iss
                userResp+=ss
            elif n==2:
                for i2 in i:
                    userResp+=str(i2[1])+ds+str(i2[2])
                userResp+=ss
            elif n==3:
                for i2 in i:
                    userResp+=str(i2[1])+ds+str(i2[2])

        if nn+1 < len(resp):
            userResp+=us
    return userResp


def sendPRE(username,email,acc_num):
    q='''
    select id from users where username= '{username}'
    '''.format(username=username)
    user_id=db.sendQuery(q)[0][0]

    q='''
        select acc_type from account_type where u_id = '{id}'
    '''.format(id=user_id)
    uacctype=db.sendQuery(q)[0][0]

    if acc_num > uacctype:
        if PRH.verify(email):
            PRH.setPROperation(email)
        return '1'
    else:
        return 'account_type: you can not modify this account.'


def sendRVE(username,email,acc_num):
    q='''
    select id from users where username= '{username}'
    '''.format(username=username)
    user_id=db.sendQuery(q)[0][0]

    q='''
        select acc_type from account_type where u_id = '{id}'
    '''.format(id=user_id)
    uacctype=db.sendQuery(q)[0][0]

    if acc_num > uacctype:
        # generating a unique verification code for email verification.

        code=''.join(random.choice(string.ascii_lowercase + string.digits) for _ in range(64))
        q='''
            select * from verification_codes where vc = '{code}'
        '''.format(code=code)
        res=db.sendQuery(q)

        while len(res)>0:
            code=''.join(random.choice(string.ascii_lowercase + string.digits) for _ in range(64))
            q='''
            select * from verification_codes where vc = '{code}'
            '''.format(code=code)
            res=db.sendQuery(q)


        q='''
            delete from verification_codes where user_id={user_id};
        '''.format(user_id=user_id)
        res=db.sendQuery(q)

        # inserting the verification code to the verification table.

        q='''
            INSERT INTO verification_codes (user_id, vc, time)
            VALUES ( '{user_id}', '{code}',now());
        '''.format(user_id=user_id,code=code)
        res=db.sendQuery(q)

        # sending the email using the email_handler.py
        EH.sendRVE(username,email,host,code)
        return '1'
    else:
        return 'account_type: you can not modify this account.'


def changeData(a_id,id,email,uname,uemail,verification,account_type,sessions2Delete,pr2Delete,ev2Delete,acc_num):
    q='''
        select acc_type from account_type where u_id = '{id}'
    '''.format(id=id)
    uacctype=db.sendQuery(q)[0][0]
    q='''
        select username,email from users where id = '{id}'
    '''.format(id=id)
    res=db.sendQuery(q)
    changed_uname=False
    changed_email=False
    if uname != res[0][0]:
        changed_uname=True
    if uemail != res[0][1]:
        changed_email=True
    
    errors=[]
    if changed_uname:
        usernameError=val.validateUsername(uname)
        if usernameError:
            errors.append(usernameError)
    
    if changed_email:
        emailError=val.validateEmail(uemail)
        if emailError:
            errors.append(emailError)

    if acc_num < 4 and acc_num <= uacctype:
        errors.append('account_type: you can not modify this account.')
    elif acc_num < 4 and acc_num <= account_type:
        errors.append('account_type: you can not set account order to equal or higher than your order.')


    if len(errors)==0:
        columns=['username','email','verified','acc_type']
        q='''
            select username,email,verified,acc_type
            from (select * from users,account_type where users.id=account_type.u_id) as tmp
            where tmp.u_id ={}
        '''.format(id)
        old_info=list(db.sendQuery(q)[0])
        old_info[2]=str(old_info[2]).lower()
        new_info=[uname,uemail,verification,account_type]
        old_info_str=''
        new_info_str=''
        changed_columns=''
        for i,col in enumerate(old_info):
            if new_info[i]!=col:
                old_info_str+=str(col)+','
                new_info_str+=str(new_info[i])+','
                changed_columns+=columns[i]+','
        changed_columns=changed_columns[:-1]
        old_info_str=old_info_str[:-1]
        new_info_str=new_info_str[:-1]
        q='''
            update users
            set username = '{uname}',email = '{email}',verified = '{verification}'
            where id = '{id}'
        '''.format(uname=uname, email=uemail, verification=verification, id=id)
        res=db.sendQuery(q)

        q='''
            update account_type
            set acc_type = '{acc_type}'
            where u_id = '{id}'
        '''.format(acc_type=account_type,id=id)
        res=db.sendQuery(q)

        
        sessions2Delete_str=''
        for session in sessions2Delete:
            sessions2Delete_str+=session+','
            q='''
                delete from sessions
                where MD5(session_key)= '{session}'
            '''.format(session=session)
            res=db.sendQuery(q)
        sessions2Delete_str=sessions2Delete_str[:-1]
        q='''
            delete from pw_reset
            where MD5(reset_key)= '{pr2Delete}'
        '''.format(pr2Delete=pr2Delete)
        res=db.sendQuery(q)

        q='''
            delete from verification_codes
            where MD5(vc)= '{ev2Delete}'
        '''.format(ev2Delete=ev2Delete)
        res=db.sendQuery(q)
        q='''
            insert into account_admin_log (admin_id, effected_id, changed_columns, old_values, new_values, deleted_sessions, deleted_vc, deleted_pr, sent_ve, sent_pre, date)
            values ({},{},'{}','{}','{}','{}','{}','{}',false,false,now())
        '''.format(a_id,id,changed_columns,old_info_str,new_info_str,sessions2Delete_str,ev2Delete,pr2Delete)
        res=db.sendQuery(q)
        return 'OK'
    else :
        return str(errors)


def logEmail(a_id,email,emailType):
    q='''
        select id from users where email= '{email}'
    '''.format(email=email)
    id=db.sendQuery(q)[0][0]
    if emailType==0:
        q='''
            insert into account_admin_log (admin_id, effected_id, changed_columns, old_values, new_values, deleted_sessions, deleted_vc, deleted_pr, sent_ve, sent_pre, date)
            values ({},{},'','','','','','',true,false,now())
        '''.format(a_id,id)
        res=db.sendQuery(q)
    else:
        q='''
            insert into account_admin_log (admin_id, effected_id, changed_columns, old_values, new_values, deleted_sessions, deleted_vc, deleted_pr, sent_ve, sent_pre, date)
            values ({},{},'','','','','','',false,true,now())
        '''.format(a_id,id)
        res=db.sendQuery(q)     
    