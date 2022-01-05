from flask import Blueprint, request

from models import user


users = Blueprint('users', __name__)


@users.route('/users/', methods=['POST'])
def post_user():
    name, email, password = request.form['name'], request.form['email'], request.form['password']
    if (name and email and password):
        user.create_user(name, email, password)
        return {'name': name, 'email': email}


@users.route('/users/login', methods=['POST'])
def post_user_login():
    pass
