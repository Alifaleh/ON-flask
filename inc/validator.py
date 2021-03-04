import inc.db as db

from re import match


# registeration validators

def validatePassword(password,single=False,confpass=''):
    error=None
    if password=="":
        error='password: password is required.'
    elif len(password)<8:
        error='password: password should have 8 charachters as minimum.'
    elif len(password)>32:
        error='password: password should have 32 charachters as maximum.'
    elif not any(char.isdigit() for char in password): 
        error='password: Password should have at least one number.'
        
    elif not any(char.isupper() for char in password): 
        error='password: Password should have at least one uppercase letter.' 
        
    elif not any(char.islower() for char in password): 
        error='password: Password should have at least one lowercase letter.'
    else:
        if single:
            error='password: '
        else:
            if confpass=="":
                error='confpass: password confermation is required.'
            elif password != confpass:
                error='confpass: Passwords did not match.'
    return error


def validateUsername(username,single=False):
    error=None
    q='''
    select username from users
    where username= '{username}'
    '''.format(username=username)
    res=db.sendQuery(q)

    if len(res)!=0:
        error="username: username already exists."
    elif username=="":
        error='username: User name is required.'
    elif len(username)<3:
        error='username: User name should have 3 charachters as minimum.'
    elif len(username)>25:
        error='username: User name should have 25 charachters as maximum.'
    else:
        if single:
            error='username: '
    return error


def validateEmail(Email,single=False):
    error=None
    q='''
        select username from users
        where email= '{email}'
    '''.format(email=Email)
    res=db.sendQuery(q)
    if len(res)!=0:
        error="email: email already linked to another account."
    elif Email=="":
        error='email: email is required.'
    elif len(Email)<8:
        error='email: email should have 8 charachters as minimum.'
    elif len(Email)>32:
        error='email: email should have 32 charachters as maximum.'
    elif not(match(r"[^@]+@[^@]+\.[^@]+", Email)):
        error='email: email is not valid.'
    else:
        if single:
            error='email: '
    return error






# log in validators



def loginValidator(username,password):
    error=None
    if username=='' or password=='':
        return 'password: username and password are required.'
    else:
        q='''
        select username from users
        where username= '{username}' and password='{password}' and verified = true
        '''.format(username=username,password=password)
        res1=db.sendQuery(q)

        q='''
        select username from users
        where username= '{username}' and password='{password}'
        '''.format(username=username,password=password)
        res2=db.sendQuery(q)
        if len(res1)!=len(res2):
            error="password: Please verify your email address before logging in."
        elif len(res1)==len(res2)==0:
            error="password: Invalid Credentials."
        return error



