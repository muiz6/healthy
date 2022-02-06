from services.mysql import connection_pool


def create_report(report):
    cursor = connection_pool.cursor()
    create_table(cursor)

    cursor.close()


def create_table(cursor):
    cursor.execute('''CREATE TABLE IF NOT EXISTS reports(
                    id INT NOT NULL AUTO_INCREMENT,
                    user_id INT NOT NULL,
                    image_url VARCHAR(100) NOT NULL,
                    remarks VARCHAR(25) NOT NULL,
                    sample VARCHAR(10) NOT NULL,
                    PRIMARY KEY(id));''')


def read_report_count():
    cursor = connection_pool.cursor()
