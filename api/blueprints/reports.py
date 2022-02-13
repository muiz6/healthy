import os
import sys

from flask import Blueprint, request

import services.image_processor as image_processor
import models.report as report


reports = Blueprint('reports', __name__)
UPLOAD_FOLDER = 'uploads'


@reports.route('/reports/hair/', methods=['POST'])
def post_hair():
    return create_report('hair')


@reports.route('/reports/skin/', methods=['POST'])
def post_skin():
    return create_report('skin')


def create_report(sample):
    user_id = request.form.get('user_id')
    picture = request.files.get('picture')
    if user_id and picture:
        _, extension = os.path.splitext(picture.filename)
        file_name = f'{report.read_report_count() + 1}{extension}'
        picture.save(os.path.join(os.getcwd(), UPLOAD_FOLDER, file_name))

        if sample == 'hair':
            result = image_processor.process_hair(picture)
        if sample == 'skin':
            result = image_processor.process_skin(picture)

        response = result.copy()
        response['image'] = file_name
        response['user_id'] = user_id
        response['sample'] = sample

        report.create_report(response)
        response['image_url'] = f'{request.root_url}images/{response.pop("image", "#")}'

        return response

    return {'message': 'Something went wrong!'}, 400


@reports.route('/reports/', methods=['GET'])
def get_reports():
    pass
