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

   - 接口 `/api/account/register()`

   - 参数 `email`-邮箱 `password`-密码

   - 返回值

     ```python
     {
         code: code,       	# -1=用户已存在 1=成功
         msg: msg,        	# 信息
     }
     ```

3. 获取用户信息 get_user
   - 接口 `/api/account/get_user()`

   - 参数 `user_id`-用户id 

   - 返回值

     ```python
     {
         code: code,       	# 0=用户不存在 1=成功
         msg: msg,        	# 信息
         data:{
             user_id:user_id, # 用户id
             head_portrait:head_portrait, # 头像
             user_group:user_group, # 用户组
             exp:exp, #经验
             nickname:nickname, # 昵称
         }
     }
     ```
4. 

#### Question 问题

1. 添加问题 add_question
   - 接口 `/api/account/add_question()`

   - 参数 `token`-token `title`-标题 `discription`-描述 

   - 返回值

     ```python
     {
         code: code,       	# 0=用户不存在 -1=无法添加问题 1=成功
         msg: msg,        	# 信息
     }
     ```

2. 获取回答列表 get_answer_list
   - 接口 `/api/question/get_answer_list()`

   - 参数 `question_id`-问题id 

   - 返回值

     ```python
     {
         code: code,       	# 0=问题不存在 1=成功
         msg: msg,        	# 信息
         data:[{
             id:id, # 回答id 
             user_id:user_id, # 用户id 
             content:content, # 回答内容
             edit_time:edit_time, # 编辑时间
             agree:agree, # 点赞数
             disagree:disagree, # 点踩数
             answer_type:answer_type, # 回答种类
             question_id:question_id # 问题id
         },
             # ...
         ]
     }
     ```

3. 

#### Answer 回答

1. 添加回答 add_answer
   - 接口 `/api/account/add_answer()`

   - 参数 `question_id`-问题id `token`-token `content`-内容 `answer_type`-回答类型

   - 返回值

     ```python
     {
         code: code,       	# 0=未知用户 -1=未知问题 -2=无法添加回答 1=成功
         msg: msg,        	# 信息
     }
     ```

2. 获取回答信息 get_answer
   - 接口 `/api/account/get_answer()`

   - 参数 `answer_id`-回答id 

   - 返回值

     ```python
     {
         code: code,       	# 0=问题不存在 1=成功
         msg: msg,        	# 信息
         data:{
             id:id, # 回答id 
             user_id:user_id, # 用户id 
             content:content, # 回答内容
             edit_time:edit_time, # 编辑时间
             agree:agree, # 点赞数
             disagree:disagree, # 点踩数
             answer_type:answer_type, # 回答种类
             question_id:question_id # 问题id
         }
     }
     ```

3. 获取回答评论列表 get_answer_comment_list
   - 接口 `/api/account/get_answer_comment_list()`

   - 参数 `answer_id`-回答id 

   - 返回值

     ```python
     {
         code: code,       	# 0=未知回答 1=成功
         msg: msg,        	# 信息
         data:[{
             user_id:user_id, # 用户id
             content:content, # 内容
             create_time:create_time, # 发表时间
             agree:agree # 赞同数
         },
         	# ...
         ]
     }
     ```

4. 添加回答评论 add_answer_comment
   - 接口 `/api/account/add_answer_comment()`

   - 参数 `answer_id`-问题id `token`-token `content`-内容 

   - 返回值

     ```python
     {
         code: code,       	# 0=未知用户 -1=未知回答 -2=无法添加评论 1=成功
         msg: msg,        	# 信息
     }
     ```

5. 点赞回答 agree_answer
   - 接口 `/api/account/agree_answer()`

   - 参数 `answer_id`-问题id `token`-token 

   - 返回值

     ```python
     {
         code: code,    # 0=未知用户 -1=未知答案 -2=不能记录用户行为 -3=不能更新点赞数 1=成功
         msg: msg,      # 信息
     }
     ```

6. 点赞回答评论 agree_answer_comment
   - 接口 `/api/account/agree_answer_comment()`

   - 参数 `comment_id`-评论id `token`-token 

   - 返回值

     ```python
     {
         code: code,    # 0=未知用户 -1=未知答案 -2=不能记录用户行为 -3=不能更新点赞数 1=成功
         msg: msg,      # 信息
     }
     ```

7. 点踩回答 disagree_answer
   - 接口 `/api/account/disagree_answer()`

   - 参数 `answer_id`-问题id `token`-token 

   - 返回值

     ```python
     {
         code: code,    # 0=未知用户 -1=未知答案 -2=不能记录用户行为 -3=不能更新点赞数 1=成功
         msg: msg,      # 信息
     }
     ```

8. 


## 数据库 DataBase

### 用户行为类型约定 TypeFormat

| 代码 | 释义             | 备注 |
| ---- | ---------------- | ---- |
| 1    | 对答案点赞       |      |
| 2    | 对答案点踩       |      |
| 3    | 对答案的评论点赞 |      |

