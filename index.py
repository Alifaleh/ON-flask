from flask import Flask, render_template, send_from_directory, request, redirect, url_for, abort, session, make_response

import inc.validator as val

import random,string

import inc.registeration_handler as RH

import inc.error_loger as EL

import inc.verification_handler as VH

import datetime

import inc.account_info_handler as AIH

import inc.session_manager as sm

import inc.password_reset_handler as PRH

import inc.acc_man_handler as AMH

import inc.email_handler as EH

app=Flask(__name__)


def turnicate(string,lower=True):
    string=str(string)
    string=string.replace(" ","")
    string=string.replace(",","")
    string=string.replace("`","")
    string=string.replace("\n","")
    if lower:
        string=string.lower()
    return string

@app.route('/')
def index():
    cookieValue = request.cookies.get('onenetworkcookie')
    if sm.hasSession(cookieValue,"{} {}".format(request.user_agent.platform,request.user_agent.browser)):
        username=cookieValue.split('/**/')[0]
        email,acc_type,acc_num=AIH.getAccountInfo(username)
        return render_template('home.html',username=username, acc_num=acc_num)
    else:
        return render_template('home.html')

@app.route('/local/<path>/<filename>')
def send_file(path,filename):
    return send_from_directory('local',path+'/'+filename)

@app.route('/fontawesome/<path>/<filename>')
def send_fa(path,filename):
    return send_from_directory('fontawesome',path+'/'+filename)


@app.route('/login')
def login():
    cookieValue = request.cookies.get('onenetworkcookie')
    if sm.hasSession(cookieValue,"{} {}".format(request.user_agent.platform,request.user_agent.browser)):
        return redirect(url_for('dashboard'))
    else:
        return render_template('login_page.html')

@app.route('/checkone',methods=['POST'])
def checkone():
    try:
        if request.method=='POST':
            error='non'
            toBeChecked=request.form.get('tobechecked')
            value=request.form.get('value')
            if toBeChecked=='reg-pass':
                value=turnicate(value,False)
            else:
                value=turnicate(value)
            if toBeChecked=='reg-uname':
                error=val.validateUsername(value,True)

            elif toBeChecked=='reg-email':
                error=val.validateEmail(value,True)

            elif toBeChecked=='reg-pass':
                error=val.validatePassword(value,True)

            else :
                error='Unknown'
            return error
    except Exception as e:
        EL.logError(e,'checkone','index.py')


@app.route('/checkdata',methods=['POST'])
def checkData():
    try:
        if request.method=='POST':
            errors=[]
            username= turnicate(request.form.get('username'))
            password=turnicate(request.form.get('password'),False)
            email=turnicate(request.form.get('email'))
            confpass=turnicate(request.form.get('confpass'),False)

            usernameError=val.validateUsername(username)
            if usernameError:
                errors.append(usernameError)

            passwordError=val.validatePassword(password,confpass=confpass)
            if passwordError:
                errors.append(passwordError)
            
            emailError=val.validateEmail(email)
            if emailError:
                errors.append(emailError)

            if len(errors)==0:
                return 'registered sucssessfuly'
            else :
                return str(errors)
    except Exception as e:
        EL.logError(e,'checkData','index.py')

@app.route('/register',methods=['POST'])
def register():
    try: 
        if request.method=='POST':
            errors=[]
            username= turnicate(request.form.get('username'))
            password=turnicate(request.form.get('password'),False)
            email=turnicate(request.form.get('email'))
            confpass=turnicate(request.form.get('confpass'),False)

            usernameError=val.validateUsername(username)
            if usernameError:
                errors.append(usernameError)

            passwordError=val.validatePassword(password,confpass=confpass)
            if passwordError:
                errors.append(passwordError)
            
            emailError=val.validateEmail(email)
            if emailError:
                errors.append(emailError)

            
            if len(errors)==0:
                RH.register(username,email,password)
                return redirect(url_for('registered'),code=307)
            else :
                return str(errors)
    except Exception as e:
        EL.logError(e,'register','index.py')

@app.route('/registered',methods=['POST','GET'])
def registered():
    if request.method=='POST':
        return render_template('registered-successfully.html')
    else:
        abort(404)

