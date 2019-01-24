import os
import random
import re
import string
import time

from CF.cf import item_cf
from API.OCR import ocr
from flask import Flask, jsonify, request
from flask_cors import CORS
from werkzeug.utils import secure_filename

from API.db import Database, generate_password

from API.utils import *

app = Flask(__name__)
CORS(app, supports_credentials=True)

"""
    常量区
"""
USER_GROUP = ['管理员', '从业者', '专家', '企业', '封禁', '待审核专家', '待审核企业']
LEVEL_EXP = [100, 1000, 10000]


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


"""
    用户接口
"""


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
        data = {
            'user_id': user['userID'],
            'head_portrait': user['headportrait'],
            'group': get_group(user['usergroup']),
            'nickname': user['nickname'],
            'level': get_level(user['exp']),
            'exp': {'value': user['exp'], 'percent': user['exp'] / LEVEL_EXP[get_level(user['exp'])] * 100},
            'answer': db.count({'userID': user['userID']}, 'answers'),
            'follow': db.count({'userID': user['userID']}, 'followuser'),
            'fans': db.count({'target': user['userID']}, 'followuser')
        }
        result = db.update({'email': username, 'password': generate_password(password)},
                           {'token': new_token()},
                           'users')  # 更新token
        if result:
            return jsonify(
                {'code': 1, 'msg': 'success', 'data': {'token': result['token'], 'data': data}})
        return jsonify({'code': -1, 'msg': 'unable to update token'})  # 失败返回
    return jsonify({'code': 0, 'msg': 'unexpected user'})  # 失败返回


@app.route('/api/account/register', methods=['POST'])
def register():
    """
    注册
    :return: code(-1=用户已存在，1=成功)
    """
    email = request.form['email']
    password = request.form['password']
    db = Database()
    email_check = db.get({'email': email}, 'users')
    if not email_check:
        flag = db.insert({
            'email': email,
            'password': generate_password(password)
        }, 'users')
        if flag:
            return jsonify({'code': 1, 'msg': 'success'})  # 成功返回
    return jsonify({'code': -1, 'msg': 'user has already exist'})  # 未知错误


@app.route('/api/account/check_email')
def check_email():
    """
    检测邮箱是否被注册
    :return: code(0=已经被注册，1=还未被注册)
    """
    email = request.values.get('email')
    db = Database()
    user = db.get({'email': email}, 'users')
    if user:
        return jsonify({'code': 0, 'msg': "the email had been registered"})
    else:
        return jsonify({'code': 1, 'msg': "the email can be registered"})


@app.route('/api/account/get_user')
def get_user():
    """
    根据user_id获取用户信息
    :return: code(0=未知用户，1=成功)
    """
    user_id = request.values.get('user_id')
    db = Database()
    user = db.get({'userID': user_id}, 'users')
    if user:
        data = {
            'user_id': user_id,
            'head_portrait': user['headportrait'],
            'user_group': user['usergroup'],
            'exp': user['exp'],
            'nickname': user['nickname']
        }
        return jsonify({'code': 1, 'msg': 'success', 'data': data})
    return jsonify({'code': 0, 'msg': 'unexpected user'})


@app.route('/api/account/get_user_by_token')
def get_user_by_token():
    """
    根据token获取用户信息
    :return:code(0=未知用户，1=成功)
    """
    token = request.values.get('token')
    db = Database()
    user = db.get({'token': token}, 'users')
    if user:
        data = {
            'user_id': user['userID'],
            'head_portrait': user['headportrait'],
            'group': get_group(user['usergroup']),
            'nickname': user['nickname'],
            'level': get_level(user['exp']),
            'exp': {'value': user['exp'], 'percent': user['exp'] / LEVEL_EXP[get_level(user['exp'])] * 100},
            'answer': db.count({'userID': user['userID']}, 'answers'),
            'follow': db.count({'userID': user['userID']}, 'followuser'),
            'fans': db.count({'target': user['userID']}, 'followuser')
        }
        return jsonify({'code': 1, 'msg': 'success', 'data': data})
    return jsonify({'code': 0, 'msg': 'unexpected user'})


def get_level(exp):
    i = 0
    while i < len(LEVEL_EXP):
        if LEVEL_EXP[i] > exp:
            return i
        i = i + 1
    return len(LEVEL_EXP)


def get_group(group):
    if group < len(USER_GROUP):
        return {'text': USER_GROUP[group], 'value': group}
    return {'text': '未知', 'value': group}


@app.route('/api/account/add_user_action')
def add_user_action():
    """
    添加用户行为
    :return: code(0=未知用户，-1=无法写入，1=成功)
    """
    token = request.values.get('token')
    action_type = request.values.get('action_type')
    target_id = request.values.get('target_id')
    db = Database()
    user = db.get({'token': token}, 'users')
    if user:
        flag = db.insert({'userID': user['userID'], 'targettype': action_type, 'targetID': target_id}, 'useraction')
        if flag:
            return jsonify({'code': 1, 'msg': 'success'})
        return jsonify({'code': -1, 'msg': 'unable to insert'})
    return jsonify({'code': 0, 'msg': 'unexpected user'})


@app.route('/api/account/follow_user')
def follow_user():
    """
    关注某个用户
    :return: code:-1 = 用户不存在, -2 = 被关注用户不存在, 0 = 关注失败, 1 = 关注成功
    """
    user_id = request.values.get('user_id')
    be_followed_user_id = request.values.get('followed_user_id')

    db = Database()
    user = db.get({'userID': user_id}, 'users')
    followed_user = db.get({'userID': be_followed_user_id}, 'users')

    if not user:
        return jsonify({'code': -1, 'msg': 'the user is not exist'})
    if not followed_user:
        return jsonify({'code': -1, 'msg': 'the followed_user is not exist'})

    success = db.insert({'userID': user_id, 'target': be_followed_user_id}, 'followuser')
    if success:
        return jsonify({'code': 1, 'msg': 'follow success'})
    else:
        return jsonify({'code': 0, 'msg': 'there are something wrong when inserted the data into database'})


def set_user_action(user_id, target, action_type):
    """
    设置用户行为
    :param user_id:用户id
    :param target: 目标id
    :param action_type: 行为种类
    :return: Boolean
    """
    db = Database()
    flag = db.insert({'userID': user_id, 'targetID': target, 'targettype': action_type}, 'useraction')
    if flag:
        return True
    return False


@app.route('/api/account/verify', methods=['POST'])
def verify():
    """
    实名认证
    :return:
    """
    token = request.form['token']
    user_id = request.form['user_id']
    real_name = request.form['real_name']
    birthday = request.form['birthday']
    gender = request.form['gender']
    number = request.form['number']
    address = request.form['address']
    nationality = request.form['nationality']
    db = Database()
    user = db.get({'token': token, 'usergroup': 0}, 'users')
    if user:
        flag = db.update({'userID': user_id}, {
            'real_name': real_name,
            'birthday': birthday,
            'gender': gender,
            'number': number,
            'address': address,
            'nationality': nationality,
            'state': 2
        }, 'users')
        set_user_action(user['userID'], user_id, 26)
        set_sys_message(user['userID'], 2, '你的实名认证申请已通过！', user_id)
        if flag:
            return jsonify({'code': 1, 'msg': 'success'})
        return jsonify({'code': -1, 'msg': 'unable to update'})
    return jsonify({'code': 0, 'msg': 'unexpected user'})


@app.route('/api/account/not_verify', methods=['POST'])
def not_verify():
    """
    实名认证不通过
    :return:
    """
    token = request.form['token']
    user_id = request.form['user_id']
    db = Database()
    user = db.get({'token': token, 'usergroup': 0}, 'users')
    if user:
        flag = db.update({'userID': user_id}, {
            'real_name': '',
            'birthday': '',
            'gender': '',
            'number': '',
            'address': '',
            'nationality': '',
            'state': 3
        }, 'users')
        set_user_action(user['userID'], user_id, 27)
        set_sys_message(user['userID'], 2, '你的实名认证申请未通过！', user_id)
        if flag:
            return jsonify({'code': 1, 'msg': 'success'})
        return jsonify({'code': -1, 'msg': 'unable to update'})
    return jsonify({'code': 0, 'msg': 'unexpected user'})


@app.route('/api/account/get_exp_change')
def get_exp_change():
    """
    获取积分变动详情
    :return: code(0=未知用户，1=成功)
    """
    token = request.values.get('token')
    db = Database()
    user = db.get({'token': token}, 'users')
    if user:
        exp_list = db.get({'userID': user['userID']}, 'exp_change')
        sorted(exp_list, key=lambda x: x['time'], reverse=True)
        return jsonify({'code': 1, 'msg': 'success', 'data': exp_list})
    return jsonify({'code': 0, 'msg': 'unexpected user'})


@app.route('/api/account/set_exp_change')
def set_exp_change():
    """
    设置积分变动
    :return: code(0=未知用户，-1=更新失败，1=成功)
    """
    token = request.values.get('token')
    value = request.values.get('value')
    description = request.values.get('description')
    db = Database()
    user = db.get({'token': token}, 'users')
    if user:
        flag = db.update({'token': token}, {'exp': user['exp'] + value}, 'users')
        flag2 = db.insert({'value': value, 'userID': user['userID'], 'description': description}, 'exp_change')
        if flag and flag2:
            return jsonify({'code': 1, 'msg': 'success'})
        return jsonify({'code': -1, 'msg': 'unable to insert'})
    return jsonify({'code': 0, 'msg': 'unexpected user'})


@app.route('/api/account/back_get_users')
def back_get_users():
    """
    获取所有用户列表
    :return:
    """
    token = request.headers.get('X-Token')
    db = Database()
    user = db.get({'token': token, 'usergroup': 0}, 'users')
    if user:
        users = db.get({}, 'users')
        for value in users:
            value.update({
                'group': get_group(value['usergroup']),
                'level': get_level(value['exp']),
                'exp': {'value': value['exp'], 'percent': value['exp'] / LEVEL_EXP[get_level(value['exp'])] * 100},
                'answer': db.count({'userID': value['userID']}, 'answers'),
                'follow': db.count({'userID': value['userID']}, 'followuser'),
                'fans': db.count({'target': value['userID']}, 'followuser')
            })
        return jsonify({'code': 1, 'msg': 'success', 'data': users})
    return jsonify({'code': 0, 'msg': 'unexpected user'})


