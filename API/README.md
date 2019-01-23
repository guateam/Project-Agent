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
             data: {
                 user_id: user_id,
                 head_portrait: head_portrait,
                 group: {text: text, value: value},
                 nickname: nickname,
                 level: level,
                 exp: exp,
                 answer: answer,
                 follow: follow,
                 fans: fans,
             },  	        # 用户信息
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

4. 检查邮箱是否已经被注册 check_email
   - 接口 `/api/account/check_email`

   - 参数 无

   - 返回值

   ```python
   {
       code: code,         # 0=邮箱已经被注册  1=邮箱可以注册
       msg: msg,           # 信息
   }
   ```

5. 添加用户行为 add_user_action
   - 接口 `/api/account/add_user_action`

   - 参数 `token`-token `action_type`-行为类型 `target_id`-行为目标

   - 返回值

   ```python
   {
       code: code,         # 0=未知用户 -1=无法写入 1=成功
       msg: msg,           # 信息
       
   }
   ```

6. 
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

5. 添加问题评论 add_question_comment
   - 接口 `/api/question/add_question_comment()`

   - 参数 `question_id`-问题id `token`-token `content`-内容 

   - 返回值

     ```python
     {
         code: code,       	# 0=未知用户 -1=未知问题 -2=无法添加评论 1=成功
         msg: msg,        	# 信息
     }
     ```

6. 获取问题评论 get_question_comment
   - 接口 `/api/question/get_question()`

   - 参数 `question_id`-问题id 

   - 返回值

     ```python
     {
         code: code,       	# 0=未知问题 1=成功
         msg: msg,        	# 信息
         data:{
             qcommentID:id, # 评论id
             userID:userID, # 用户id
             content:content, # 内容
             agree:agree, # 点赞数
             createtime:createtime, # 创建时间
             questionID:questionID, # 问题id
             nickname:nickname, # 昵称
             headportrait:headportrait, # 头像
             usergroup:usergroup, # 用户组
             exp:exp # 经验值
         }
     }
     ```

7. 

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

   - 参数 `answer_id`-回答id `token`-token `content`-内容 

   - 返回值

     ```python
     {
         code: code,       	# 0=未知用户 -1=未知回答 -2=无法添加评论 1=成功
         msg: msg,        	# 信息
     }
     ```

5. 点赞回答 agree_answer
   - 接口 `/api/account/agree_answer()`

   - 参数 `answer_id`-回答id `token`-token 

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

   - 参数 `answer_id`-回答id `token`-token 

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

#### Upload 上传

1. 上传图片 upload_picture
   - 接口 `/api/upload/upload_picture()`

   - 参数 `picture`-图片文件

   - 返回值

     ```python
     {
         code: code,    # 0=未知用户 1=成功
         msg: msg,      # 信息
         data:data      # 文件上传路径
     }
     ```

2. 

#### Specialist 专家

1. 获取自己的回答 get_my_answers

   - 接口 `/api/specialist/get_my_answers`

   - 参数 `token`-token

   - 返回值

     ```python
     {
         code: code,    # 0=未知用户 1=成功
         msg: msg,      # 信息
         data:[{
             answerID:answerID,
             userID:userID,
             edittime:edittime,
             content:content,
             agree:agree,
             disagree:disagree,
             answertype:answertype,
             questionID:questionID,
             nickname:nickname,
             headportrait:headportrait,
             tags:[{
                 text:text,
                 id:id
             }],
             state:state
         },
         	#...
         ]
     }
     ```

2. 

## 数据库 DataBase

### 用户行为类型约定 TypeFormat

| 代码 | 释义             | 备注 |
| ---- | ---------------- | ---- |
| 1    | 对答案点赞          |      |
| 2    | 对答案点踩          |      |
| 3    | 对答案的评论点赞     |      |
| 4    | 对答案的评论点踩     |      |
| 11   | 浏览问题            |      |
| 12   | 关注问题            |      |
| 13   | 回答问题            |      |
| 14   | 对问题的评论点赞     |      |
| 21   | 浏览文章            |      |
| 22   | 收藏文章            |      |
| 23   | 点赞文章            |      |
| 24   | 点踩文章            |      |
| 25   | 评论文章            |      |
| 26 | 管理员通过实名认证 | |
| 27 | 管理员不通过实名认证 | |
| 28 | 管理员通过专家认证 | |
| 29 | 管理员不通过专家认证 | |
| 30 | 管理员通过企业账户认证 | |
| 31 | 管理员不通过企业账户认证 | |
| 32 | 管理员封禁账户 | |

### 问题回答等状态类型约定 StateFormat
| 代码 | 释义 | 备注 |
| ---- | ---- | ---- |
| -1   | 清除 |      |
| 0   | 正常  |      |

### 付费咨询预约类型约定 OrderStateFormat

| 代码 | 释义   | 备注 |
| ---- | ------ | ---- |
| 0    | 已预约 |      |
| 1    | 已确认 |      |
| 2    | 已完成 |      |
| -1   | 已拒绝 |      |

### 需求类型约定 DemandStateFormat

| 代码 | 释义     | 备注 |
| ---- | -------- | ---- |
| 0    | 招标中   |      |
| 1    | 项目开始 |      |
| 2    | 项目结束 |      |

### 报名类型约定 RegisterStateFormat

| 代码 | 释义   | 备注 |
| ---- | ------ | ---- |
| 0    | 已报名 |      |
| 1    | 已确认 |      |
| -1   | 已拒绝 |      |

### 回答类型约定 AnswerTypeFormat

| 代码 | 释义         | 备注 |
| ---- | ------------ | ---- |
| 0    | 普通回答     |      |
| 1    | 付费回答     |      |
| 2    | 被采纳的回答 |      |

### 问题类型约定 QuestionTypeFormat

| 代码 | 释义     | 备注 |
| ---- | -------- | ---- |
| 0    | 普通问题 |      |
| 1    | 收费问题 |      |
|      |          |      |

### 交易类型约定 PayTypeFormat

| 代码 | 释义         | 备注 |
| ---- | ------------ | ---- |
| 1    | 付费回答     |      |
| 2    | 专家咨询     |      |
| 3    | 告示板需求   |      |

### 用户组类型约定 UserGroupFormat

| 代码 | 释义         | 备注 |
| ---- | ------------ | ---- |
| 0    | 管理员       |      |
| 1    | 一般从业者   |      |
| 2    | 专家         |      |
| 3    | 企业         |      |
| 4    | 封禁         |      |
| 5    | 待审核的专家 |      |
| 6    | 待审核的企业 |      |

### 用户状态类型约定 UserStateFormat

| 代码 | 释义     | 备注 |
| ---- | -------- | ---- |
| 0    | 未实名   |      |
| 1    | 待审核   |      |
| 2    | 已实名   |      |
| 3    | 认证失败 |      |

### 系统消息类型约定 SysMessageFormat

| 代码 | 释义     | 备注                 |
| ---- | -------- | -------------------- |
| 0    | 全体消息 |                      |
| 1    | 个人消息 | 类似系统单独通知内容 |
|      |          |                      |

