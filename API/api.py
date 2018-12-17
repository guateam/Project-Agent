import random
import re
import string

from flask import Flask, jsonify, request
from flask_cors import CORS

from API.db import Database, generate_password

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
        # print(answer_list)
        # data = []
        # for value in answer_list:
        #     data.append({
        #         'id': value['answerID'],
        #         'user_id': value['userID'],
        #         'content': value['content'],
        #         'edit_time': value['edittime'],
        #         'agree': value['agree'],
        #         'disagree': value['disagree'],
        #         'answer_type': value['answertype'],
        #         'question_id': value['questionID']
        #     })
        # sorted(data, key=lambda a: a['agree'], reverse=True)
        # return jsonify({'code': 1, 'msg': 'success', 'data': data})
        return jsonify({'code': 1, 'msg': 'success', 'data': answer_list})
    return jsonify({'code': 0, 'msg': 'unknown question'})


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
        if user:
            data = {
                'id': answer['answerID'],
                'user_id': answer['userID'],
                'user_nickname': user['nickname'],
                'user_headportrait': user['headportrait'],
                'content': answer['content'],
                'edit_time': answer['edittime'],
                'agree': answer['agree'],
                'disagree': answer['disagree'],
                'answer_type': answer['answertype'],
                'question_id': answer['questionID']
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
                    'create_time': value['createtime'],
                    'agree': value['agree']
                })
        sorted(data, key=lambda a: a['agree'], reverse=True)
        return jsonify({'code': 1, 'msg': 'success', 'data': data})
    return jsonify({'code': 0, 'msg': 'unknown answer'})


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
            flag = db.insert({'userID': user['userID'], 'targetID': answer_id, 'targettype': 1})
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
            flag = db.insert({'userID': user['userID'], 'targetID': comment_id, 'targettype': 3})
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
            flag = db.insert({'userID': user['userID'], 'targetID': answer_id, 'targettype': 2})
            if result and flag:
                return jsonify({'code': 1, 'msg': 'success'})
            if result:
                return jsonify({'code': -2, 'msg': 'unable to insert user action'})
            if flag:
                return jsonify({'code': -3, 'msg': 'unable to update agree number'})
        return jsonify({'code': -1, 'msg': 'unknown answer'})
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
        questions = db.get({}, 'questionsinfo', 0)
        answers = db.get({}, 'answersinfo', 0)
        '''
        到时候换成cf算法
        '''
        pattern = re.compile(r'<[Ii][Mm][Gg].+?/>')  # 正则表达匹配图片
        for value1 in questions:
            value1.update({'type': 0, 'image': pattern.findall(value1['description'])})
        for value2 in answers:
            value2.update({'type': 1, 'image': pattern.findall(value2['content'])})
        data = [{'title': '震惊！这样可以测出你的血脂', 'type': 2}]  # 假装有广告
        '''
        这里是随机乱序假装这是推荐了
        '''
        for value in questions + answers:
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
        message_list = db.get({'receiver': user['userID']}, 'chat_box', 0)
        if message_list:
            return jsonify({'code': 1, 'msg': 'success', 'data': message_list})
        return jsonify({'code': -1, 'msg': 'empty list'})
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
        data = message1 + message2
        sorted(data, key=lambda a: a['post_time'])
        return jsonify({'code': 1, 'msg': 'success', 'data': data})
    return jsonify({'code': 0, 'msg': 'unexpected user'})


if __name__ == '__main__':
    # 开启调试模式，修改代码后不需要重新启动服务即可生效
    # 请勿在生产环境下使用调试模式
    # Flask服务将默认运行在localhost的5000端口上

    # with open('static\\upload\\36.txt', 'rb') as file:
    #     result = pred(file.read())
    #     print(result[0])
    app.run(debug=True)
