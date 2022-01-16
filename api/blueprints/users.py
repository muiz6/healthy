from flask import Blueprint, request

from models import user


users = Blueprint('users', __name__)


@users.route('/users/', methods=['POST'])
def post_user():
    name, email, password = request.form['name'], request.form['email'], request.form['password']
    if (name and email and password):
        user.create_user(email, name, password)
        return {'email': email, 'name': name}

    return {'message': 'Something went wrong!'}


@users.route('/users/login', methods=['POST'])
def post_user_login():
    email, password = request.form['email'], request.form['password']
    if (email and password):
        readUser = user.read_user(email)
        if password == readUser['password']:
            return readUser

    return {'message': 'Invalid credentials'}
