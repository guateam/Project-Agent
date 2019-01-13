import os
import random
import re
import string
import time
from CF.cf import item_cf

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
USER_GROUP = ['管理员', '从业者', '专家', '企业']
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
            'exp': user['exp'] / LEVEL_EXP[get_level(user['exp'])] * 100,
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
    check_email = db.get({'email': email}, 'users')
    if not check_email:
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
            'exp': user['exp'] / LEVEL_EXP[get_level(user['exp'])] * 100,
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
    db = Database()
    user = db.get({'token': token}, 'users')
    if user:
        flag = db.insert({'title': title, 'description': description, 'userID': user['userID']}, 'questions')
        if flag:
            return jsonify({'code': 1, 'msg': 'success'})
        return jsonify({'code': -1, 'msg': 'unable to insert question'})
    return jsonify({'code': 0, 'msg': 'unexpected user'})


@app.route('/api/questions/get_questions')
def get_questions():
    """
    获取问题
    :return:code(0=未知用户，-1=无法添加问题，1=成功)
    """
    db = Database()
    data = db.get({}, 'questions')
    return jsonify({'code': 0, 'msg': '', 'data': data})


@app.route('/api/questions/get_question')
def get_question():
    """
    通过id获取问题
    :return: code(0=未知问题，-1=未知提问人，1=成功)
    """
    question_id = request.values.get('question_id')
    db = Database()
    question = db.get({'questionID': question_id}, 'questions')
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
                'tags': question['tags']
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
    answer = db.get({'answerID': answer_id}, 'answers')
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
    timeStamp = time.time()
    timeArray = time.localtime(timeStamp)
    newtime = time.strftime("%Y--%m--%d %H:%M:%S", timeArray)

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
    comment_id = request.values.get('comment_id')
    db = Database()
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


"""
    文章接口
"""


@app.route('/api/article/add_article')
def add_article():
    """
    新建文章
    :return: code:-1=用户不存在 0=新建失败  1=新建成功
    """
    user_id = request.values.get("user_id")
    content = request.values.get("content")

    db = Database()
    user = db.get({'userID': user_id}, 'users')
    if not user:
        return jsonify({'code': -1, 'msg': 'the user is not exist'})

    success = db.insert({'content': content, 'userID': user_id}, 'article')
    if success:
        return jsonify({'code': 1, 'msg': 'add success'})
    else:
        return jsonify({'code': 0, 'msg': 'there are something wrong when inserted the data into database'})


@app.route('/api/article/edit_article')
def edit_article():
    """
    修改文章
    :return: code:-1=文章不存在 0=修改失败  1=修改成功
    """
    article_id = request.values.get("article_id")
    content = request.values.get("content")
    # 获取当前时间
    timeStamp = time.time()
    timeArray = time.localtime(timeStamp)
    newtime = time.strftime("%Y--%m--%d %H:%M:%S", timeArray)

    db = Database()
    article = db.get({'articleID': article_id}, 'article')
    if not article:
        return jsonify({'code': -1, 'msg': 'the article is not exist'})

    success = db.update({'articleID': article_id}, {'content': content, 'edittime': newtime}, 'article')
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
        questions = db.get({}, 'questionsinfo', 0)
        answers = db.get({}, 'answersinfo', 0)
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
    获取分类(假的)
    :return:code(0=未知问题，1=成功)
    """
    return jsonify({'code': 1, 'msg': 'success',
                    'data': [{'name': '材料学', 'id': 1},
                             {'name': '计算机图形学', 'id': 2},
                             {'name': '机械学', 'id': 3},
                             {'name': '热力学', 'id': 4}, ]})


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
            "select A.userID as user_id ,A.nickname as nickname,A.headportrait as headportrait,A.usergroup as usergroup,A.exp as exp from users A,(select C.* from followuser C,users D where C.userID = D.userID and D.token= '%s') B,followuser C where A.userID=C.userID and (C.target = B.userID) and C.userID = B.target " % token)
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
    user = db.get({'token': token}, 'users')
    if user:
        if user['usergroup'] in ALLOWED_USER_GROUP:
            content = request.form['content']
            message_type = request.form['type']
            flag = db.insert({'content': content, 'type': message_type, 'userID': user['userID']}, 'sys_message')
            if flag:
                return jsonify({'code': 1, 'msg': 'success'})
            return jsonify({'code': -2, 'msg': 'unable to insert'})
        return jsonify({'code': -1, 'msg': 'permission denied'})
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
ALLOWED_EXTENSIONS = set(['png', 'jpg', 'JPG', 'PNG', 'gif', 'GIF'])  # 允许上传的格式


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


"""
    算法接口
"""


@app.route('/api/algorithm/item_cf')
def item_cf_api():
    """
    调用item cf算法推荐
    :return: code:0-失败  1-成功  data:被推荐的物品在评分矩阵顺序中的下标
    """
    # 评分矩阵文件
    dir = request.values.get('dir')
    # 要根据某个物品(文章或问题)的ID来进行相似推荐
    target = request.values.get('target')
    # 得到的推荐结果
    result = item_cf(dir, target);

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

    rect = []
    for i in range(len(article)):
        # 对于第i篇文章的评分向量,没有参与的用户评分默认为1
        rates = {}
        for j in range(len(users)):
            rates[users[j]['userID']] = 1
            actions = db.sql(
                "select * from useraction where targetID='%s' and userID='%s' and targettype>=21 and targettype <=25 order by userID ASC" %
                (article[i]['articleID'], users[j]["userID"]))
            # 该用户对这篇文章的总评分
            rate = 0;
            if (actions):
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


if __name__ == '__main__':
    # 开启调试模式，修改代码后不需要重新启动服务即可生效
    # 请勿在生产环境下使用调试模式
    # Flask服务将默认运行在localhost的5000端口上

    # with open('static\\upload\\36.txt', 'rb') as file:
    #     result = pred(file.read())
    #     print(result[0])
    app.run(debug=True)