@app.route('/api/account/back_get_normal_users')
def back_get_normal_users():
    """
    获取一般从业者账户
    :return:code(0=未知用户，1=成功)
    """
    token = request.headers.get('X-Token')
    db = Database()
    user = db.get({'token': token, 'usergroup': 0}, 'users')
    if user:
        users = db.get({'usergroup': 1}, 'users')
        wait = []
        confirm = []
        refuse = []
        un_identity = []
        banned = db.get({'usergroup': 4}, 'users')
        for value in users + banned:
            value.update({
                'group': get_group(value['usergroup']),
                'level': get_level(value['exp']),
                'exp': {'value': value['exp'], 'percent': value['exp'] / LEVEL_EXP[get_level(value['exp'])] * 100},
                'answer': db.count({'userID': value['userID']}, 'answers'),
                'follow': db.count({'userID': value['userID']}, 'followuser'),
                'fans': db.count({'target': value['userID']}, 'followuser')
            })
            if value['state'] == 0:
                un_identity.append(value)
            elif value['state'] == 1:
                wait.append(value)
            elif value['state'] == 2:
                confirm.append(value)
            elif value['state'] == 3:
                refuse.append(value)
            else:
                pass
        return jsonify({'code': 1, 'msg': 'success',
                        'data': {'all': users, 'un_identity': un_identity, 'confirm': confirm, 'refuse': refuse,
                                 'banned': banned}})
    return jsonify({'code': 0, 'msg': 'unexpected user'})


@app.route('/api/account/back_get_specialist_users')
def back_get_specialist_users():
    """
    获取一般从业者账户
    :return:code(0=未知用户，1=成功)
    """
    token = request.headers.get('X-Token')
    db = Database()
    user = db.get({'token': token, 'usergroup': 0}, 'users')
    if user:
        confirm = db.get({'usergroup': 1}, 'users')
        wait = db.get({'usergroup': 5}, 'users')
        for value in confirm + wait:
            value.update({
                'group': get_group(value['usergroup']),
                'level': get_level(value['exp']),
                'exp': {'value': value['exp'], 'percent': value['exp'] / LEVEL_EXP[get_level(value['exp'])] * 100},
                'answer': db.count({'userID': value['userID']}, 'answers'),
                'follow': db.count({'userID': value['userID']}, 'followuser'),
                'fans': db.count({'target': value['userID']}, 'followuser')
            })

        return jsonify({'code': 1, 'msg': 'success',
                        'data': {'all': confirm + wait, 'wait': wait, 'confirm': confirm}})
    return jsonify({'code': 0, 'msg': 'unexpected user'})


@app.route('/api/account/back_get_enterprise_users')
def back_get_enterprise_users():
    """
    获取一般从业者账户
    :return:code(0=未知用户，1=成功)
    """
    token = request.headers.get('X-Token')
    db = Database()
    user = db.get({'token': token, 'usergroup': 0}, 'users')
    if user:
        confirm = db.get({'usergroup': 2}, 'users')
        wait = db.get({'usergroup': 6}, 'users')
        for value in confirm + wait:
            value.update({
                'group': get_group(value['usergroup']),
                'level': get_level(value['exp']),
                'exp': {'value': value['exp'], 'percent': value['exp'] / LEVEL_EXP[get_level(value['exp'])] * 100},
                'answer': db.count({'userID': value['userID']}, 'answers'),
                'follow': db.count({'userID': value['userID']}, 'followuser'),
                'fans': db.count({'target': value['userID']}, 'followuser')
            })

        return jsonify({'code': 1, 'msg': 'success',
                        'data': {'all': confirm + wait, 'wait': wait, 'confirm': confirm}})
    return jsonify({'code': 0, 'msg': 'unexpected user'})


@app.route('/api/account/confirm_specialist')
def confirm_specialist():
    """
    确认专家身份
    :return:
    """
    token = request.headers.get('X-Token')
    db = Database()
    user = db.get({'token': token, 'usergroup': 0}, 'users')
    if user:
        user_id = request.values.get('user_id')
        specialist = db.get({'userID': user_id, 'usergroup': 5}, 'users')
        if specialist:
            flag = db.update({'userID': user_id}, {'usergroup': 2}, 'users')
            set_user_action(user['userID'], user_id, 28)
            set_sys_message(user['userID'], 2, '你的专家认证申请已通过！', user_id)
            if flag:
                return jsonify({'code': 1, 'msg': 'success'})
            return jsonify({'code': -1, 'msg': 'unable to upgrade'})
        return jsonify({'code': -2, 'msg': 'unexpected specialist'})
    return jsonify({'code': 0, 'msg': 'unexpected user'})


@app.route('/api/account/refuse_specialist')
def refuse_specialist():
    """
    确认专家身份
    :return:
    """
    token = request.headers.get('X-Token')
    db = Database()
    user = db.get({'token': token, 'usergroup': 0}, 'users')
    if user:
        user_id = request.values.get('user_id')
        specialist = db.get({'userID': user_id, 'usergroup': 5}, 'users')
        if specialist:
            flag = db.update({'userID': user_id}, {'usergroup': 1}, 'users')
            set_user_action(user['userID'], user_id, 29)
            set_sys_message(user['userID'], 2, '你的专家认证申请未通过！', user_id)
            if flag:
                return jsonify({'code': 1, 'msg': 'success'})
            return jsonify({'code': -1, 'msg': 'unable to upgrade'})
        return jsonify({'code': -2, 'msg': 'unexpected specialist'})
    return jsonify({'code': 0, 'msg': 'unexpected user'})


@app.route('/api/account/confirm_enterprise')
def confirm_enterprise():
    """
    确认企业身份
    :return:
    """
    token = request.headers.get('X-Token')
    db = Database()
    user = db.get({'token': token, 'usergroup': 0}, 'users')
    if user:
        user_id = request.values.get('user_id')
        specialist = db.get({'userID': user_id, 'usergroup': 6}, 'users')
        if specialist:
            flag = db.update({'userID': user_id}, {'usergroup': 3}, 'users')
            set_user_action(user['userID'], user_id, 30)
            set_sys_message(user['userID'], 2, '你的企业认证申请已通过！', user_id)
            if flag:
                return jsonify({'code': 1, 'msg': 'success'})
            return jsonify({'code': -1, 'msg': 'unable to upgrade'})
        return jsonify({'code': -2, 'msg': 'unexpected enterprise'})
    return jsonify({'code': 0, 'msg': 'unexpected user'})


@app.route('/api/account/refuse_enterprise')
def refuse_enterprise():
    """
    确认企业身份
    :return:
    """
    token = request.headers.get('X-Token')
    db = Database()
    user = db.get({'token': token, 'usergroup': 0}, 'users')
    if user:
        user_id = request.values.get('user_id')
        specialist = db.get({'userID': user_id, 'usergroup': 6}, 'users')
        if specialist:
            flag = db.update({'userID': user_id}, {'usergroup': 1}, 'users')
            set_user_action(user['userID'], user_id, 31)
            set_sys_message(user['userID'], 2, '你的企业认证申请未通过！', user_id)
            if flag:
                return jsonify({'code': 1, 'msg': 'success'})
            return jsonify({'code': -1, 'msg': 'unable to upgrade'})
        return jsonify({'code': -2, 'msg': 'unexpected enterprise'})
    return jsonify({'code': 0, 'msg': 'unexpected user'})


@app.route('/api/account/delete_user')
def delete_user():
    """
    清除用户
    :return:
    """
    token = request.values.get('token')
    db = Database()
    user = db.get({'token': token, 'usergroup': 0}, 'users')
    if user:
        user_id = request.values.get('user_id')
        flag = db.update({'userID': user_id}, {'usergroup': 4}, 'users')
        set_user_action(user['userID'], user_id, 32)
        set_sys_message(user['userID'], 2, '你已被管理员封禁！', user_id)
        if flag:
            return jsonify({'code': 1, 'msg': 'success'})
        return jsonify({'code': -1, 'msg': 'unable to delete'})
    return jsonify({'code': 0, 'msg': 'unexpected user'})


@app.route('/api/account/change_user', methods=['POST'])
def change_user():
    """
    修改用户信息
    :return:
    """
    token = request.form['token']
    db = Database()
    user = db.get({'token': token, 'usergroup': 0}, 'users')
    if user:
        user_id = request.form['user_id']
        nickname = request.form['nickname']
        headportrait = request.form['headportrait']
        usergroup = request.form['usergroup']
        exp = request.form['exp']
        update = {
            'nickname': nickname,
            'headportrait': headportrait,
            'usergroup': usergroup,
            'exp': exp
        }
        flag = db.update({'userID': user_id}, update, 'users')
        if flag:
            return jsonify({'code': 1, 'msg': 'success'})
        return jsonify({'code': -1, 'msg': 'unable to delete'})
    return jsonify({'code': 0, 'msg': 'unexpected user'})


@app.route('/api/account/get_account_balance', methods=['POST'])
def get_account_balance():
    """
    获取用户的钱包余额
    :return: code:0=用户不存在  1=获取成功
    """
    token = request.form['token']
    db = Database()
    user = db.get({'token': token}, 'users')
    if user:
        return jsonify({'code': 1, 'msg': 'success', 'data': user['account_balance']})
    return jsonify({'code': 0, 'msg': 'the user is not exist'})


@app.route('/api/account/add_account_balance', methods=['POST'])
def add_account_balance():
    """
    增加用户的钱包余额
    :return:code:0=数据库操作失败  1=增加成功  -2=用户不存在
    """
    # 要增加的量
    num = request.form['num']
    token = request.form['token']
    res = change_account_balance(num, token)
    if res == 1:
        return jsonify({'code': 1, 'msg': 'success'})
    elif res == 0:
        return jsonify({'code': 0, 'msg': 'there are something wrong when operate the database'})
    elif res == -2:
        return jsonify({'code': -2, 'msg': 'the user is not exist'})


@app.route('/api/account/minus_account_balance', methods=['POST'])
def minus_account_balance():
    """
    减少用户的钱包余额
    :return:code:-2=用户不存在  -1=余额不足  0=数据库操作失败  1=成功
    """
    # 要减少的量
    num = request.form['num']
    # 减少的量在计算时应该为负数
    num = -num
    token = request.form['token']
    res = change_account_balance(num, token)
    if res == 1:
        return jsonify({'code': 1, 'msg': 'success'})
    elif res == 0:
        return jsonify({'code': 0, 'msg': 'there are something wrong when operate the database'})
    elif res == -2:
        return jsonify({'code': -2, 'msg': 'the user is not exist'})
    elif res == -1:
        return jsonify({'code': -1, 'msg': 'account balance not enough'})


@app.route('/api/account/history_pay', methods=['POST'])
def history_pay():
    """
    获取用户的支付记录
    :return: code: 0=用户不存在 1=成功
    """
    token = request.form['token']
    db = Database()
    user = db.get({'token': token}, 'users')
    if not user:
        return jsonify({'code': -1, 'msg': 'the user is not exist'})

    log = db.get({'from': user['userID']}, 'pay_log')
    return jsonify({'code': 1, 'msg': 'success', 'data': log})


