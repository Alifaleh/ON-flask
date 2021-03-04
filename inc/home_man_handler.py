import random,string

import inc.db as db

import base64

import os

from flask import jsonify, Markup

def homeMan_EH(title, price, order, discription, image, imageName, request, imageIsRequired=True):
    allowed_fileTypes=['png','jpg','jpeg','svg']
    title=str(request.form.get('title'))
    price=request.form.get('price')
    order=request.form.get('order')
    discription=request.form.get('discription')
    image= request.form.get('image')
    imageName= request.form.get('imagename')

    errors={}
    if len(title)>20:
        errors['title']='Max title length is 20 characater.'
    elif len(title)<1:
        errors['title']='Title cannot be empty.'
    
    try:
        price=float(price)
    except:
        errors['price']='Price should be integet or floating number.'
    if len(str(price))>15:
        errors['price']='Max price length is 15 characater.'
    elif len(str(price))<1:
        errors['price']='Price cannot be empty.'


    try:
        order=int(order)
    except:
        errors['order']='Order should be integet number.'
    if len(str(order))<1:
        errors['order']='Order cannot be empty.'

    if imageIsRequired:
        if len(imageName)<1:
            errors['image']='Product image is required.'
        elif imageName.split('.')[-1].lower() not in allowed_fileTypes:
            errors['image']='Unsupported file type.'
    
    return errors


def add_product(title, price, order, discription, image, imageName, request):
    errors=homeMan_EH(title, price, order, discription, image, imageName, request)
    if len(errors)==0:
        code=''.join(random.choice(string.ascii_lowercase + string.digits) for _ in range(10))
        image = base64.decodebytes(bytes(image, 'utf-8'))
        file=open('local/products_images/'+imageName.split('.')[0]+'_'+code+'.'+imageName.split('.')[-1],'wb')
        file.write(image)
        file.close()
        q='''
            INSERT INTO products (title, discription, price, image_name, p_order)
            VALUES ( '{}', '{}', '{}', '{}', {});
        '''.format(title, discription, price, imageName.split('.')[0]+'_'+code+'.'+imageName.split('.')[-1], order)
        res=db.sendQuery(q)
        return 'OK'
    else:
        return jsonify(errors)


def getProducts(mode=0):
    q='''
        select * from products
        ORDER BY p_order ASC;
    '''
    res=db.sendQuery(q)
    if mode==0:
        prods=[]
        for prod in res:
            cpdec={'id':prod[0], 'title':prod[1], 'description':prod[2], 'price':prod[3],'order':prod[4], 'image':prod[5]}
            prods.append(cpdec)
        return jsonify(prods)
    else:
        return res

def modifyProduct(p_id, mode, title, price, order, discription, image, imageName, request):
    if mode=='0':
        q='''
            select * from products
            where id={};
        '''.format(int(p_id))
        res=db.sendQuery(q)[0]
        prod=[]
        cpdec={'id':res[0], 'title':res[1], 'description':res[2], 'price':res[3], 'order':res[4]}
        prod.append(cpdec)
        return jsonify(prod)

    elif mode=='1':
        if image=='':
            errors=homeMan_EH(title, price, order, discription, image, imageName, request, False)
            if len(errors)==0:
                q='''
                    UPDATE products
                    SET title = '{}', price='{}', discription='{}', p_order={}
                    WHERE id={};
                '''.format(title, price, discription, order, int(p_id))
                res=db.sendQuery(q)
                return 'OK'
            else:
                return jsonify(errors)
        else:
            errors=homeMan_EH(title, price, order, discription, image, imageName, request)
            if len(errors)==0:
                q='''
                    select image_name from products
                    where id={};
                '''.format(int(p_id))
                res=db.sendQuery(q)[0][0]
                try:
                    os.remove("local/products_images/"+res)
                except:
                    pass
                code=''.join(random.choice(string.ascii_lowercase + string.digits) for _ in range(10))
                image = base64.decodebytes(bytes(image, 'utf-8'))
                file=open('local/products_images/'+imageName.split('.')[0]+'_'+code+'.'+imageName.split('.')[-1],'wb')
                file.write(image)
                file.close()
                q='''
                    UPDATE products
                    SET title = '{}', price='{}', discription='{}', p_order={}, image_name='{}'
                    WHERE id={};
                '''.format(title, price, discription, order, imageName.split('.')[0]+'_'+code+'.'+imageName.split('.')[-1], int(p_id))
                res=db.sendQuery(q)
                return 'OK'
            else:
                return jsonify(errors)
    elif mode=='2':
        q='''
            select image_name from products
            where id={};
        '''.format(int(p_id))
        res=db.sendQuery(q)[0][0]
        try:
            os.remove("local/products_images/"+res)
        except:
            pass
        q='''
            delete from products
            where id={};
        '''.format(int(p_id))
        db.sendQuery(q)
        return 'OK'



def getCards():
        card_file=open('templates/product_card.html','r')
        card_html=card_file.read()
        card_file.close()
        cards=''
        prods=getProducts(mode=1)
        for prod in prods:
            cards+=card_html.format(prod[5], prod[1], prod[2], prod[3])
        cards=Markup(cards)
        return cards