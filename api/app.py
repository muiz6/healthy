import os

from flask import Flask, send_from_directory

from blueprints.users import users
from blueprints.reports import reports
from constants import UPLOAD_FOLDER


app = Flask(__name__)

app.register_blueprint(users)
app.register_blueprint(reports)


@app.route('/')
def hello_world():
    return {'message': 'Welcome to Healthy API'}


@app.route('/images/<path:path>')
def send_js(path):
    return send_from_directory(os.path.join(os.getcwd(), UPLOAD_FOLDER), path)


@app.errorhandler(500)
def handle_500_error(_):
    return {'message': 'Something went wrong!'}, 500
