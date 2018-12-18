# API接口文档

[TOC]

## 任务列表 Task

1. 首页搜索框

   - 需求
     - 在搜索框中显示随机热门搜索内容
     - 问题与设想
       - 从item-cf算法获取感兴趣的内容还是使用热搜
       - 设想：采用热搜，提供完善用户模型的地方
   - 预览

   ![api_task_1](..\img\api_task_1.png)

2. 首页分类获取

   - 需求

     - 分发首页领域分类
     - 问题与设想
       - 分类是由后台指定分类还是由用户制定
       - 需不需要小分类来细化分类
       - 设想：采用大分类后台制定，小分类用户添加的操作

   - 预览

     ![api_task_2](..\img\api_task_2.png)

     ![](..\img\api_task_4.png)

3. 首页推荐算法与接口

   - 需求

     - 获取用户模型推荐感兴趣信息
     - 问题与设想
       - 采用item-cf 算法解决
       - 需要对专业领域进行分析

   - 预览

     ![](..\img\api_task_3.png)

4. 

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
    numpy == 1.15.4
    jieba == 0.39
    tensorflow == 1.12.0
    tensorboard == 1.12.1
    sklearn == 0.0
    
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

3. 获取问题列表 get_questions
   - 接口 `/api/question/get_questions()`**错误，待修改**

   - 返回值

     ```python
     {
         code: code,       	# 0=失败 1=成功
         msg: msg,        	# 信息
         data:[{
             questionID:id, # 回答id 
             userID:user_id, # 用户id 
             title:tile, # 标题
             description:description, # 描述
             edittime:edittime, # 编辑时间
             tags:tags, # 标签
         },
             # ...
         ]
     }
     ```

4. 通过id获取问题 get_question
   - 接口 `/api/question/get_question()`

   - 参数 `question_id`-问题id 

   - 返回值

     ```python
     {
         code: code,       	# 0=未知问题 -1=未知提问人 1=成功
         msg: msg,        	# 信息
         data:{
             question_id:id, # 回答id 
             user_id:user_id, # 用户id 
             user_nickname:user_nickname, # 用户昵称
             user_headportrait:user_headportrait, # 用户头像
             title:tile, # 标题
             description:description, # 描述
             edittime:edittime, # 编辑时间
             tags:tags, # 标签
         }
     }
     ```

5. 

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
             user_nickname:user_nickname, # 用户昵称
             user_headportrait:user_headportrait, # 用户头像
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
             user_nickname:user_nickname, # 用户昵称
             user_headportrait:user_headportrait, # 用户头像
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

#### Homepage 首页

1. 获取推荐 get_recommend
   - 接口 `/api/homepage/get_recommend()`

   - 参数 `token`-token 

   - 返回值

     ```python
     {
         code: code,    # 0=未知用户 1=成功
         msg: msg,      # 信息
         data:[
             {
                 # 根据type决定
             }
             # ...
         ]
     }
     ```

2. 获取分类 get_category
   - 接口 `/api/homepage/get_category()` 

   - 返回值

     ```python
     {
         code: code,    # 0=未知问题 1=成功
         msg: msg,      # 信息
         data:[
             {
                 name:name, # 名称
                 id:id, # 分类id
             }
             # ...
         ]
     }
     ```

3. 获取热搜 get_hot_search
   - 接口 `/api/homepage/get_hot_search()`

   - 返回值

     ```python
     {
         code: code,    # 0=未知问题 1=成功
         msg: msg,      # 信息
         data:data      # 热搜内容
     }
     ```

4. 

#### Message 信息

1. 获取信息列表 get_message_list

   - 这个接口估计要改，暂时废弃

2. 发送信息 add_message
   - 接口 `/api/message/add_message()`

   - 参数 `token`-token  `receiver`-收件人 `content`-内容 `message_type`-信息种类

   - 返回值

     ```python
     {
         code: code,    # 0=未知用户 -1=无法录入 1=成功
         msg: msg,      # 信息
     }
     ```

3. 获取聊天室信息 get_chat_box
   - 接口 `/api/message/get_chat_box()`

   - 参数 `token`-token `user_id`-聊天室目标用户id

   - 返回值

     ```python
     {
         code: code,    # 0=未知用户 1=成功
         msg: msg,      # 信息
         data:[
             {
                 messageID:messageID, # 信息id
                 content:content, # 内容
                 poster:poster, # 发件人id
                 receiver:receiver, # 收件人id
                 type:type, # 信息类型
                 post_time:post_time # 发送时间
             }
             # ...
         ]
     }
     ```

4. 

## 数据库 DataBase

### 用户行为类型约定 TypeFormat

| 代码 | 释义             | 备注 |
| ---- | ---------------- | ---- |
| 1    | 对答案点赞       |      |
| 2    | 对答案点踩       |      |
| 3    | 对答案的评论点赞 |      |