def change_account_balance(num, token):
    """
    增加或减少余额值
    :param num: 改变量
    :param token: 用户token
    :return: code:-2=用户不存在  -1=余额不足  0=数据库操作失败  1=改变成功
    """
    db = Database()
    user = db.get({'token': token}, 'users')
    if user:
        # 若num为负数，钱包可能被扣到负值
        if user['account_balance'] + num < 0:
            return -1
        flag = db.update({'userID': user['user_id']}, {'account_balance': user['account_balance'] + num}, 'users')
        if flag:
            return 1
        return 0
    return -2


"""
    问题接口
"""


@app.route('/api/questions/add_question', methods=['POST'])
def add_question():
    """
    添加问题
    :return:code(0=未知用户，-1=无法添加问题，1=成功)
    """
    token = request.form['token']
    title = request.form['title']
    description = request.form['description']
    tags = request.form['tags']
    db = Database()
    user = db.get({'token': token}, 'users')
    if user:
        flag = db.insert({'title': title, 'description': description, 'userID': user['userID'], 'tags': tags},
                         'questions')
        if flag:
            return jsonify({'code': 1, 'msg': 'success'})
        return jsonify({'code': -1, 'msg': 'unable to insert question'})
    return jsonify({'code': 0, 'msg': 'unexpected user'})


@app.route('/api/questions/add_priced_question', methods=['POST'])
def add_priced_question():
    """
    添加付费问题
    :return:code(-2=用户不存在  -1=余额不足  0=数据库操作失败  1=成功)
    """
    token = request.form['token']
    price = request.form['price']
    db = Database()
    res = change_account_balance(int(price), token)
    if res == 1:
        user = db.get({'token': token}, 'users')
        if user:
            title = request.form['title']
            description = request.form['description']
            tags = request.form['tags']
            allowed_user = request.form['allowed_user']
            flag = db.insert({'title': title, 'description': description, 'userID': user['userID'], 'tags': tags,
                              'allowed_user': allowed_user, 'question_type': 1},
                             'questions')
            if flag:
                return jsonify({'code': 1, 'msg': 'success'})
            change_account_balance(-int(price), token)
            return jsonify({'code': 0, 'msg': 'there are something wrong when operate the database'})
        return jsonify({'code': -2, 'msg': 'the user is not exist'})
    elif res == 0:
        return jsonify({'code': 0, 'msg': 'there are something wrong when operate the database'})
    elif res == -2:
        return jsonify({'code': -2, 'msg': 'the user is not exist'})
    elif res == -1:
        return jsonify({'code': -1, 'msg': 'account balance not enough'})


@app.route('/api/questions/adopt_answer')
def adopt_answer():
    """
    针对付费问题采纳回答
    :return: code(0=未知用户，-4=不能找到回答，-3=不能找到问题，-2=未知答题人，-1=无法写入，1=成功)
    """
    token = request.values.get('token')
    db = Database()
    user = db.get({'token': token}, 'users')
    if user:
        answer_id = request.values.get('answer_id')
        answer = db.get({'answerID': answer_id}, 'answers')
        if answer:
            question = db.get({'questionID': answer['questionID']}, 'questions')
            if question:
                if question['userID'] == user['userID']:
                    flag = db.get({'userID': answer['userID']}, 'users')
                    if flag:
                        flag1 = db.update({'userID': answer['userID']},
                                          {'account_balance': int(flag['account_balance']) + int(question['price'])},
                                          'users')
                        flag2 = db.update({'answerID': answer['answerID']}, {'answerType': 2}, 'answers')
                        if flag1 and flag2:
                            return jsonify({'code': 1, 'msg': 'success'})
                        return jsonify({'code': -1, 'msg': 'unable to update'})
                    return jsonify({'code': -2, 'msg': 'unexpected answer user'})
                return jsonify({'code': 0, 'msg': 'unexpected user'})
            return jsonify({'code': -3, 'msg': 'cannot find question'})
        return jsonify({'code': -4, 'msg': 'cannot find answer'})
    return jsonify({'code': 0, 'msg': 'unexpected user'})


@app.route('/api/questions/get_questions')
def get_questions():
    """
    获取问题
    :return:code(0=未知用户，-1=无法添加问题，1=成功)
    """
    db = Database()
    data = db.get({'state': 0}, 'questionsinfo')
    return jsonify({'code': 0, 'msg': '', 'data': data})


@app.route('/api/questions/get_question')
def get_question():
    """
    通过id获取问题
    :return: code(0=未知问题，-1=未知提问人，1=成功)
    """
    question_id = request.values.get('question_id')
    db = Database()
    question = db.get({'questionID': question_id, 'state': 0}, 'questions')
    if question:
        user = db.get({'userID': question['userID']}, 'users')
        if user:
            data = {
                'question_id': question_id,
                'user_id': question['userID'],
                'user_nickname': user['nickname'],
                'user_headportrait': user['headportrait'],
                'title': question['title'],
                'description': question['description'],
                'tags': question['tags'],
                'question_type': question['question_type']
            }
            return jsonify({'code': 1, 'msg': 'success', 'data': data})
        return jsonify({'code': -1, 'msg': 'unknown user'})
    return jsonify({'code': 0, 'msg': 'unknown question'})


@app.route('/api/questions/follow_question')
def follow_question():
    """
    关注某个问题
    :return: code:-1 = 问题不存在, -2 = 用户不存在, 0 = 关注失败, 1 = 关注成功
    """
    user_id = request.values.get('user_id')
    question_id = request.values.get('question_id')

    db = Database()
    user = db.get({'userID': user_id}, 'users')
    question = db.get({'questionID': question_id}, 'questions')

    if not question:
        return jsonify({'code': -1, 'msg': "the question is not exist"})
    if not user:
        return jsonify({'code': -2, 'msg': "the user is not exist"})

    success = db.insert({'userID': user_id, 'target': question_id}, 'followtopic')
    if success:
        return jsonify({'code': 1, 'msg': "follow success"})
    else:
        return jsonify({'code': 0, 'msg': "there are something wrong when inserted the data into database"})


@app.route('/api/questions/get_answer_list')
def get_answer_list():
    """
    根据问题id获取回答列表（倒序）
    :return: code(0=未知问题，1=成功)
    """
    question_id = request.args.get('question_id', type=str)
    db = Database()
    question = db.get({'questionID': question_id}, 'questions')
    if question:
        # answer_list = db.get({'questionID': question_id}, 'answers', 0)
        answer_list = db.get({'questionID': question_id}, 'answersinfo', 0)
        for answer in answer_list:
            answer['edittime'] = get_formative_datetime(answer['edittime'])
        return jsonify({'code': 1, 'msg': 'success', 'data': answer_list})
    return jsonify({'code': 0, 'msg': 'unknown question'})


@app.route('/api/questions/get_priced_answer_list')
def get_priced_answer_list():
    """
    获取付费问题的回答
    :return: code:-2=问题不存在  -1=用户不存在  0=未付费  1=成功
    """
    # 获取问题ID和用户ID
    question_id = request.values.get('question_id')
    user_token = request.values.get('token')
    # 获取问题和用户信息
    db = Database()
    question = db.get({'questionID': question_id, 'question_type': 1}, 'questions')
    user = db.get({'token': user_token}, 'users')
    # 检查用户和问题是否存在
    if not question:
        return jsonify({'code': -2, 'msg': 'the question is not exist'})
    if not user:
        return jsonify({'code': -1, 'msg': 'the user is not exist'})

    user_id = user['userID']
    # 获取该问题,由该用户付费的记录
    payer = db.get({'receive': question_id, 'from': user_id, 'type': 1}, 'pay_log')
    # 获取是否为作者本人
    is_author = (user_id == question['userID'])

    # 已支付的或者提问者本人可以直接查看问题下的答案
    if payer or is_author:
        answers = db.get({'questionID': question_id}, 'answers')
        return jsonify({'code': 1, 'msg': 'success', 'data': answers})
    # 未支付用户则无权限获取答案
    return jsonify({'code': 0, 'msg': 'the user have not paid this question'})


@app.route('/api/questions/pay_question')
def pay_question():
    """
    支付某一付费问题
    :return: code:-5=退钱失败  -4=创建支付记录失败  -3=问题不存在  -2=用户不存在  -1=余额不足  0=支付失败  1=成功
    """
    # 获取问题ID和用户ID
    question_id = request.values.get('question_id')
    user_token = request.values.get('token')
    # 获取问题和用户信息
    db = Database()
    question = db.get({'questionID': question_id}, 'questions')
    user = db.get({'token': user_token}, 'users')
    # 检查用户和问题是否存在
    if not question:
        return jsonify({'code': -3, 'msg': 'the question is not exist'})
    if not user:
        return jsonify({'code': -2, 'msg': 'the user is not exist'})

    # 试图扣钱,将价格取负数
    result = change_account_balance(-question['price'], user_token)
    # 余额不足，提示
    if result == -1:
        return jsonify({'code': -1, 'msg': 'account balance not enough'})
    # 支付的扣钱操作失败时，提示
    elif result == 0:
        return jsonify({'code': 0, 'msg': 'there are something wrong when paying'})
    # 支付成功，生成支付记录
    elif result == 1:
        res = db.insert({'from': user['userID'], 'receive': question_id, 'amount': question['price'], 'type': 1})
        if not res:
            # 若创建支付记录失败，视为支付失败，将钱退还
            return_money = change_account_balance(question['price'], user_token)
            # 若退还失败，提示与客服沟通取钱
            if return_money != 1:
                jsonify({'code': -5, 'msg': 'create the pay_log fail,please call 客服 to get your money back'})
            # 退还成功，提示支付记录创建失败，未能完成支付
            return jsonify({'code': -4, 'msg': 'paying fail,there are something wrong when create the pay_log'})
        # 支付成功
        return jsonify({'code': 1, 'msg': 'success'})


@app.route('/api/questions/add_question_comment', methods=['POST'])
def add_question_comment():
    """
    添加评论
    :return:code(0=未知用户，-1=未知问题，-2=无法添加评论，1=成功)
    """
    question_id = request.form['question_id']
    content = request.form['content']
    token = request.form['token']
    db = Database()
    user = db.get({'token': token}, 'users')
    if user:
        answer = db.get({'questionID': question_id}, 'questions')
        if answer:
            flag = db.insert({'userID': user['userID'], 'content': content, 'questionID': question_id},
                             'questioncomments')
            if flag:
                return jsonify({'code': 1, 'msg': 'success'})
            return jsonify({'code': -2, 'msg': 'unable to insert comment'})
        return jsonify({'code': -1, 'msg': 'unable to find question'})
    return jsonify({'code': 0, 'msg': 'unexpected user'})


