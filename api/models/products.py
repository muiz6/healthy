from services.mysql import connection_pool


def read_products():
    cursor = connection_pool.cursor()
    cursor.execute('SELECT * FROM products;')
    result = cursor.fetchall()
    cursor.close()
    return [{'id': id, 'name': name, 'image_url': image_url} for id, name, image_url in result]
