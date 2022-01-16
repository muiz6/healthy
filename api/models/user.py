from os import environ
from services.mysql import connection_pool


def create_user(email, name, password):
    conn = connection_pool.cursor()
    create_table(conn)
    conn.execute('INSERT INTO users(email, name, password) VALUES(%s, %s, %s)',
                 (email, name, password))
    conn.close()


def read_user(email):
    conn = connection_pool.cursor()
    create_table(conn)
    conn.execute('SELECT * FROM users WHERE email=%s', (email, ))
    conn.close()


def create_table(conn):
    conn.execute('''CREATE TABLE IF NOT EXISTS users(
                    id INT NOT NULL AUTO_INCREMENT,
                    email VARCHAR(100),
                    name VARCHAR(100),
                    password VARCHAR(100),
                    PRIMARY KEY(id));''')
