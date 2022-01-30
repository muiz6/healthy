import os

from flask import Blueprint, request


reports = Blueprint('reports', __name__)
UPLOAD_FOLDER = 'uploads'


@reports.route('/reports/hair/', methods=['POST'])
def post_hair():
    return create_report('hair')


@reports.route('/reports/skin/', methods=['POST'])
def post_skin():
    return create_report('skin')


def create_report(sample):
    email, picture = request.form.get('email'), request.files.get('picture')
    if email and picture:
        _, extension = os.path.splitext(picture.filename)
        file_name = f'1{extension}'
        picture.save(os.path.join(os.getcwd(), UPLOAD_FOLDER, file_name))
        return {
            'email': email,
            'health_score': 50,
            'home_remedies': '',
            'products': '',
            'remarks': 'n/a',
            'sample': sample,
        }

    return {'message': 'Something went wrong!'}, 400


@reports.route('/reports/', methods=['GET'])
def get_reports():
    pass