@app.route('/api/questions/get_question_comment')
def get_question_comment():
    """
    获取问题评论
    :return: code(0=未知问题，1=成功)
    """
    question_id = request.values.get('question_id')
    db = Database()
    question = db.get({'questionID': question_id}, 'questions')
    if question:
        data = db.get({'questionID': question_id}, 'question_comments_info', 0)
        return jsonify({'code': 1, 'msg': 'success', 'data': data})
    return jsonify({'code': 0, 'msg': 'unknown question'})


@app.route('/api/questions/agree_question_comment')
def agree_question_comment():
    """
    对特定评论点赞
    :return: code(0=未知用户，-1=未知评论，-2=不能记录用户行为，-3=不能更新点赞数，1=成功)
    """
    comment_id = request.values.get('comment_id')
    token = request.values.get('token')
    db = Database()
    user = db.get({'token': token}, 'users')
    if user:
        answer = db.get({'qcommentID': comment_id}, 'questioncomments')
        if answer:
            result = db.update({'qcommentID': comment_id}, {'agree': int(answer['agree']) + 1}, 'questioncomments')
            flag = db.insert({'userID': user['userID'], 'targetID': comment_id, 'targettype': 5}, 'useraction')
            if result and flag:
                return jsonify({'code': 1, 'msg': 'success'})
            if result:
                return jsonify({'code': -2, 'msg': 'unable to insert user action'})
            if flag:
                return jsonify({'code': -3, 'msg': 'unable to update agree number'})
        return jsonify({'code': -1, 'msg': 'unknown comment'})
    return jsonify({'code': 0, 'msg': 'unexpected user'})


@app.route('/api/questions/back_get_questions')
def back_get_questions():
    """
    后台用查看所有问题
    :return:
    """
    token = request.values.get('token')
    db = Database()
    user = db.get({'token': token, 'usergroup': 0}, 'users')
    if user:
        questions = db.get({}, 'questionsinfo')
        data = []
        for value in questions:
            data.append({
                'questionID': value['questionID'],
                'description': value['description'],
                'title': value['title'],
                'edittime': value['edittime'],
                'userID': value['userID'],
                'tags': get_tags(value['tags']),
                'nickname': value['nickname'],
                'state': value['state']
            })
        return jsonify({'code': 1, 'msg': 'success', 'data': data})
    return jsonify({'code': 0, 'msg': 'unexpected user'})


@app.route('/api/questions/delete_question')
def delete_question():
    """
    清除问题
    :return:
    """
    token = request.values.get('token')
    question_id = request.values.get('question_id')
    db = Database()
    user = db.get({'token': token, 'usergroup': 0}, 'users')
    if user:
        flag = db.update({'questionID': question_id}, {'state': -1}, 'questions')
        if flag:
            set_user_action(user['userID'], question_id, 34)
            set_sys_message(user['userID'], 2, '您发布的问题 ' + flag['title'] + ' 已被管理员清除！', flag['userID'])
            return jsonify({'code': 1, 'msg': 'success'})
        return jsonify({'code': -1, 'msg': 'unable to delete'})
    return jsonify({'code': 0, 'msg': 'unexpected user'})


"""
    答案接口
"""


@app.route('/api/answer/add_answer', methods=['POST'])
def add_answer():
    """
    添加新的回答
    :return:code(0=未知用户，-1=未知问题，-2=无法添加回答，1=成功)
    """
    question_id = request.form['question_id']
    token = request.form['token']
    content = request.form['content']
    answer_type = request.form['answer_type']
    db = Database()
    user = db.get({'token': token}, 'users')
    if user:
        question = db.get({'questionID': question_id}, 'questions')
        if question:
            flag = db.insert(
                {'content': content, 'userID': user['userID'], 'questionID': question_id, 'answertype': answer_type},
                'answers')
            if flag:
                return jsonify({'code': 1, 'msg': 'success'})
            return jsonify({'code': -2, 'msg': 'unable to insert answer'})
        return jsonify({'code': -1, 'msg': 'unknown question'})
    return jsonify({'code': 0, 'msg': 'unexpected user'})


def get_tags(tags):
    """
    获取标签
    :param tags:字符串
    :return: 标签列表
    """
    tag_list = tags.split(',')
    db = Database()
    data = []
    for value in tag_list:
        tag = db.get({'id': value}, 'tags')
        if tag:
            data.append({'text': tag['name'], 'id': value})
    return data


@app.route('/api/answer/get_answer')
def get_answer():
    """
    获取特定id的回答
    :return:code(0=未知回答，1=成功)
    """
    answer_id = request.values.get('answer_id')
    db = Database()
    answer = db.get({'answerID': answer_id, 'state': 0}, 'answers')
    if answer:
        user = db.get({'userID': answer['userID']}, 'users')
        question = db.get({'questionID': answer['questionID']}, 'questions')
        if user:
            data = {
                'id': answer['answerID'],
                'user_id': answer['userID'],
                'user_nickname': user['nickname'],
                'user_headportrait': user['headportrait'],
                'content': answer['content'],
                'edit_time': get_formative_datetime(answer['edittime']),
                'agree': answer['agree'],
                'disagree': answer['disagree'],
                'answer_type': answer['answertype'],
                'question_id': answer['questionID'],
                'question_title': question['title'],
                'description': user['description'],
                'group': get_group(user['usergroup']),
                'tag': get_tags(answer['tags'])
            }
            return jsonify({'code': 1, 'msg': 'success', 'data': data})
        return jsonify({'code': -1, 'msg': 'unknown user'})
    return jsonify({'code': 0, 'msg': 'unknown answer'})


@app.route('/api/get_answer_comment_list')
def get_answer_comment_list():
    """
    获取评论列表（倒序）
    :return:code(0=未知回答，1=成功)
    """
    answer_id = request.values.get('answer_id')
    db = Database()
    answer = db.get({'answerID': answer_id}, 'answers')
    if answer:
        comment_list = db.get({'answerID': answer_id}, 'answercomments', 0)
        data = []
        for value in comment_list:
            user = db.get({'userID': value['userID']}, 'users')
            if user:
                data.append({
                    'user_id': value['userID'],
                    'user_nickname': user['nickname'],
                    'user_headportrait': user['headportrait'],
                    'content': value['content'],
                    'create_time': get_formative_datetime(value['createtime']),
                    'agree': value['agree']
                })
        sorted(data, key=lambda a: a['agree'], reverse=True)
        return jsonify({'code': 1, 'msg': 'success', 'data': data})
    return jsonify({'code': 0, 'msg': 'unknown answer'})


@app.route('/api/answer/collect_answer')
def collect_answer():
    """
    关注某个回答
    :return: code:-1 = 回答不存在, -2 = 用户不存在, 0 = 关注失败, 1 = 关注成功
    """
    user_id = request.values.get('user_id')
    answer_id = request.values.get('answer_id')

    db = Database()
    user = db.get({'userID': user_id}, 'users')
    answer = db.get({'answerID': answer_id}, 'answers')

    if not answer:
        return jsonify({'code': -1, 'msg': "the answer is not exist"})
    if not user:
        return jsonify({'code': -2, 'msg': "the user is not exist"})

    success = db.insert({'userID': user_id, 'answerID': answer_id}, 'collectanswer')
    if success:
        return jsonify({'code': 1, 'msg': "collect success"})
    else:
        return jsonify({'code': 0, 'msg': "there are something wrong when inserted the data into database"})


@app.route('/api/answer/edit_answer')
def edit_answer():
    """
    编辑回答
    :return: code:0 = 编辑失败  1 = 编辑成功  -1 = 回答不存在
    """
    answer_id = request.values.get('answer_id')
    content = request.values.get('content')
    # 获取当前时间
    time_stamp = time.time()
    time_array = time.localtime(time_stamp)
    newtime = time.strftime("%Y--%m--%d %H:%M:%S", time_array)

    db = Database()
    answer = db.get({'answerID': answer_id}, 'answers')
    if not answer:
        return jsonify({'code': -1, 'msg': "the answer is not exist"})

    success = db.update({'answerID': answer_id}, {'content': content, 'edittime': newtime}, 'answers')
    if success:
        return jsonify({'code': 1, 'msg': "edit success"})
    else:
        return jsonify({'code': 0, 'msg': "there are something wrong when edited the data in database"})


@app.route('/api/answer/add_answer_comment', methods=['POST'])
def add_answer_comment():
    """
    添加评论
    :return:code(0=未知用户，-1=未知回答，-2=无法添加评论，1=成功)
    """
    answer_id = request.form['answer_id']
    content = request.form['content']
    token = request.form['token']
    db = Database()
    user = db.get({'token': token}, 'users')
    if user:
        answer = db.get({'answerID': answer_id}, 'answers')
        if answer:
            flag = db.insert({'userID': user['userID'], 'content': content, 'answerID': answer_id}, 'answercomments')
            if flag:
                return jsonify({'code': 1, 'msg': 'success'})
            return jsonify({'code': -2, 'msg': 'unable to insert comment'})
        return jsonify({'code': -1, 'msg': 'unable to find answer'})
    return jsonify({'code': 0, 'msg': 'unexpected user'})


@app.route('/api/answer/agree_answer')
def agree_answer():
    """
    对特定答案点赞
    :return: code(0=未知用户，-1=未知答案，-2=不能记录用户行为，-3=不能更新点赞数，1=成功)
    """
    answer_id = request.values.get('answer_id')
    token = request.values.get('token')
    db = Database()
    user = db.get({'token': token}, 'users')
    if user:
        answer = db.get({'answerID': answer_id}, 'answers')
        if answer:
            result = db.update({'answerID': answer_id}, {'agree': int(answer['agree']) + 1}, 'answers')
            flag = db.insert({'userID': user['userID'], 'targetID': answer_id, 'targettype': 1}, 'useraction')
            if result and flag:
                return jsonify({'code': 1, 'msg': 'success'})
            if result:
                return jsonify({'code': -2, 'msg': 'unable to insert user action'})
            if flag:
                return jsonify({'code': -3, 'msg': 'unable to update agree number'})
        return jsonify({'code': -1, 'msg': 'unknown answer'})
    return jsonify({'code': 0, 'msg': 'unexpected user'})