@app.route('/verify/<username>/<code>')
def verify(username,code):
    if VH.verify(username,code):
        return render_template('account_activated.html')
    else:
        abort(404)



@app.route('/checklogindata',methods=['POST'])
def checkLoginData():
    try:
        if request.method=='POST':
            errors=[]
            username= turnicate(request.form.get('username'))
            password=turnicate(request.form.get('password'),False)

            usernameError=val.loginValidator(username,password)
            if usernameError:
                errors.append(usernameError)

            if len(errors)==0:
                return 'signed in sucssessfuly'
            else :
                return str(errors)
    except Exception as e:
        EL.logError(e,'checkLoginData','index.py')



@app.route('/logmein',methods=['POST'])
def logmein():
    try:
        if request.method=='POST':
            errors=[]
            username= turnicate(request.form.get('username'))
            password=turnicate(request.form.get('password'),False)
            usernameError=val.loginValidator(username,password)
            if usernameError:
                errors.append(usernameError)
            if len(errors)==0:
                user_agent="{} {}".format(request.user_agent.platform,request.user_agent.browser)
                resp = make_response(redirect(url_for('dashboard')))
                resp=sm.setSession(username,user_agent,resp)
                return resp
            else :
                return str(errors)
    except Exception as e:
        EL.logError(e,'logmein','index.py')


@app.route('/dashboard')
def dashboard():
    cookieValue = request.cookies.get('onenetworkcookie')
    if sm.hasSession(cookieValue,"{} {}".format(request.user_agent.platform,request.user_agent.browser)):
        username=cookieValue.split('/**/')[0]
        email,acc_type,acc_num=AIH.getAccountInfo(username)
        return render_template('dashboard.html',username=username,acc_num=acc_num)
    else:
        return redirect(url_for('login'))

@app.route('/account')
def account():
    cookieValue = request.cookies.get('onenetworkcookie')
    if sm.hasSession(cookieValue,"{} {}".format(request.user_agent.platform,request.user_agent.browser)):
        username=cookieValue.split('/**/')[0]
        email,acc_type,acc_num=AIH.getAccountInfo(username)
        return render_template('account.html',username=username,email=email,acc_type=acc_type,acc_num=acc_num)
    else:
        return redirect(url_for('login'))

@app.route('/accman')
def accman():
    cookieValue = request.cookies.get('onenetworkcookie')
    if sm.hasSession(cookieValue,"{} {}".format(request.user_agent.platform,request.user_agent.browser)):
        username=cookieValue.split('/**/')[0]
        email,acc_type,acc_num=AIH.getAccountInfo(username)
        if acc_num > 1:
            return render_template('accounts_management.html',username=username,email=email,acc_type=acc_type,acc_num=acc_num)
        else:
            abort(404)
    else:
        return redirect(url_for('login'))




@app.route('/search',methods=['POST','GET'])
def search():
    if request.method=='POST':
        cookieValue = request.cookies.get('onenetworkcookie')
        if sm.hasSession(cookieValue,"{} {}".format(request.user_agent.platform,request.user_agent.browser)):
            username=cookieValue.split('/**/')[0]
            email,acc_type,acc_num=AIH.getAccountInfo(username)
            if acc_num > 1:
                try:
                    search= turnicate(request.form.get('search'))
                    userResp=AMH.search(search)
                    return userResp
                except:
                    abort(500)
            else:
                abort(404)
        else:
            abort(404)
    else:
        abort(404)


@app.route('/sendve',methods=['POST','GET'])
def sendVE():
    if request.method=='POST':
        cookieValue = request.cookies.get('onenetworkcookie')
        if sm.hasSession(cookieValue,"{} {}".format(request.user_agent.platform,request.user_agent.browser)):
            username=cookieValue.split('/**/')[0]
            email,acc_type,acc_num,a_id=AIH.getAccountInfo(username,True)
            if acc_num > 1:
                try:
                    uname= turnicate(request.form.get('username'))
                    uemail=turnicate(request.form.get('email'))
                    AMH.logEmail(a_id,uemail,0)
                    return AMH.sendRVE(uname,uemail,acc_num)
                except:
                    abort(500)
            else:
                abort(404)
        else:
            abort(404)
    else:
        abort(404)


