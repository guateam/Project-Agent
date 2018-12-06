import random
import string

from flask import Flask, jsonify, request
from flask_cors import CORS

from db import Database, generate_password

app = Flask(__name__)
CORS(app, supports_credentials=True)


@app.route("/")
def first_cry():
    return jsonify({"code": 1})


def random_char():
    """
    获取随机25个字符的字符串
    :return: 字符串
    """
    ran_str = ''.join(random.sample(string.ascii_letters + string.digits, 25))  # 获取随机25个字符
    return ran_str


def new_token():
    """
    获取一个不重复的token
    :return: token
    """
    db = Database()
    token = random_char()
    check = db.get({'token': token}, 'users')  # 检查token是否可用
    if check:
        return new_token()  # 递归调用
    return token


@app.route('/api/account/login', methods=['POST'])
def login():
    """
        用户登录
        :return: code(0=未知用户，-1=token初始化失败，1=成功)
        """
    username = request.form['username']
    password = request.form['password']
    db = Database()
    user = db.get({'email': username, 'password': generate_password(password)}, 'users')
    if user:

        result = db.update({'email': username, 'password': generate_password(password)},
                           {'token': new_token()},
                           'users')  # 更新token
        if result:
            return jsonify(
                {'code': 1, 'msg': 'success', 'data': {'token': result['token'], 'group': result['usergroup']}})
        return jsonify({'code': -1, 'msg': 'unable to update token'})  # 失败返回
    return jsonify({'code': 0, 'msg': 'unexpected user'})  # 失败返回


@app.route('/api/account/register', methods=['POST'])
def register():
    email = request.form['email']
    password = request.form['password']
    db = Database()
    check_email = db.get({'email': email}, 'users')
    if not check_email:
        flag = db.insert({
            'email': email,
            'password': generate_password(password)
        }, 'users')
        if flag:
            return jsonify({'code': 1, 'msg': 'success'})  # 成功返回
    return jsonify({'code': -1, 'msg': 'user has already exist'})  # 未知错误


if __name__ == '__main__':
    # 开启调试模式，修改代码后不需要重新启动服务即可生效
    # 请勿在生产环境下使用调试模式
    # Flask服务将默认运行在localhost的5000端口上

    # with open('static\\upload\\36.txt', 'rb') as file:
    #     result = pred(file.read())
    #     print(result[0])
    app.run(debug=True)
