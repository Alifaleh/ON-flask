import inc.email_handler as EH
from flask import abort

def logError(e,location,file):
    errorMessage='''\n\n\n
    ###############################
    #######      Error      #######
    ###############################
    At the file : {file}
    At the function : {location}
    
    Error: {e}
    '''.format(file=file,location=location,e=str(e))
    print(errorMessage)
    errorsLog=open('errors.log','a+')
    errorsLog.write(errorMessage)
    errorsLog.close()
    EH.sendELE(errorMessage)
    abort(500)