@app.route('/changeuserdata',methods=['POST','GET'])
def changeuserdata():
    if request.method=='POST':
        cookieValue = request.cookies.get('onenetworkcookie')
        if sm.hasSession(cookieValue,"{} {}".format(request.user_agent.platform,request.user_agent.browser)):
            username=cookieValue.split('/**/')[0]
            email,acc_type,acc_num,a_id=AIH.getAccountInfo(username,True)
            if acc_num > 1:
                # try:
                id=turnicate(request.form.get('id'))
                uname= turnicate(request.form.get('username'))
                uemail= turnicate(request.form.get('email'))
                verification=turnicate(request.form.get('verification'))
                account_type=int(turnicate(request.form.get('account_type')))
                sessions2Delete=turnicate(request.form.get('sessions2delete')).split('/***/')
                sessions2Delete.pop()
                pr2Delete=turnicate(request.form.get('pr2delete'))
                ev2Delete=turnicate(request.form.get('ev2delete'))
                response=AMH.changeData(a_id,id,email,uname,uemail,verification,account_type,sessions2Delete,pr2Delete,ev2Delete,acc_num)
                return response
                # except:
                #     abort(500)
            else:
                abort(404)
        else:
            abort(404)
    else:
        abort(404)



@app.route('/logout',methods=['POST'])
def logout():
    cookieValue = request.cookies.get('onenetworkcookie')
    if sm.hasSession(cookieValue,"{} {}".format(request.user_agent.platform,request.user_agent.browser)):
        if request.method=='POST':
            resp = make_response('logging out')
            resp=sm.delSession(resp,cookieValue)
            return resp
    else:
        abort(404)
        

@app.route('/forgotpw')
def forgotpw():
    return render_template('forgotpw.html')

@app.route('/forgetpwreciever',methods=['POST','GET'])
def forgetpwReciever():
    if request.method=='POST':
        uemail=turnicate(request.form.get('email'))
        uname=turnicate(request.form.get('uname'))
        cookieValue = request.cookies.get('onenetworkcookie')
        if sm.hasSession(cookieValue,"{} {}".format(request.user_agent.platform,request.user_agent.browser)):
            username=cookieValue.split('/**/')[0]
            email,acc_type,acc_num,a_id=AIH.getAccountInfo(username,True)
            AMH.logEmail(a_id,uemail,1)
            return AMH.sendPRE(uname,uemail,acc_num)
        else:
            if PRH.verify(uemail):
                PRH.setPROperation(uemail)
            return redirect(url_for('email_was_sent'),code=307)
    else:
        abort(404)

@app.route('/email_was_sent',methods=['POST','GET'])
def email_was_sent():
    if request.method=='POST':
        return render_template('pwreset_email_was_sent.html')
    else:
        abort(404)

@app.route('/passwordreset/<username>/<code>')
def passwordReset(username,code):
    if PRH.verifyPRRequest(username,code):
        return render_template('change_your_password.html',code=code,username=username)
    else:
        abort(404)

@app.route('/setpw',methods=['POST','GET'])
def setpw():
    if request.method=='POST':
        password=turnicate(request.form.get('password'),False)
        confpass=turnicate(request.form.get('confpass'),False)
        check=str(request.form.get('check'))
        error=val.validatePassword(password=password,confpass=confpass)
        username=turnicate(request.form.get('username'))
        code=turnicate(request.form.get('code'),False)
        if check=='1':
            if error:
                return error
            else:
                return 'password reseted successfully'
        else:
            if error:
                return error
            else:
                if PRH.verifyPRRequest(username,code):
                    PRH.proceed(username,password)
                    return render_template('password_reseted.html')
                else:
                    abort(404)
    else:
        abort(404)


@app.errorhandler(404)
def page_not_found(error):
   return render_template('404.html', title = '404'), 404


if __name__ == '__main__':
    app.run(debug=True,host='192.168.3.40',port=8000)