from flask import Flask
from dotenv import load_dotenv

from blueprints.users import users


app = Flask(__name__)

app.register_blueprint(users)


@app.route('/')
def hello_world():
    return {'message': 'Welcome to Healthy API'}
