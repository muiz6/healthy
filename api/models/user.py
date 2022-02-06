from services.mysql import connection_pool


def create_user(email, name, password):
    cursor = connection_pool.cursor()
    create_table(cursor)
    cursor.execute('INSERT INTO users(email, name, password) VALUES(%s, %s, %s)',
                   (email, name, password))
    connection_pool.commit()
    cursor.close()


def read_user(email):
    cursor = connection_pool.cursor()
    create_table(cursor)
    cursor.execute(
        'SELECT * FROM users WHERE email=%s', (email,))
    id, email, name, password = cursor.fetchone()
    cursor.close()
    return {
        'id': id,
        'email': email,
        'name': name,
        'password': password,
    }


def create_table(cursor):
    cursor.execute('''CREATE TABLE IF NOT EXISTS users(
                    id INT NOT NULL AUTO_INCREMENT,
                    email VARCHAR(100) NOT NULL,
                    name VARCHAR(100) NOT NULL,
                    password VARCHAR(100) NOT NULL,
                    UNIQUE(email),
                    PRIMARY KEY(id));''')