@app.route('/api/answer/agree_answer_comment')
def agree_answer_comment():
    """
    对特定评论点赞
    :return: code(0=未知用户，-1=未知评论，-2=不能记录用户行为，-3=不能更新点赞数，1=成功)
    """
    comment_id = request.values.get('comment_id')
    token = request.values.get('token')
    db = Database()
    user = db.get({'token': token}, 'users')
    if user:
        answer = db.get({'acommentID': comment_id}, 'answercomments')
        if answer:
            result = db.update({'acommentID': comment_id}, {'agree': int(answer['agree']) + 1}, 'answercomments')
            flag = db.insert({'userID': user['userID'], 'targetID': comment_id, 'targettype': 3}, 'useraction')
            if result and flag:
                return jsonify({'code': 1, 'msg': 'success'})
            if result:
                return jsonify({'code': -2, 'msg': 'unable to insert user action'})
            if flag:
                return jsonify({'code': -3, 'msg': 'unable to update agree number'})
        return jsonify({'code': -1, 'msg': 'unknown comment'})
    return jsonify({'code': 0, 'msg': 'unexpected user'})


@app.route('/api/answer/complain')
def complain():
    """
    举报某一条评论
    :return:code(0=未知评论，1=举报成功)
    """
    pass
    # 由于页面未定，举报形式未定，暂时无法继续往下写


@app.route('/api/answer/disagree_answer')
def disagree_answer():
    """
        对特定答案点踩
        :return: code(0=未知用户，-1=未知答案，-2=不能记录用户行为，-3=不能更新点踩数，1=成功)
    """
    answer_id = request.values.get('answer_id')
    token = request.values.get('token')
    db = Database()
    user = db.get({'token': token}, 'users')
    if user:
        answer = db.get({'answerID': answer_id}, 'answers')
        if answer:
            result = db.update({'answerID': answer_id}, {'disagree': int(answer['disagree']) + 1}, 'answers')
            flag = db.insert({'userID': user['userID'], 'targetID': answer_id, 'targettype': 2}, 'useraction')
            if result and flag:
                return jsonify({'code': 1, 'msg': 'success'})
            if result:
                return jsonify({'code': -2, 'msg': 'unable to insert user action'})
            if flag:
                return jsonify({'code': -3, 'msg': 'unable to update agree number'})
        return jsonify({'code': -1, 'msg': 'unknown answer'})
    return jsonify({'code': 0, 'msg': 'unexpected user'})


@app.route('/api/answer/back_get_answers')
def back_get_answers():
    """
    后台获取所有回答
    :return:
    """
    token = request.values.get('token')
    db = Database()
    user = db.get({'token': token, 'usergroup': 0}, 'users')
    if user:
        answers = db.get({}, 'answersinfo')
        for value in answers:
            value.update({'tags': get_tags(value['tags'])})
        return jsonify({'code': 1, 'msg': 'success', 'data': answers})
    return jsonify({'code': 0, 'msg': 'unexpected user'})


@app.route('/api/answer/delete_answer')
def delete_answer():
    """
    清除答案
    :return:
    """
    token = request.values.get('token')
    db = Database()
    user = db.get({'token': token, 'usergroup': 0}, 'users')
    if user:
        answer_id = request.values.get('answer_id')
        flag = db.update({'answerID': answer_id}, {'state': -1}, 'answers')
        if flag:
            set_user_action(user['userID'], answer_id, 35)
            question = db.get({'questionID': flag['questionID']}, 'questions')
            if question:
                set_sys_message(user['userID'], 2, '您在 ' + question['title'] + ' 下的回答已被管理员清除！', flag['userID'])
            return jsonify({'code': 1, 'msg': 'success'})
        return jsonify({'code': -1, 'msg': 'unable to delete'})
    return jsonify({'code': 0, 'msg': 'unexpected user'})


"""
    文章接口
"""


@app.route('/api/article/add_article')
def add_article():
    """
    新建文章
    :return: code:-1=用户不存在 0=新建失败  1=新建成功
    """
    token = request.form['token']
    content = request.form["content"]
    title = request.form['title']

    db = Database()
    user = db.get({'token': token}, 'users')
    if not user:
        return jsonify({'code': -1, 'msg': 'the user is not exist'})

    success = db.insert({'content': content, 'userID': user['userID'], 'title': title}, 'article')
    if success:
        return jsonify({'code': 1, 'msg': 'add success'})
    else:
        return jsonify({'code': 0, 'msg': 'there are something wrong when inserted the data into database'})


@app.route('/api/article/edit_article', methods=['POST'])
def edit_article():
    """
    修改文章
    :return: code:-1=文章不存在 0=修改失败  1=修改成功
    """
    article_id = request.form["article_id"]
    content = request.form["content"]
    title = request.form['title']
    token = request.form['token']
    # 获取当前时间
    time_stamp = time.time()
    time_array = time.localtime(time_stamp)
    newtime = time.strftime("%Y--%m--%d %H:%M:%S", time_array)

    db = Database()
    article = db.get({'articleID': article_id}, 'article')
    user = db.get({'token': token}, 'users')
    if not article:
        return jsonify({'code': -1, 'msg': 'the article is not exist'})
    if not user:
        return jsonify({'code': 0, 'msg': 'unexpected user'})
    if article['userID'] != user['userID'] and user['usergroup'] != 0:
        return jsonify({'code': 0, 'msg': 'unexpected user'})
    success = db.update({'articleID': article_id}, {'content': content, 'edittime': newtime, 'title': title}, 'article')
    if success:
        return jsonify({'code': 1, 'msg': 'edit success'})
    else:
        return jsonify({'code': 0, 'msg': 'there are something wrong when inserted the data into database'})


@app.route('/api/article/collect_article')
def collect_article():
    """
    收藏一篇文章
    :return: code:0=收藏失败 1=收藏成功 -1=文章不存在 -2=用户不存在
    """
    article_id = request.values.get("article_id")
    user_id = request.values.get("user_id")

    db = Database()
    article = db.get({'articleID': article_id}, 'article')

    if not article:
        return jsonify({'code': -1, 'msg': 'the article is not exist'})
    if not article:
        return jsonify({'code': -2, 'msg': 'the user is not exist'})

    success = db.insert({'userID': user_id, 'articleID': article_id}, 'collectarticle')
    if success:
        return jsonify({'code': 1, 'msg': 'collect success'})
    else:
        return jsonify({'code': 0, 'msg': 'there are something wrong when inserted the data into database'})


@app.route('/api/article/back_get_articles')
def back_get_articles():
    """
    后台获取article列表
    :return:
    """
    token = request.values.get('token')
    db = Database()
    user = db.get({'token': token, 'usergroup': 0}, 'users')
    if user:
        article = db.get({}, 'articleinfo')
        for value in article:
            value.update({'tags': get_tags(value['tags'])})
        return jsonify({'code': 1, 'msg': 'success', 'data': article})
    return jsonify({'code': 0, 'msg': 'unexpected user'})


@app.route('/api/article/delete_article')
def delete_article():
    """
    清除文章
    :return:
    """
    token = request.values.get('token')
    article_id = request.values.get('article_id')
    db = Database()
    user = db.get({'token': token, 'usergroup': 0}, 'users')
    if user:
        article = db.update({'articleID': article_id}, {'state': -1}, 'article')
        if article:
            set_user_action(user['userID'], article_id, 36)
            set_sys_message(user['userID'], 2, '您发布的文章 ' + article['title'] + ' 已被管理员清除！', article['userID'])
            return jsonify({'code': 1, 'msg': 'success'})
        return jsonify({'code': -1, 'msg': 'unable to delete'})
    return jsonify({'code': 0, 'msg': 'unexpected user'})


"""
    首页接口
"""


@app.route('/api/homepage/get_recommend', methods=['GET'])
def get_recommend():
    """
    根据用户推荐首页内容
    type=1 回答，0 提问，2 广告
    当前没有cf算法以后要改
    :return:code(0=未知用户，1=成功)
    """
    token = request.values.get('token')
    db = Database()
    user = db.get({'token': token}, 'users')
    if user:
        '''
        这里是从数据库里拿东西
        '''
        questions = db.get({'state': 0}, 'questionsinfo', 0)
        answers = db.get({'state': 0}, 'answersinfo', 0)
        '''
        到时候换成cf算法
        '''
        pattern = re.compile(r'<[Ii][Mm][Gg].+?/>')  # 正则表达匹配图片
        for value1 in questions:
            value1.update({
                'type': 0,
                'image': pattern.findall(value1['description']),
                'follow': db.count({'targettype': 4, 'targetID': value1['questionID']}, 'useraction'),
                'comment': db.count({'questionID': value1['questionID']}, 'questioncomments')
            })
        for value2 in answers:
            value2.update({'type': 1, 'image': pattern.findall(value2['content'])})
        data = [{'title': '震惊！这样可以测出你的血脂', 'type': 2}]  # 假装有广告
        '''
        这里是随机乱序假装这是推荐了
        '''
        for value in questions + answers:
            value['edittime'] = get_formative_datetime(value['edittime'])  # 修改日期格式
            position = int(random.random() * len(data))  # 随机插入位置
            data.insert(position, value)
        return jsonify({'code': 1, 'msg': 'success', 'data': data})
    return jsonify({'code': 0, 'msg': 'unexpected user'})


@app.route('/api/homepage/get_category')
def get_category():
    """
    获取分类(真的)
    :return:code(1=成功)
    """
    db = Database()
    tags = db.get({'type': 1}, 'tags')
    data = []
    for value in tags:
        data.append({
            'name': value['name'],
            'id': value['id']
        })
    return jsonify({'code': 1, 'msg': 'success', 'data': data})


@app.route('/api/homepage/get_hot_search')
def get_hot_search():
    """
    获取热搜推荐(假的)
    :return:code(0=未知问题，1=成功)
    """

    return jsonify({'code': 1, 'msg': 'success', 'data': ''})


"""
    信息接口
"""


@app.route('/api/message/get_message_list')
def get_message_list():
    """
    获取聊天列表
    :return: code(0=未知用户，-1=空聊天列表，1=成功)
    """
    token = request.values.get('token')
    db = Database()
    user = db.get({'token': token}, 'users')
    if user:
        receive = db.get({'receiver': user['userID']}, 'chat_box', 0)
        post = db.get({'poster': user['userID']}, 'chat_box', 0)
        data = []
        for value in receive + post:
            data.append({
                'user_id': value['receiver'] if value['poster'] == user['userID'] else value['poster'],
                'nickname': value['receiver_nickname'] if value['poster'] == user['userID'] else value[
                    'poster_nickname'],
                'headportrait': value['receiver_headportrait'] if value['poster'] == user['userID'] else value[
                    'poster_headportrait'],
                'post_time': get_formative_datetime(value['post_time']),
                'content': value['content']
            })
        sorted(data, key=lambda a: a['post_time'], reverse=True)
        back = []
        for value in data:
            flag = True
            for value1 in back:
                if value1['user_id'] == value['user_id']:
                    flag = False
            if flag:
                back.append(value)
        return jsonify({'code': 1, 'msg': 'success', 'data': back})
    return jsonify({'code': 0, 'msg': 'unexpected user'})


