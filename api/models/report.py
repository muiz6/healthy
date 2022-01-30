from services.mysql import connection_pool


def create_report(email):
    pass


def create_table(cursor):
    cursor.execute('''CREATE TABLE IF NOT EXISTS reports(
                    id INT NOT NULL AUTO_INCREMENT,
                    user_id INT NOT NULL,
                    file_extension VARCHAR(10) NOT NULL,
                    remarks VARCHAR(25) NOT NULL,
                    sample VARCHAR(10) NOT NULL,
                    PRIMARY KEY(id));''')
