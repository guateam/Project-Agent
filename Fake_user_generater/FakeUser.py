import json
import random

import requests

from Fake_user_generater.db import Database


def fake_user_register(n):
    """
    注册假用户
    :return:
    """
    for i in range(n):
        email = 'user' + str(i) + '@fake.com'
        password = 'user' + str(i)
        r = requests.post(url='https://hanerx.tk:5000/api/account/register',
                          data={'email': email, 'password': password},
                          headers={'Content-Type': 'application/x-www-form-urlencoded'})
        print(r.text)


def question_upload(n, tag_n, path='./static/zhihu.json'):
    """
    自动从指定文件中提取问题
    :param n:
    :param path:
    :param tag_n:
    :return:
    """
    db = Database()
    users = db.get({}, 'users', 0)
    tags = db.get({}, 'tags', 0)
    if len(tags) <= tag_n:
        tag_n = len(tags)
    with open(path, 'r', encoding='utf-8') as file:
        questions = json.loads(file.read())
        for i in range(n):
            question = random.choice(questions)
            tag_list = []
            for j in range(tag_n):
                tmp = random.choice(tags)
                tag_list.append(str(tmp['id']))
            tag = ','.join(tag_list)
            db.insert(
                {'userID': random.randint(1, len(users)), 'title': question['title'], 'description': question['desc'],
                 'tags': tag}, 'questions')


def add_random_user_action(n):
    """
    随机添加用户行为，包括浏览等
    :param n:
    :return:
    """
    db = Database()
    users = db.count({}, 'users')
    type_list = [1, 2, 3, 4, 11, 12, 13, 14, 21, 22, 23, 24, 25, 50, ]
    for i in range(n):
        target_type = random.choice(type_list)
        target = 0
        if target_type == 1 or target_type == 2 or target_type == 50:
            target = random.randint(1, db.count({}, 'answers'))
        elif 2 < target_type < 5:
            target = random.randint(1, db.count({}, 'answercomments'))
        elif 10 < target_type < 14:
            target = random.randint(1, db.count({}, 'questions'))
        elif target_type == 14:
            target = random.randint(1, db.count({}, 'questioncomments'))
        elif 20 < target_type < 26:
            target = random.randint(1, db.count({}, 'article'))

        user = random.randint(1, users)
        db.insert({'userID': user, 'targetID': target, 'targettype': target_type}, 'useraction')
        if target_type == 12:
            db.insert({'userID': user, 'target': target}, 'followtopic')
        elif target_type == 50:
            db.insert({'userID': user, 'answerID': target}, 'collectanswer')
        elif target_type == 22:
            db.insert({'userID': user, 'articleID': target}, 'collectarticle')
        print(i)


def set_current_user_action(id, n):
    """
    为特定用户添加用户行为
    :return:
    """
    db = Database()

    type_list = [1, 2, 3, 4, 11, 12, 13, 14, 21, 22, 23, 24, 25, 50, 21, 21, 21, 21, 11, 11, 11, 11]
    for i in range(n):
        target_type = random.choice(type_list)
        target = 0
        if target_type == 1 or target_type == 2 or target_type == 50:
            target = random.randint(1, db.count({}, 'answers'))
        elif 2 < target_type < 5:
            target = random.randint(1, db.count({}, 'answercomments'))
        elif 10 < target_type < 14:
            target = random.randint(1, db.count({}, 'questions'))
        elif target_type == 14:
            target = random.randint(1, db.count({}, 'questioncomments'))
        elif 20 < target_type < 26:
            target = random.randint(1, db.count({}, 'article'))

        db.insert({'userID': id, 'targetID': target, 'targettype': target_type}, 'useraction')
        if target_type == 12:
            db.insert({'userID': id, 'target': target}, 'followtopic')
        elif target_type == 50:
            db.insert({'userID': id, 'answerID': target}, 'collectanswer')
        elif target_type == 22:
            db.insert({'userID': id, 'articleID': target}, 'collectarticle')


def fake_user_follow(n):
    """
    随机添加用户的关注
    :return:
    """
    db = Database()
    user = db.get({}, 'users')
    for i in range(n):
        target = random.choice(user)
        follower = random.choice(user)
        db.insert({'userID': follower['userID'], 'target': target['userID']}, 'followuser')
        print(i)


if __name__ == '__main__':
    # fake_user_register(20)
    # question_upload(100, 2)
    # add_random_user_action(1000)
    # set_current_user_action(1, 100)
    fake_user_follow(200)
    pass
