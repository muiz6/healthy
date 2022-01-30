from flask import Flask

from blueprints.users import users
from blueprints.reports import reports


app = Flask(__name__)

app.register_blueprint(users)
app.register_blueprint(reports)


@app.route('/')
def hello_world():
    return {'message': 'Welcome to Healthy API'}


@app.errorhandler(500)
def handle_500_error(_):
    return {'message': 'Something went wrong!'}, 500
