import mysql.connector

from services.env import config


dbconfig = {
    'host': 'localhost',
    'user': 'root',
    'passwd': f'{config["DB_PASS"]}',
    'database': 'healthy',
}

connection_pool = mysql.connector.connect(
    pool_name='mypool',
    pool_size=3,
    **dbconfig)
