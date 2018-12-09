# API接口文档

[TOC]

## 环境 Environment

```shell
Language:
	Python3.6
Virtual Environment:
	$ python -m venv venv       # 创建python虚拟环境
	$ source venv/bin/activate  # 进入虚拟环境
	$ deactivate                # 退出虚拟环境
Packages:
    Flask==1.0.2
    PyMySQL==0.9.2
    Flask-Cors==3.0.6
```

## 设计思路

暂无

## 接口



### 格式约定 Format

```python
Type:
	json
Format:
	{
        code: ,  # 操作状态码
        msg: ,   # 错误提示
        data: ,  # 返回数据
	}
```

### 文档 Documentation

#### Account 账户

1. 用户登录 login

   - 接口 `/api/account/login()`

   - 参数 `username`-用户名 `password`-密码

   - 返回值

     ```python
     {
         code: code,       	# 0=未知用户 -1=未成功初始化token 1=成功
         msg: msg,        	# 信息
         data: {
             token: token,  	# 用户标识
             group: group,  	# 用户群组
         }
     }
     ```

2. 用户注册 register

3. 获取用户信息 get_user

#### Question 问题

1. 添加问题 add_answer
2. 获取回答列表 get_answer_list

#### Answer 回答

1. 添加回答 add_answer
2. 获取回答信息 get_answer
3. 获取回答评论列表 get_answer_comment_list
4. 添加回答评论 add_answer_comment
5. 点赞回答 agree_answer
6. 点赞回答评论 agree_answer_comment
7. 点踩回答 disagree_answer


## 数据库 DataBase

### 用户行为类型约定 TypeFormat

| 代码 | 释义             | 备注 |
| ---- | ---------------- | ---- |
| 1    | 对答案点赞       |      |
| 2    | 对答案点踩       |      |
| 3    | 对答案的评论点赞 |      |

