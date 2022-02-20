from services.mysql import connection_pool


def create_report(report):
    cursor = connection_pool.cursor()
    create_tables(cursor)
    cursor.execute('INSERT INTO reports(user_id, image, health, remarks, sample) '
                   'VALUES(%s, %s, %s, %s, %s);',
                   (report['user_id'], report['image'], report['health'], report['remarks'],
                    report['sample']))

    report_id = cursor.lastrowid

    for product in report['products']:
        cursor.execute('INSERT INTO report_products(report_id, product_id) VALUES(%s, %s);',
                       (report_id, product['id']))

    for remedy in report['home_remedies']:
        cursor.execute('INSERT INTO report_remedies(report_id, remedy_id) VALUES(%s, %s);',
                       (report_id, remedy['id']))

    connection_pool.commit()
    cursor.close()


def create_tables(cursor):
    cursor.execute('''CREATE TABLE IF NOT EXISTS reports(
                    id INT NOT NULL AUTO_INCREMENT,
                    user_id INT NOT NULL,
                    image VARCHAR(100) NOT NULL,
                    health INT NOT NULL,
                    remarks VARCHAR(25) NOT NULL,
                    sample VARCHAR(10) NOT NULL,
                    FOREIGN KEY(user_id) REFERENCES users(id),
                    PRIMARY KEY(id));''')
    cursor.execute('''CREATE TABLE IF NOT EXISTS report_remedies(
                    id INT NOT NULL AUTO_INCREMENT,
                    report_id INT NOT NULL,
                    remedy_id INT NOT NULL,
                    FOREIGN KEY(report_id) REFERENCES reports(id),
                    FOREIGN KEY(remedy_id) REFERENCES home_remedies(id),
                    PRIMARY KEY(id));''')
    cursor.execute('''CREATE TABLE IF NOT EXISTS report_products(
                    id INT NOT NULL AUTO_INCREMENT,
                    report_id INT NOT NULL,
                    product_id INT NOT NULL,
                    FOREIGN KEY(report_id) REFERENCES reports(id),
                    FOREIGN KEY(product_id) REFERENCES products(id),
                    PRIMARY KEY(id));''')


def read_report_count():
    cursor = connection_pool.cursor()
    create_tables(cursor)
    cursor.execute('SELECT MAX(id) AS count FROM reports;')
    count, = cursor.fetchone()
    cursor.close()
    return count or 0


def read_reports(user_id):
    cursor = connection_pool.cursor()
    create_tables(cursor)
    cursor.execute('SELECT * FROM reports WHERE user_id=%s;', (user_id,))
    result = cursor.fetchall()
    reports = [{
        'id': id,
        'user_id': user_id,
        'image_url': image_url,
        'health': health,
        'remarks': remarks,
        'sample': sample,
    } for id, user_id, image_url, health, remarks, sample in result]
    cursor.close()
    return reports