@app.route('/api/message/add_message', methods=['POST'])
def add_message():
    """
    添加信息
    :return: code(0=未知用户，-1=无法录入，1=成功)
    """
    token = request.form['token']
    receiver = request.form['receiver']
    content = request.form['content']
    message_type = request.form['message_type']
    db = Database()
    user = db.get({'token': token}, 'users')
    if user:
        flag = db.insert({'receiver': receiver, 'content': content, 'type': message_type, 'poster': user['userID']},
                         'messages')
        if flag:
            return jsonify({'code': 1, 'msg': 'success'})
        return jsonify({'code': -1, 'msg': 'unable to insert'})
    return jsonify({'code': 0, 'msg': 'unexpected user'})


@app.route('/api/message/get_chat_box')
def get_chat_box():
    """
    获取聊天室内容
    :return:code(0=未知用户，1=成功)
    """
    token = request.values.get('token')
    user_id = request.values.get('user_id')
    db = Database()
    user = db.get({'token': token}, 'users')
    if user:
        message1 = db.get({'poster': user['userID'], 'receiver': user_id}, 'messages', 0)
        message2 = db.get({'receiver': user['userID'], 'poster': user_id}, 'messages', 0)
        if message2 and message1:
            data = message1 + message2
        elif message1:
            data = message1
        elif message2:
            data = message2
        else:
            data = []
        sorted(data, key=lambda a: a['post_time'])
        return jsonify({'code': 1, 'msg': 'success', 'data': data})
    return jsonify({'code': 0, 'msg': 'unexpected user'})


@app.route('/api/message/get_friend_list')
def get_friend_list():
    """
    获取好友列表
    :return: code(0=未知用户，1=成功)
    """
    token = request.values.get('token')
    db = Database()
    user = db.get({'token': token}, 'users')  # 从token获取用户
    if user:
        # 根据token获取该用户的好友列表
        friend = db.sql(
            "select A.userID as user_id ,A.nickname as nickname,A.headportrait as headportrait,A.usergroup as "
            "usergroup,A.exp as exp from users A,(select C.* from followuser C,users D where C.userID = D.userID and "
            "D.token= '%s') B,followuser C where A.userID=C.userID and (C.target = B.userID) and C.userID = B.target "
            "" % token)
        if friend:
            return jsonify({'code': 1, 'msg': 'success', 'data': friend})
        return jsonify({'code': 1, 'msg': 'success', 'data': []})
    return jsonify({'code': 0, 'msg': 'unexpected user'})

    # user = db.get({'token': token}, 'users')  # 从token获取用户
    # if user:
    #     followed = db.get({'userID': user['userID']}, 'followuser', 0)  # 获取所有用户关注的用户
    #     data = []
    #     for value in followed:
    #         if db.get({'userID': value['target'], 'target': value['userID']}, 'followuser'):  # 判断关注的用户是否为互关，互关即好友
    #             friend = db.get({'userID': value['target']}, 'users')  # 获取好友信息
    #             if friend:
    #                 data.append({
    #                     'user_id': friend['userID'],
    #                     'nickname': friend['nickname'],
    #                     'headportrait': friend['headportrait'],
    #                     'usergroup': friend['usergroup'],
    #                     'exp': friend['exp']
    #                 })  # 存入信息
    #     return jsonify({'code': 1, 'msg': 'success', 'data': data})
    # return jsonify({'code': 0, 'msg': 'unexpected user'})


@app.route('/api/message/get_agree_list')
def get_agree_list():
    """
    获取点赞列表
    :return:
    """
    token = request.values.get('token')
    db = Database()
    user = db.get({'token': token}, 'users')
    if user:
        """
            获取所有的用户行为
        """
        comment1 = db.get({'userID': user['userID']}, 'answercomments')
        user_action = []
        for value in comment1:
            action = db.get({'targettype': 3, 'targetID': value['acommentID']}, 'useraction', 0)
            if action:
                user_action = user_action + action
        comment2 = db.get({'userID': user['userID']}, 'questioncomments')
        for value in comment2:
            action = db.get({'targettype': 5, 'targetID': value['qcommentID']}, 'useraction', 0)
            if action:
                user_action = user_action + action
        answer = db.get({'userID': user['userID']}, 'answers')
        for value in answer:
            action1 = db.get({'targettype': 1, 'targetID': value['answerID']}, 'useraction', 0)
            action2 = db.get({'targettype': 2, 'targetID': value['answerID']}, 'useraction', 0)
            if action1:
                user_action = user_action + action1
            if action2:
                user_action = user_action + action2
        """
            处理用户行为n
        """
        data = []
        for value in user_action:
            if value['targettype'] == 1 or value['targettype'] == 2:
                action = db.get({'actionID': value['actionID']}, 'agree_answer_info')
                if action:
                    data.append({
                        'type': value['targettype'],
                        'nickname': action['nickname'],
                        'userID': action['userID'],
                        'answerID': action['targetID'],
                        'title': action['title'],
                        'time': action['actiontime']
                    })
            elif value['targettype'] == 3:
                action = db.get({'actionID': value['actionID']}, 'agree_answer_comment_info')
                if action:
                    data.append({
                        'type': value['targettype'],
                        'nickname': action['nickname'],
                        'userID': action['userID'],
                        'commentID': action['targetID'],
                        'title': action['title'],
                        'time': action['actiontime']
                    })
            elif value['targettype'] == 5:
                action = db.get({'actionID': value['actionID']}, 'agree_question_comment_info')
                if action:
                    data.append({
                        'type': value['targettype'],
                        'nickname': action['nickname'],
                        'userID': action['userID'],
                        'commentID': action['targetID'],
                        'title': action['title'],
                        'time': action['actiontime']
                    })
        return jsonify({'code': 1, 'msg': 'success', 'data': data})
    return jsonify({'code': 0, 'msg': 'unexpected user'})


@app.route('/api/message/get_at_list')
def get_at_list():
    """
    获取@列表
    :return:
    """
    token = request.values.get('token')
    db = Database()
    user = db.get({'token': token}, 'users')
    if user:
        data = []
        q_at = db.like({'description': '@' + user['nickname'] + ' '}, 'q_at_info')
        for value in q_at:
            data.append({
                'nickname': value['nickname'],
                'time': value['edittime'],
                'id': value['questionID'],
                'type': 1,
                'headportrait': value['headportrait'],
                'title': value['title'],
                'user_id': value['userID'],
                'content': value['description']
            })
        qc_at = db.like({'content': '@' + user['nickname'] + ' '}, 'qc_at_info')
        for value in qc_at:
            data.append({
                'nickname': value['nickname'],
                'time': value['createtime'],
                'id': value['qcommentID'],
                'type': 2,
                'headportrait': value['headportrait'],
                'user_id': value['userID'],
                'content': value['content']
            })
        a_at = db.like({'content': '@' + user['nickname'] + ' '}, 'a_at_info')
        for value in a_at:
            data.append({
                'nickname': value['nickname'],
                'time': value['edittime'],
                'id': value['answerID'],
                'type': 3,
                'headportrait': value['headportrait'],
                'user_id': value['userID'],
                'content': value['content']
            })
        ac_at = db.like({'content': '@' + user['nickname'] + ' '}, 'ac_at_info')
        for value in ac_at:
            data.append({
                'nickname': value['nickname'],
                'time': value['createtime'],
                'id': value['acommentID'],
                'type': 3,
                'headportrait': value['headportrait'],
                'user_id': value['userID'],
                'content': value['content']
            })
        return jsonify({'code': 1, 'msg': 'success', 'data': data})
    return jsonify({'code': 0, 'msg': 'unexpected user'})


ALLOWED_USER_GROUP = {0, '0'}  # 允许发送广播用户组


@app.route('/api/message/add_sys_notice', methods=['POST'])
def add_sys_notice():
    """
    发送系统消息
    :return: code(0=未知用户，-1=权限不足，-2=无法添加，1=成功)
    """
    token = request.form['token']
    db = Database()
    user = db.get({'token': token, 'usergroup': 0}, 'users')
    if user:
        if user['usergroup'] in ALLOWED_USER_GROUP:
            content = request.form['content']
            message_type = request.form['type']
            target = request.form['target']
            flag = db.insert({'content': content, 'type': message_type, 'userID': user['userID'], 'target': target},
                             'sys_message')
            if flag:
                return jsonify({'code': 1, 'msg': 'success'})
            return jsonify({'code': -2, 'msg': 'unable to insert'})
        return jsonify({'code': -1, 'msg': 'permission denied'})
    return jsonify({'code': 0, 'msg': 'unexpected user'})


def set_sys_message(user_id, sys_type, content, target):
    """
    发送系统消息（内部接口）
    :param user_id: 用户id
    :param type: 消息类型
    :param content: 内容
    :param target: 目标
    :return: boolean
    """
    db = Database()
    flag = db.insert({'userID': user_id, 'content': content, 'type': sys_type, 'target': target}, 'sys_message')
    if flag:
        return True
    return False


@app.route('/api/message/get_sys_message')
def get_sys_message():
    """
    获取系统消息
    :return:
    """
    token = request.values.get('token')
    db = Database()
    user = db.get({'token': token}, 'users')
    if user:
        all = db.get({'type': 1}, 'sys_message')
        personal = db.get({'type': 2, 'target': user['userID']}, 'sys_message')
        data = all + personal
        sorted(data, key=lambda x: x['createtime'], reverse=True)
        return jsonify({'code': 1, 'msg': 'success', 'data': data})
    return jsonify({'code': 0, 'msg': 'unexpected user'})


@app.route('/api/message/get_message')
def get_message():
    """
    获取某用户的私信
    :return: code:0=用户不存在 1=获取成功 -1=获取失败
    """
    token = request.values.get('token')
    db = Database()
    user = db.get({'token': token}, 'users')
    if user:
        message = db.get({'receiver', user['userID']}, 'messages')
        if message:
            return jsonify({'code': 1, 'msg': 'success', 'list': message})
        else:
            return jsonify({'code': -1, 'msg': 'fail'})
    else:
        return jsonify({'code': 0, 'msg': 'the user is not exist'})


"""
    上传接口
"""
ALLOWED_EXTENSIONS = ['png', 'jpg', 'JPG', 'PNG', 'gif', 'GIF']  # 允许上传的格式
ALLOWED_PIC = ['png', 'jpg', 'JPG', 'PNG']  # 允许上传的身份证格式


