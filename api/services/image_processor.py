import random

import models.home_remedies as remedies
import models.products as products


def process_hair(picture_file):
    return {
        'health': 50 + random.randint(1, 49),
        'products': products.read_products(),
        'home_remedies': remedies.read_home_remedies(),
        'remarks': 'n/a'
    }


def process_skin(picture_file):
    return {
        'health': 50 + random.randint(1, 49),
        'products': products.read_products(),
        'home_remedies': remedies.read_home_remedies(),
        'remarks': 'n/a'
    }
