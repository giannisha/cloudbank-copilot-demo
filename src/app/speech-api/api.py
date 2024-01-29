#!/usr/bin/env python
# coding: utf-8

import logging
import sys
import time
from flask import Flask, request, jsonify
from speech.studio import submit_synthesis, get_synthesis

logging.basicConfig(stream=sys.stdout, level=logging.INFO,  # set to logging.DEBUG for verbose output
        format="[%(asctime)s] %(message)s", datefmt="%m/%d/%Y %I:%M:%S %p %Z")
logger = logging.getLogger(__name__)

app = Flask(__name__)

@app.route('/speech-api/generate', methods=['POST'])
def generate():
    data = request.json
    text = data.get('text', '')
    error = None
    url = None

    job_id = submit_synthesis(text)

    if job_id is not None:
        while True:
            response = get_synthesis(job_id)
            if response.status_code < 400:
                logger.debug('Get batch synthesis job successfully')
                logger.debug(response.json())
                if response.json()['status'] == 'Succeeded':
                    logger.info(f'Batch synthesis job succeeded, download URL: {response.json()["status"]}')
                    url = response.json()["outputs"]["result"]
                    break
                logger.info(f'Batch synthesis job is still running, status [{response.json()["status"]}]')
            else:
                logger.error(f'Failed to get batch synthesis job: {response.text}')
                error = f'Failed to get batch synthesis job: {response.text}'
                break
            time.sleep(3)

    return jsonify({'url': url, 'error': error})

if __name__ == '__main__':
    # Dev Server
    app.run(port=5000, debug=True)