# 用于判断文件后缀
def allowed_file(filename):
    return '.' in filename and filename.rsplit('.', 1)[1] in ALLOWED_EXTENSIONS


@app.route('/api/upload/upload_picture', methods=['POST'])
def upload_picture():
    """
    上传图片
    :return: code(0=失败，1=成功)
    """
    f = request.files['picture']
    if f and allowed_file(f.filename):
        basepath = os.path.dirname(__file__)  # 当前文件所在路径
        new_filename = str(int(time.time())) + secure_filename(f.filename)
        upload_path = os.path.join(basepath, 'static/uploads', new_filename)  # 注意：没有的文件夹一定要先创建，不然会提示没有该路径
        f.save(upload_path)
        return jsonify({'code': 1, 'msg': 'success', 'data': '/static/uploads/' + new_filename})
    return jsonify({'code': 0, 'msg': 'unexpected type'})


def allowed_pic(filename):
    """
    检测文件是否符合要求
    :param filename:
    :return:
    """
    return '.' in filename and filename.rsplit('.', 1)[1] in ALLOWED_PIC


@app.route('/api/upload/upload_identity_card', methods=['POST'])
def upload_identity_card():
    """
    上传身份证
    :return:code(0=未知用户，-1=文件格式不正确-2=无法自动识别，1=成功）
    """
    front = request.files['front']
    back = request.files['back']
    token = request.form['token']
    db = Database()
    user = db.get({'token': token}, 'users')
    if user:
        if front and back and allowed_pic(front.filename) and allowed_pic(back.filename):
            basepath = os.path.dirname(__file__)  # 当前文件所在路径
            # 正面的图片
            front_filename = user['userID'] + '_front_' + front.filename.rsplit('.', 1)[1]
            upload_path = os.path.join(basepath, 'identity_card', front_filename)  # 注意：没有的文件夹一定要先创建，不然会提示没有该路径
            front.save(upload_path)
            # 反面的图片
            back_filename = user['userID'] + '_front_' + front.filename.rsplit('.', 1)[1]
            upload_path_reverse = os.path.join(basepath, 'identity_card/', back_filename)  # 注意：没有的文件夹一定要先创建，不然会提示没有该路径
            back.save(upload_path_reverse)

            # 调用ocr进行反面识别文字信息(反面是有个人信息的那一面)
            info_reverse = ocr(upload_path_reverse)

            flag = db.update({'userID': user['userID']}, {'state': 1}, 'users')
            if flag:
                return jsonify({'code': 1, 'msg': 'success', 'data': info_reverse})
            return jsonify({'code': -2, 'msg': 'unable to identify'})
        return jsonify({'code': -1, 'msg': 'unexpected file'})
    return jsonify({'code': 0, 'msg': 'unexpected user'})


"""
    算法接口
"""


@app.route('/api/algorithm/item_cf')
def item_cf_api():
    """
    调用item cf算法推荐
    :return: code:0-失败  1-成功  data:被推荐的物品ID
    """
    # 评分矩阵文件
    dirs = request.values.get('dir')
    # 相似度矩阵文件
    simi = request.values.get('similar_rect_dir')
    # 要根据某个物品(文章或问题)的ID来进行相似推荐
    target = request.values.get('target')
    # 得到的推荐结果
    result = item_cf(dirs, simi, target)

    return result


@app.route('/api/algorithm/build_article_rate_rect')
def build_article_rate_rect():
    """
    建立文章的评分矩阵
    :return: code:0=失败 1=成功
    """
    # 为文章或者问题建立评分矩阵，评分矩阵的某一行是
    # 所有用户对某一篇文章的行为进行权值计算后得到的一个向量,所有文章对应一个向量组合成矩阵
    # chart的值目前只能为article 或 questions
    file_name = request.values.get("file_name")
    db = Database()
    # targettype 对应的评分
    rate_dict = {21: 2, 22: 4, 23: 3, 24: -2, 25: 3}
    article = db.sql("select * from article")
    users = db.sql("select * from users order by userID ASC")

    for i in range(len(article)):
        # 对于第i篇文章的评分向量,没有参与的用户评分默认为1
        rates = {}
        for j in range(len(users)):
            rates[users[j]['userID']] = 1
            actions = db.sql(
                "select * from useraction where targetID='%s' and userID='%s' and targettype>=21 and targettype <=25 "
                "order by userID ASC" %
                (article[i]['articleID'], users[j]["userID"]))
            # 该用户对这篇文章的总评分
            rate = 0
            if actions:
                for k in range(len(actions)):
                    rt = rate_dict[actions[k]["targettype"]]
                    rate += rt
                rates[users[j]['userID']] = rate

        keys = rates.keys()
        with open("../CF/rate_rect/" + file_name, "w") as f:
            f.write("ID:" + str(article[i]['articleID']) + " rate:")
            rate_str = ""
            for key in keys:
                rate_str += str(key) + "-" + str(rates[key]) + "-"
            rate_str = rate_str[:-1]
            f.write(rate_str + "\n")

    return jsonify({"code": 1})


"""
    专家接口
"""


@app.route('/api/specialist/get_my_answers')
def get_my_answers():
    """
    获取自己的回答
    :return:
    """
    token = request.values.get('token')
    db = Database()
    user = db.get({'token': token}, 'users')
    if user:
        answers = db.get({'userID': user['userID']}, 'answersinfo')
        for value in answers:
            value.update({'tags': get_tags(value['tags'])})
        return jsonify({'code': 1, 'msg': 'success', 'data': answers})
    return jsonify({'code': 0, 'msg': 'unexpected user'})


@app.route('/api/specialist/get_my_articles')
def get_my_articles():
    """
    获取自己的文章
    :return:
    """
    token = request.values.get('token')
    db = Database()
    user = db.get({'token': token}, 'users')
    if user:
        articles = db.get({'userID': user['userID']}, 'articleinfo')
        for value in articles:
            value.update({'tags': get_tags(value['tags'])})
        return jsonify({'code': 1, 'msg': 'success', 'data': articles})
    return jsonify({'code': 0, 'msg': 'unexpected user'})


@app.route('/api/specialist/get_my_fans')
def get_my_fans():
    """
    获取粉丝列表
    :return:
    """
    token = request.values.get('token')
    db = Database()
    user = db.get({'token': token}, 'users')
    if user:
        followers = db.get({'target': user['userID']}, 'followinfo')
        data = []
        for value in followers:
            data.append({
                'id': value['userID'],
                'nickname': value['follower_nickname'],
                'usergroup': get_group(value['follower_usergroup']),
                'exp': value['follower_exp'],
                'level': get_level(value['follower_exp']),
                'description': value['follower_description']
            })
        return jsonify({'code': 1, 'msg': 'success', 'data': data})
    return jsonify({'code': 0, 'msg': 'unexpected user'})


@app.route('/api/specialist/get_order_list')
def get_order_list():
    """
    获取付费咨询的预定列表
    :return:
    """
    token = request.values.get('token')
    db = Database()
    user = db.get({'token': token}, 'users')
    if user:
        order = db.get({'target': user['userID']}, 'orderinfo')
        for value in order:
            value.update({'level': get_level(value['exp']), 'usergroup': get_group(value['usergroup'])})
        return jsonify({'code': 1, 'msg': 'success', 'data': order})
    return jsonify({'code': 0, 'msg': 'unexpected user'})


@app.route('/api/specialist/confirm_order')
def confirm_order():
    """
    确认付费咨询预约
    :return:
    """
    token = request.values.get('token')
    db = Database()
    user = db.get({'token': token}, 'users')
    if user:
        order_id = request.values.get('order_id')
        order = db.update({'order_id': order_id, 'target': user['userID']}, {'state': 1}, 'orders')
        if order:
            return jsonify({'code': 1, 'msg': 'success'})
        return jsonify({'code': -1, 'msg': 'unable to find order or user is not correct'})
    return jsonify({'code': 0, 'msg': 'unexpected user'})


@app.route('/api/specialist/refuse_order')
def refuse_order():
    """
    拒绝付费咨询预约
    :return:
    """
    token = request.values.get('token')
    db = Database()
    user = db.get({'token': token}, 'users')
    if user:
        order_id = request.values.get('order_id')
        order = db.update({'order_id': order_id, 'target': user['userID']}, {'state': -1}, 'orders')
        if order:
            return jsonify({'code': 1, 'msg': 'success'})
        return jsonify({'code': -1, 'msg': 'unable to find order or user is not correct'})
    return jsonify({'code': 0, 'msg': 'unexpected user'})


@app.route('/api/specialist/get_click_info')
def get_click_info():
    """
    获取点击量图表（还没想好怎么写）
    :return:
    """
    pass


@app.route('/api/specialist/get_fans_info')
def get_fans_info():
    """
    获取关注量增减图表（同样没想好怎么写）
    :return:
    """
    pass


@app.route('/api/specialist/add_order', methods=['POST'])
def add_order():
    """
    添加付费咨询
    :return:
    """
    token = request.form['token']
    db = Database()
    user = db.get({'token': token}, 'users')
    if user:
        target = request.form['target']
        start_time = request.form['start_time']
        end_time = request.form['end_time']
        content = request.form['content']
        flag = db.insert({'userID': user['userID'], 'target': target, 'start_time': start_time, 'end_time': end_time,
                          'content': content}, 'orders')
        if flag:
            return jsonify({'code': 1, 'msg': 'success'})
        return jsonify({'code': -1, 'msg': 'unable to insert'})
    return jsonify({'code': 0, 'msg': 'unexpected user'})


@app.route('/api/specialist/request_upgrade', methods=['POST'])
def request_upgrade():
    """
    请求升级用户组到专家
    :return:
    """
    token = request.form['token']
    db = Database()
    user = db.get({'token': token}, 'users')
    if user:
        specialist_license = request.files['license']
        if specialist_license and allowed_pic(specialist_license.filename):
            basepath = os.path.dirname(__file__)  # 当前文件所在路径
            # 正面的图片
            filename = user['userID'] + '_license' + specialist_license.filename.rsplit('.', 1)[1]
            upload_path = os.path.join(basepath, 'license', filename)  # 注意：没有的文件夹一定要先创建，不然会提示没有该路径
            specialist_license.save(upload_path)
            flag = db.update({'userID': user['userID']}, {'usergroup': 5}, 'users')
            if flag:
                return jsonify({'code': 1, 'msg': 'success'})
            return jsonify({'code': -1, 'msg': 'unable to request'})
        return jsonify({'code': 0, 'msg': 'unexpected user'})


