from flask import Flask, jsonify, make_response, request, abort, redirect, send_file
import logging
from logging.handlers import RotatingFileHandler
import emotion_gender_processor as eg_processor

# 初始化 Flask 应用
app = Flask(__name__)

# 配置日志记录
def setup_logging():
    # 设置日志级别
    logging.basicConfig(level=logging.DEBUG)

    # 创建一个日志文件处理器
    handler = RotatingFileHandler('app.log', maxBytes=10000, backupCount=3)
    handler.setLevel(logging.INFO)

    # 创建日志格式
    formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
    handler.setFormatter(formatter)

    # 添加处理器到 Flask 应用的日志记录器
    app.logger.addHandler(handler)

setup_logging()

@app.route('/')
def index():
    app.logger.info('Redirecting to the main website')
    return redirect("https://baidu.com", code=302)

@app.route('/classifyImage', methods=['POST'])
def upload():
    try:
        image = request.files['image'].read()
        result = eg_processor.process_image(image)
        app.logger.info('Image processed successfully.')
        return jsonify(result)
    except Exception as err:
        app.logger.error(f'An error has occurred whilst processing the file: {err}')
        abort(400)

@app.errorhandler(400)
def bad_request(error):
    app.logger.warning('Bad request encountered')
    return make_response(jsonify({'error': 'We cannot process the file sent in the request.'}), 400)

@app.errorhandler(404)
def not_found(error):
    app.logger.warning('Resource not found')
    return make_response(jsonify({'error': 'Resource not found.'}), 404)

@app.errorhandler(Exception)
def handle_exception(error):
    app.logger.error(f'Unhandled exception: {error}')
    response = jsonify({'message': 'An error occurred, please try again later.'})
    response.status_code = 500
    return response

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=8084)

 
 