"""
    企业接口
"""


@app.route('/api/enterprise/add_demand', methods=['POST'])
def add_demand():
    """
    企业添加需求
    :return:
    """
    token = request.form['token']
    db = Database()
    user = db.get({'token': token, 'usergroup': 3}, 'users')
    if user:
        content = request.form['content']
        allowed_user = request.form['allowed_user']
        price = request.form['price']
        tags = request.form['tags']
        title = request.form['title']
        flag = db.insert(
            {'userID': user['userID'], 'content': content, 'allowedUserGroup': allowed_user, 'price': price,
             'title': title,
             'tags': tags}, 'demands')
        if flag:
            return jsonify({'code': 1, 'msg': 'success'})
        return jsonify({'code': -1, 'msg': 'unable to insert'})
    return jsonify({'code': 0, 'msg': 'unexpected user'})


@app.route('/api/enterprise/get_my_demands')
def get_my_demands():
    """
    获取需求列表
    :return:
    """
    token = request.values.get('token')
    db = Database()
    user = db.get({'token': token}, 'users')
    if user:
        demands = db.get({'userID': user['userID']}, 'demands_info')
        return jsonify({'code': 1, 'msg': 'success', 'data': demands})
    return jsonify({'code': 0, 'msg': 'unexpected user'})


@app.route('/api/enterprise/get_signed_users')
def get_signed_users():
    """
    获取报名需求列表
    :return:
    """
    token = request.values.get('token')
    db = Database()
    user = db.get({'token': token}, 'users')
    if user:
        demand_id = request.values.get('demand_id')
        signed_list = db.get({'target': demand_id}, 'signed_demand_info')
        return jsonify({'code': 1, 'msg': 'success', 'data': signed_list})
    return jsonify({'code': 0, 'msg': 'unexpected user'})


@app.route('/api/enterprise/confirm_signed_user')
def confirm_signed_user():
    """
    确认报名的用户
    :return:
    """
    token = request.values.get('token')
    db = Database()
    user = db.get({'token': token}, 'users')
    if user:
        user_id = request.values.get('user_id')
        target = request.values.get('target')
        flag = db.update({'userID': user_id, 'target': target}, {'state': 1}, 'sign_demand')
        demand = db.get({'demandID': target}, 'demands')
        set_sys_message(user['userID'], 2, '您之前报名的' + demand['title'] + '已由企业审核通过，您现在是该需求的参与者了！', user_id)
        if flag:
            return jsonify({'code': 1, 'msg': 'success'})
        return jsonify({'code': -1, 'msg': 'unable to confirm'})
    return jsonify({'code': 0, 'msg': 'unexpected user'})


@app.route('/api/enterprise/refuse_signed_user')
def refuse_signed_user():
    """
    拒绝报名的用户
    :return:
    """
    token = request.values.get('token')
    db = Database()
    user = db.get({'token': token}, 'users')
    if user:
        user_id = request.values.get('user_id')
        target = request.values.get('target')
        flag = db.update({'userID': user_id, 'target': target}, {'state': -1}, 'sign_demand')
        demand = db.get({'demandID': target}, 'demands')
        set_sys_message(user['userID'], 2, '您之前报名的 ' + demand['title'] + ' 申请未通过！', user_id)
        if flag:
            return jsonify({'code': 1, 'msg': 'success'})
        return jsonify({'code': -1, 'msg': 'unable to refuse'})
    return jsonify({'code': 0, 'msg': 'unexpected user'})


@app.route('/api/enterprise/close_demand')
def close_demand():
    """
    关闭需求
    :return:
    """
    token = request.values.get('token')
    db = Database()
    user = db.get({'token': token}, 'users')
    if user:
        demand_id = request.values.get('demand_id')
        flag = db.update({'demandID': demand_id, 'userID': user['userID']}, {'state': 2}, 'demands')
        if flag:
            return jsonify({'code': 1, 'msg': 'success'})
        return jsonify({'code': -1, 'msg': 'unable to close or user is not correct'})
    return jsonify({'code': 0, 'msg': 'unexpected user'})


@app.route('/api/enterprise/start_demand')
def start_demand():
    """
    开始项目停止招标
    :return:
    """
    token = request.values.get('token')
    db = Database()
    user = db.get({'token': token}, 'users')
    if user:
        demand_id = request.values.get('demand_id')
        flag = db.update({'demandID': demand_id, 'userID': user['userID']}, {'state': 1}, 'demands')
        if flag:
            return jsonify({'code': 1, 'msg': 'success'})
        return jsonify({'code': -1, 'msg': 'unable to start or user is not correct'})
    return jsonify({'code': 0, 'msg': 'unexpected user'})


@app.route('/api/enterprise/request_enterprise_upgrade', methods=['POST'])
def request_enterprise_upgrade():
    """
    请求升级用户组到企业
    :return:
    """
    token = request.form['token']
    db = Database()
    user = db.get({'token': token}, 'users')
    if user:
        specialist_license = request.files['license']
        if specialist_license and allowed_pic(specialist_license.filename):
            basepath = os.path.dirname(__file__)  # 当前文件所在路径
            # 正面的图片
            filename = user['userID'] + '_license' + specialist_license.filename.rsplit('.', 1)[1]
            upload_path = os.path.join(basepath, 'license', filename)  # 注意：没有的文件夹一定要先创建，不然会提示没有该路径
            specialist_license.save(upload_path)
            flag = db.update({'userID': user['userID']}, {'usergroup': 6}, 'users')
            if flag:
                return jsonify({'code': 1, 'msg': 'success'})
            return jsonify({'code': -1, 'msg': 'unable to request'})
        return jsonify({'code': 0, 'msg': 'unexpected user'})


"""
    告示板接口
"""


@app.route('/api/board/sign_to_demand')
def sign_to_demand():
    """
    报名特定项目
    :return:
    """
    token = request.values.get('token')
    db = Database()
    user = db.get({'token': token}, 'users')
    if user:
        demand_id = request.values.get('demand_id')
        flag = db.insert({'userID': user['userID'], 'target': demand_id}, 'sign_demand')
        if flag:
            return jsonify({'code': 1, 'msg': 'success'})
        return jsonify({'code': -1, 'msg': 'unable to sign'})
    return jsonify({'code': 0, 'msg': 'unexpected user'})


@app.route('/api/board/get_board_recommend')
def get_board_recommend():
    """
    获取需求推荐
    :return:
    """
    token = request.values.get('token')
    db = Database()
    user = db.get({'token': token}, 'users')
    if user:
        """
            没对接cf算法，到时候对接一下cf算法
        """
        demand = db.get({'state': 0}, 'demands_info')
        """
            对接处
        """
        for value in demand:
            value.update({
                'tags': get_tags(value['tags']),
                'usergroup': get_group(value['usergroup']),
                'level': get_level(value['exp']),
            })
        return jsonify({'code': 1, 'msg': 'success', 'data': demand})
    return jsonify({'code': 0, 'msg': 'unexpected user'})


@app.route('/api/board/get_board_category')
def get_board_category():
    """
    获取告示板分类
    :return:
    """
    db = Database()
    tags = db.get({'type': 1}, 'tags')
    data = []
    for value in tags:
        data.append({
            'name': value['name'],
            'id': value['id']
        })
    return jsonify({'code': 1, 'msg': 'success', 'data': data})


@app.route('/api/board/get_child_category')
def get_child_category():
    """
    获取父级标签下的子集标签
    :return:
    """
    db = Database()
    tag_id = request.values.get('tag_id')
    tags = db.get({'father': tag_id}, 'tags')
    data = []
    for value in tags:
        data.append({
            'name': value['name'],
            'id': value['id']
        })
    return jsonify({'code': 1, 'msg': 'success', 'data': data})


@app.route('/api/board/get_demand')
def get_demand():
    """
    获取需求信息
    :return:
    """
    demand_id = request.values.get('demand_id')
    db = Database()
    demand = db.get({'demandID': demand_id}, 'demands_info')
    if demand:
        demand.update({
            'tags': get_tags(demand['tags']),
            'usergroup': get_group(demand['usergroup']),
            'level': get_level(demand['exp']),
        })
        return jsonify({'code': 1, 'msg': 'success', 'data': demand})
    return jsonify({'code': 0, 'msg': 'unknown demand'})


@app.route('/api/board/get_demands_by_tag')
def get_demands_by_tag():
    """
    获取该tag下的所有需求
    :return:
    """
    tag_id = request.values.get('tag_id')
    db = Database()
    demands = db.get({'state': 0}, 'demands_info')
    data = []
    for value in demands:
        tags = get_tags(value['tags'])
        for tag in tags:
            if tag['id'] == tag_id:
                value.update({
                    'tags': get_tags(value['tags']),
                    'usergroup': get_group(value['usergroup']),
                    'level': get_level(value['exp']),
                })
                data.append(value)
                break
    return jsonify({'code': 1, 'msg': 'success', 'data': data})


@app.route('/api/board/back_get_demands')
def back_get_demands():
    """
    后台获取需求列表
    :return:
    """
    token = request.headers.get('X-Token')
    db = Database()
    user = db.get({'token': token, 'usergroup': 0}, 'users')
    if user:
        demands = db.get({}, 'demands_info')
        for value in demands:
            value.update({
                'tags': get_tags(value['tags']),
                'usergroup': get_group(value['usergroup']),
                'level': get_level(value['exp']),
            })
        return jsonify({'code': 1, 'msg': 'success', 'data': demands})
    return jsonify({'code': 0, 'msg': 'unexpected user'})


@app.route('/api/board/delete_demand')
def delete_demand():
    """
    清除需求
    :return:
    """
    token = request.headers.get('X-Token')
    db = Database()
    user = db.get({'token': token, 'usergroup': 0}, 'users')
    if user:
        demand_id = request.values.get('demand_id')
        flag = db.update({'demandID': demand_id}, {'state': -1}, 'demands')
        if flag:
            set_user_action(user['userID'], demand_id, 33)
            set_sys_message(user['userID'], 2, '您发布的需求 ' + flag['title'] + ' 已被管理员清除！', flag['userID'])
            return jsonify({'code': 1, 'msg': 'success'})
        return jsonify({'code': -1, 'msg': 'unable to delete'})
    return jsonify({'code': 0, 'msg': 'unexpected user'})


if __name__ == '__main__':
    # 开启调试模式，修改代码后不需要重新启动服务即可生效
    # 请勿在生产环境下使用调试模式
    # Flask服务将默认运行在localhost的5000端口上

    # with open('static\\upload\\36.txt', 'rb') as file:
    #     result = pred(file.read())
    #     print(result[0])
    app.run(debug=True)
