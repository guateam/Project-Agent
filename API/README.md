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

1. ##### 用户登录 login

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

2. ##### 用户注册 register

   - 接口 `/api/account/register()`

   - 参数 `email`-邮箱 `password`-密码

   - 返回值

     ```python
     {
         code: code,       	# -1=用户已存在 1=成功
         msg: msg,        	# 信息
     }
     ```

3. ##### 获取用户信息 get_user

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
             user_group:{
                 text:text,
                 value:value
             }, # 用户组
             exp:exp, #经验
             nickname:nickname, # 昵称
             level:leve, # 等级
             answer:answer, # 回答数
             follow:follow, # 关注数
             fans:fans, # 粉丝数
         }
     }
     ```

4. ##### 检查邮箱是否已经被注册 check_email

   - 接口 `/api/account/check_email()`

   - 参数 无

   - 返回值

   ```python
   {
       code: code,         # 0=邮箱已经被注册  1=邮箱可以注册
       msg: msg,           # 信息
   }
   ```

5. ##### 添加用户行为 add_user_action

   - 接口 `/api/account/add_user_action()`

   - 参数 `token`-token `action_type`-行为类型 `target_id`-行为目标

   - 返回值

   ```python
   {
       code: code,         # 0=未知用户 -1=无法写入 1=成功
       msg: msg,           # 信息
       
   }
   ```

6. ##### 根据token获取用户信息 get_user_by_token

   - 接口 `/api/account/get_user_by_token()`

   - 参数 `token`-token

   - 返回值

     ```python
     {
         code: code,       	# 0=用户不存在 1=成功
         msg: msg,        	# 信息
         data:{
             user_id:user_id, # 用户id
             head_portrait:head_portrait, # 头像
             user_group:{
                 text:text,
                 value:value
             }, # 用户组
             exp:exp, #经验
             nickname:nickname, # 昵称
             level:leve, # 等级
             answer:answer, # 回答数
             follow:follow, # 关注数
             fans:fans, # 粉丝数
         }
     }
     ```

7. ##### 关注某个用户 follow_user

8. ##### 实名认证 verify

   - 接口 `/api/account/verify()`

   - 参数 `X-Token`-token `user_id`-用户ID  `real_name`-真实姓名 `birthday`-生日 `gender`-性别 `number`-身份证号码 `address`-地址 `nationality`-名族

   - 返回值

   ```python
   {
       code: code,         # 0=未知用户 -1=无法写入 1=成功
       msg: msg,           # 信息
       
   }
   ```

9. ##### 实名认证不通过 not_verify

   - 接口 `/api/account/not_verify()`

   - 参数 `X-Token`-token `user_id`-用户ID

   - 返回值

   ```python
   {
       code: code,         # 0=未知用户 -1=无法写入 1=成功
       msg: msg,           # 信息
       
   }
   ```

10. ##### 获取积分变动 get_exp_change

    - 接口 `/api/account/get_exp_change()`

    - 参数 `token`-token 

    - 返回值

    ```python
    {
        code: code,         # 0=未知用户 1=成功
        msg: msg,           # 信息
        data:[
            {
                id:id， # id
                time:time, # 时间
                value:value, # 变动值
                userID:userID, # 用户ID
                description:description, # 
            },
            #...
        ]
    }
    ```


11. ##### 设置积分变动 set_exp_change

    - 接口 `/api/account/set_exp_change()`

    - 参数 `token`-token `value`-变动值 `description`-描述

    - 返回值

    ```python
    {
        code: code,         # 0=未知用户 -1=无法写入 1=成功
        msg: msg,           # 信息
       
    }
    ```

12. ##### 后台获取所有用户列表 back_get_users

    - 接口 `/api/account/back_get_users()`

    - 参数 `X-Token`-token

    - 返回值

      ```python
      {
          code: code,       	# 0=用户不存在 1=成功
          msg: msg,        	# 信息
          data:[
              {
                  user_id:user_id, # 用户id
              	head_portrait:head_portrait, # 头像
              	user_group:{
                  	text:text,
                  	value:value
              	}, # 用户组
              	exp:exp, #经验
              	nickname:nickname, # 昵称
              	level:leve, # 等级
              	answer:answer, # 回答数
              	follow:follow, # 关注数
              	fans:fans, # 粉丝数
              },
              # ...
          ]
      }
      ```


13. ##### 后台获取一般从业者列表 back_get_normal_users

    - 接口 `/api/account/back_get_normal_users()`

    - 参数 `X-Token`-token

    - 返回值

      ```python
      {
          code: code,       	# 0=用户不存在 1=成功
          msg: msg,        	# 信息
          data:{
              all:[
              	{
                  	user_id:user_id, # 用户id
              		head_portrait:head_portrait, # 头像
              		user_group:{
                  		text:text,
                  		value:value
              		}, # 用户组
              		exp:exp, #经验
              		nickname:nickname, # 昵称
              		level:leve, # 等级
              		answer:answer, # 回答数
              		follow:follow, # 关注数
              		fans:fans, # 粉丝数
              	},
              	# ...
          	],
              un_identity:[
              	{
                  	user_id:user_id, # 用户id
              		head_portrait:head_portrait, # 头像
              		user_group:{
                  		text:text,
                  		value:value
              		}, # 用户组
              		exp:exp, #经验
              		nickname:nickname, # 昵称
              		level:leve, # 等级
              		answer:answer, # 回答数
              		follow:follow, # 关注数
              		fans:fans, # 粉丝数
              	},
              	# ...
          	],
              wait:[
              	{
                  	user_id:user_id, # 用户id
              		head_portrait:head_portrait, # 头像
              		user_group:{
                  		text:text,
                  		value:value
              		}, # 用户组
              		exp:exp, #经验
              		nickname:nickname, # 昵称
              		level:leve, # 等级
              		answer:answer, # 回答数
              		follow:follow, # 关注数
              		fans:fans, # 粉丝数
              	},
              	# ...
          	],
              confirm:[
              	{
                  	user_id:user_id, # 用户id
              		head_portrait:head_portrait, # 头像
              		user_group:{
                  		text:text,
                  		value:value
              		}, # 用户组
              		exp:exp, #经验
              		nickname:nickname, # 昵称
              		level:leve, # 等级
              		answer:answer, # 回答数
              		follow:follow, # 关注数
              		fans:fans, # 粉丝数
              	},
              	# ...
          	],
              refuse:[
              	{
                  	user_id:user_id, # 用户id
              		head_portrait:head_portrait, # 头像
              		user_group:{
                  		text:text,
                  		value:value
              		}, # 用户组
              		exp:exp, #经验
              		nickname:nickname, # 昵称
              		level:leve, # 等级
              		answer:answer, # 回答数
              		follow:follow, # 关注数
              		fans:fans, # 粉丝数
              	},
              	# ...
          	]
          }
      }
      ```


14. ##### 后台获取专家列表 back_get_specialist_users

    - 接口 `/api/account/back_get_sepcialist_users()`

    - 参数 `X-Token`-token

    - 返回值

      ```python
      {
          code: code,       	# 0=用户不存在 1=成功
          msg: msg,        	# 信息
          data:{
              all:[
              	{
                  	user_id:user_id, # 用户id
              		head_portrait:head_portrait, # 头像
              		user_group:{
                  		text:text,
                  		value:value
              		}, # 用户组
              		exp:exp, #经验
              		nickname:nickname, # 昵称
              		level:leve, # 等级
              		answer:answer, # 回答数
              		follow:follow, # 关注数
              		fans:fans, # 粉丝数
              	},
              	# ...
          	],
              wait:[
              	{
                  	user_id:user_id, # 用户id
              		head_portrait:head_portrait, # 头像
              		user_group:{
                  		text:text,
                  		value:value
              		}, # 用户组
              		exp:exp, #经验
              		nickname:nickname, # 昵称
              		level:leve, # 等级
              		answer:answer, # 回答数
              		follow:follow, # 关注数
              		fans:fans, # 粉丝数
              	},
              	# ...
          	],
              confirm:[
              	{
                  	user_id:user_id, # 用户id
              		head_portrait:head_portrait, # 头像
              		user_group:{
                  		text:text,
                  		value:value
              		}, # 用户组
              		exp:exp, #经验
              		nickname:nickname, # 昵称
              		level:leve, # 等级
              		answer:answer, # 回答数
              		follow:follow, # 关注数
              		fans:fans, # 粉丝数
              	},
              	# ...
          	],
          }
      }
      ```


15. ##### 后台获取企业列表 back_get_enterprise_user
    - 接口 `/api/account/back_get_enterprise_users()`

    - 参数 `X-Token`-token

    - 返回值

      ```python
      {
          code: code,       	# 0=用户不存在 1=成功
          msg: msg,        	# 信息
          data:{
              all:[
              	{
                  	user_id:user_id, # 用户id
              		head_portrait:head_portrait, # 头像
              		user_group:{
                  		text:text,
                  		value:value
              		}, # 用户组
              		exp:exp, #经验
              		nickname:nickname, # 昵称
              		level:leve, # 等级
              		answer:answer, # 回答数
              		follow:follow, # 关注数
              		fans:fans, # 粉丝数
              	},
              	# ...
          	],
              wait:[
              	{
                  	user_id:user_id, # 用户id
              		head_portrait:head_portrait, # 头像
              		user_group:{
                  		text:text,
                  		value:value
              		}, # 用户组
              		exp:exp, #经验
              		nickname:nickname, # 昵称
              		level:leve, # 等级
              		answer:answer, # 回答数
              		follow:follow, # 关注数
              		fans:fans, # 粉丝数
              	},
              	# ...
          	],
              confirm:[
              	{
                  	user_id:user_id, # 用户id
              		head_portrait:head_portrait, # 头像
              		user_group:{
                  		text:text,
                  		value:value
              		}, # 用户组
              		exp:exp, #经验
              		nickname:nickname, # 昵称
              		level:leve, # 等级
              		answer:answer, # 回答数
              		follow:follow, # 关注数
              		fans:fans, # 粉丝数
              	},
              	# ...
          	],
          }
      }
      ```

16. ##### 确认专家认证申请 confirm_specialist

    - 接口 `/api/account/comfirm_specialist()`

    - 参数 `X-Token`-token `user_id`-用户ID

    - 返回值

    ```python
    {
        code: code,         # 0=未知用户 -1=无法写入 1=成功
        msg: msg,           # 信息
       
    }
    ```


17. ##### 拒绝专家认证申请 refuse_specialist
    - 接口 `/api/account/refuse_specialist()`

    - 参数 `X-Token`-token `user_id`-用户ID

    - 返回值

    ```python
    {
        code: code,         # 0=未知用户 -1=无法写入 1=成功
        msg: msg,           # 信息
       
    }
    ```

18. ##### 确认企业认证申请 confirm_enterprise
    - 接口 `/api/account/comfirm_enterprise()`

    - 参数 `X-Token`-token `user_id`-用户ID

    - 返回值

    ```python
    {
        code: code,         # 0=未知用户 -1=无法写入 1=成功
        msg: msg,           # 信息
       
    }
    ```

19. ##### 拒绝企业认证申请 refuse_enterprise
    - 接口 `/api/account/refuse_enterprise()`

    - 参数 `X-Token`-token `user_id`-用户ID

    - 返回值

    ```python
    {
        code: code,         # 0=未知用户 -1=无法写入 1=成功
        msg: msg,           # 信息
       
    }
    ```

20. ##### 清除用户 delete_user
    - 接口 `/api/account/delete_user()`

    - 参数 `X-Token`-token `user_id`-用户ID

    - 返回值

    ```python
    {
        code: code,         # 0=未知用户 -1=无法写入 1=成功
        msg: msg,           # 信息
       
    }
    ```

21. ##### 修改用户信息 change_user
    - 接口 `/api/account/comfirm_specialist()`

    - 参数 `X-Token`-token `user_id`-用户ID `nickname`-用户昵称 `headportrait`-头像 `usergroup`-用户组 `exp`-经验

    - 返回值

    ```python
    {
        code: code,         # 0=未知用户 -1=无法写入 1=成功
        msg: msg,           # 信息
       
    }
    ```

22. ##### 获取钱包余额 get_account_balance

23. ##### 增加钱包余额 add_account_balance

24. ##### 减少钱包余额 minus_account_balance

25. ##### 获取用户支付记录 history_pay

26. 
#### Question 问题

1. ##### 添加问题 add_question

   - 接口 `/api/account/add_question()`

   - 参数 `token`-token `title`-标题 `discription`-描述 

   - 返回值

     ```python
     {
         code: code,       	# 0=用户不存在 -1=无法添加问题 1=成功
         msg: msg,        	# 信息
     }
     ```

2. ##### 获取回答列表 get_answer_list

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

3. ##### 获取问题列表 get_questions

   - 接口 `/api/question/get_questions()`

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

4. ##### 通过id获取问题 get_question

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

5. ##### 添加问题评论 add_question_comment

   - 接口 `/api/question/add_question_comment()`

   - 参数 `question_id`-问题id `token`-token `content`-内容 

   - 返回值

     ```python
     {
         code: code,       	# 0=未知用户 -1=未知问题 -2=无法添加评论 1=成功
         msg: msg,        	# 信息
     }
     ```

6. ##### 获取问题评论 get_question_comment

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

7. ##### 添加付费问题 add_priced_question
    - 接口 `/api/questions/add_priced_question()`

    - 参数 `token`-token  `title`-标题 `discription`-描述  `price`-悬赏价格 `allowed_user`-允许参加的用户

    - 返回值

    ```python
    {
        code: code,         # 0=未知用户 -1=无法写入 1=成功
        msg: msg,           # 信息
       
    }
    ```

8. ##### 采纳回答 adpot_answer
    - 接口 `/api/questions/adopt_answer()`

    - 参数 `token`-token  `answer_id`-回答ID 

    - 返回值

    ```python
    {
        code: code,         # 0=未知用户 -4=不能找到回答 -3=不能找到问题 -2=未知答题人 -1=无法写入 1=成功
        msg: msg,           # 信息
       
    }
    ```

9. ##### 关注问题 follow_question

10. ##### 获取付费问题回答列表 get_priced_answer_list

11. ##### 为查看付费问题付费 pay_question

12. ##### 赞同问题的评论 agree_question_comment
    - 接口 `/api/questions/agree_question_comment()`

    - 参数 `token`-token  `comment_id`-评论ID

    - 返回值

    ```python
    {
        code: code,         # 0=未知用户 -1=未知评论 -2=不能记录用户行为 -3=不能更新点赞数 1=成功
        msg: msg,           # 信息
       
    }
    ```

13. ##### 后台获取问题列表 back_get_questions
     - 接口 `/api/questions/back_get_questions()`

     - 参数 `token`-token  

     - 返回值

     ```python
     {
         code: code,         # 0=未知用户 1=成功
         msg: msg,           # 信息
         data:[
             {
                 questionID:questionID, # 问题ID
                 title:title, # 标题
                 description:description, # 描述
                 edittime:edittime, # 编辑时间
                 userID:userID, # 用户ID
                 tags:tags, # tag
                 nickname:nickname, # 昵称
                 headportrait:headportrait, # 头像
                 usergroup:usergroup, # 用户组
                 exp:exp, # 经验
                 state:state, # 状态
             },
             # ...
         ]
     }
     ```

14. ##### 清除问题 delete_question
    - 接口 `/api/questions/delete_question()`

    - 参数 `token`-token  `question_id`-问题ID

    - 返回值

    ```python
    {
        code: code,         # 0=未知用户 -1=无法写入 1=成功
        msg: msg,           # 信息
       
    }
    ```

15. 

#### Answer 回答

1. ##### 添加回答 add_answer

   - 接口 `/api/answer/add_answer()`

   - 参数 `question_id`-问题id `token`-token `content`-内容 `answer_type`-回答类型

   - 返回值

     ```python
     {
         code: code,       	# 0=未知用户 -1=未知问题 -2=无法添加回答 1=成功
         msg: msg,        	# 信息
     }
     ```

2. ##### 获取回答信息 get_answer

   - 接口 `/api/answer/get_answer()`

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

3. ##### 获取回答评论列表 get_answer_comment_list

   - 接口 `/api/answer/get_answer_comment_list()`

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

4. ##### 添加回答评论 add_answer_comment

   - 接口 `/api/answer/add_answer_comment()`

   - 参数 `answer_id`-回答id `token`-token `content`-内容 

   - 返回值

     ```python
     {
         code: code,       	# 0=未知用户 -1=未知回答 -2=无法添加评论 1=成功
         msg: msg,        	# 信息
     }
     ```

5. ##### 点赞回答 agree_answer

   - 接口 `/api/answer/agree_answer()`

   - 参数 `answer_id`-回答id `token`-token 

   - 返回值

     ```python
     {
         code: code,    # 0=未知用户 -1=未知答案 -2=不能记录用户行为 -3=不能更新点赞数 1=成功
         msg: msg,      # 信息
     }
     ```

6. ##### 点赞回答评论 agree_answer_comment

   - 接口 `/api/answer/agree_answer_comment()`

   - 参数 `comment_id`-评论id `token`-token 

   - 返回值

     ```python
     {
         code: code,    # 0=未知用户 -1=未知答案 -2=不能记录用户行为 -3=不能更新点赞数 1=成功
         msg: msg,      # 信息
     }
     ```

7. ##### 点踩回答 disagree_answer

   - 接口 `/api/answer/disagree_answer()`

   - 参数 `answer_id`-回答id `token`-token 

   - 返回值

     ```python
     {
         code: code,    # 0=未知用户 -1=未知答案 -2=不能记录用户行为 -3=不能更新点赞数 1=成功
         msg: msg,      # 信息
     }
     ```

8. ##### 收藏回答 collect_answer

9. ##### 编辑回答 edit_answer

10. ##### 举报回答 complain

11. ##### 后台获取所有回答 back_get_answers
     - 接口 `/api/answer/back_get_answers()`

     - 参数 `token`-token

     - 返回值

     ```python
     {
         code: code,         # 0=未知用户 1=成功
         msg: msg,           # 信息
         data:[
             {
                 answerID:answerID, # 回答ID
                 questionID:questionID, # 问题ID
                 edittime:edittime, # 编辑时间
                 content:content, # 回答内容
                 answertype:answertype, # 回答种类
                 agree:agree, # 赞同数
                 disagree:disagree, # 不赞同数
                 userID:userID, # 用户ID
                 tags:tags, # tag
                 nickname:nickname, # 昵称
                 headportrait:headportrait, # 头像
                 usergroup:usergroup, # 用户组
                 exp:exp, # 经验
                 state:state, # 状态
             },
             # ...
         ]
     }
     ```

12. ##### 清除回答 delete_answer
    - 接口 `/api/answer/delete_answer()`

    - 参数 `token`-token  `answer_id`-问题ID

    - 返回值

    ```python
    {
        code: code,         # 0=未知用户 -1=无法写入 1=成功
        msg: msg,           # 信息
       
    }
    ```

13. 

#### Article 文章

1. ##### 添加文章 add_article

2. ##### 编辑文章 edit_article

3. ##### 收藏文章 collect_article

4. ##### 后台获取文章 back_get_articles
     - 接口 `/api/article/back_get_articles()`

     - 参数 `token`-token

     - 返回值

     ```python
     {
         code: code,         # 0=未知用户 1=成功
         msg: msg,           # 信息
         data:[
             {
                 articleID:articleID, # 回答ID
                 title:title, # 标题
                 edittime:edittime, # 编辑时间
                 content:content, # 回答内容
                 userID:userID, # 用户ID
                 tags:tags, # tag
                 nickname:nickname, # 昵称
                 headportrait:headportrait, # 头像
                 usergroup:usergroup, # 用户组
                 exp:exp, # 经验
                 state:state, # 状态
             },
             # ...
         ]
     }
     ```

5. ##### 清除文章 delete_article
    - 接口 `/api/article/delete_article()`

    - 参数 `token`-token  `article_id`-问题ID

    - 返回值

    ```python
    {
        code: code,         # 0=未知用户 -1=无法写入 1=成功
        msg: msg,           # 信息
       
    }
    ```

#### Homepage 首页

1. ##### 获取推荐 get_recommend

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

2. ##### 获取分类 get_category

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

3. ##### 获取热搜 get_hot_search

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

1. ##### 获取信息列表 get_message_list

   - 这个接口估计要改，暂时废弃

2. ##### 发送信息 add_message

   - 接口 `/api/message/add_message()`

   - 参数 `token`-token  `receiver`-收件人 `content`-内容 `message_type`-信息种类

   - 返回值

     ```python
     {
         code: code,    # 0=未知用户 -1=无法录入 1=成功
         msg: msg,      # 信息
     }
     ```

3. ##### 获取聊天室信息 get_chat_box

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

4. ##### 获取好友列表 get_friend_list

5. ##### 获取点赞列表 get_agree_list

6. ##### 获取@列表 get_at_list

7. ##### 发送系统通知 add_sys_notice

8. ##### 获取系统消息 get_sys_message

9. ##### 获取某用户的私信 get_message

10. 

#### Upload 上传

1. ##### 上传图片 upload_picture

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

2. ##### 上传身份证 upload_identity_card

3. 

#### Algorithm 算法

1. ##### 调用item cf算法推荐 item_cf_api

2. ##### 建立文章的评分矩阵 build_article_rate_rect

3. 

#### Specialist 专家

1. ##### 获取自己的回答 get_my_answers

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

2. ##### 获取自己的文章 get_my_articles

3. ##### 获取自己的粉丝列表 get_my_fans

4. ##### 获取付费预约的列表 get_order_list

5. ##### 确认预约 confirm_order

6. ##### 拒绝预约 refuse_order

7. ##### 获取点击量图表 get_click_info

8. ##### 获取关注量增减图表 get_fans_info

9. ##### 预约付费咨询 add_order

10. ##### 申请升级为专家 request_upgrade

11. 

#### Enterprise 企业

1. ##### 添加需求 add_demand

2. ##### 获取自己的需求列表 get_my_demands

3. ##### 获取报名该需求的用户列表 get_signed_users

4. ##### 确认报名的用户 confirm_signed_user

5. ##### 拒绝报名的用户 refuse_signed_user

6. ##### 结束需求 close_demand

7. ##### 开始需求 start_demand

8. ##### 申请升级为企业账户 request_enterprise_upgrade

9. 

#### Board 告示板

1. ##### 报名需求 sign_to_demand

2. 

## 数据库 DataBase

### 类型约定 Format

#### 用户行为类型约定 TypeFormat

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

#### 问题回答等状态类型约定 StateFormat
| 代码 | 释义 | 备注 |
| ---- | ---- | ---- |
| -1   | 清除 |      |
| 0   | 正常  |      |

#### 付费咨询预约类型约定 OrderStateFormat

| 代码 | 释义   | 备注 |
| ---- | ------ | ---- |
| 0    | 已预约 |      |
| 1    | 已确认 |      |
| 2    | 已完成 |      |
| -1   | 已拒绝 |      |

#### 需求类型约定 DemandStateFormat

| 代码 | 释义     | 备注 |
| ---- | -------- | ---- |
| 0    | 招标中   |      |
| 1    | 项目开始 |      |
| 2    | 项目结束 |      |
| -1   | 被清除   |      |

#### 报名类型约定 RegisterStateFormat

| 代码 | 释义   | 备注 |
| ---- | ------ | ---- |
| 0    | 已报名 |      |
| 1    | 已确认 |      |
| -1   | 已拒绝 |      |

#### 回答类型约定 AnswerTypeFormat

| 代码 | 释义         | 备注 |
| ---- | ------------ | ---- |
| 0    | 普通回答     |      |
| 1    | 付费回答     |      |
| 2    | 被采纳的回答 |      |

#### 问题类型约定 QuestionTypeFormat

| 代码 | 释义     | 备注 |
| ---- | -------- | ---- |
| 0    | 普通问题 |      |
| 1    | 收费问题 |      |
|      |          |      |

#### 交易类型约定 PayTypeFormat

| 代码 | 释义         | 备注 |
| ---- | ------------ | ---- |
| 1    | 付费回答     |      |
| 2    | 专家咨询     |      |
| 3    | 告示板需求   |      |

#### 用户组类型约定 UserGroupFormat

| 代码 | 释义         | 备注 |
| ---- | ------------ | ---- |
| 0    | 管理员       |      |
| 1    | 一般从业者   |      |
| 2    | 专家         |      |
| 3    | 企业         |      |
| 4    | 封禁         |      |
| 5    | 待审核的专家 |      |
| 6    | 待审核的企业 |      |

#### 用户状态类型约定 UserStateFormat

| 代码 | 释义     | 备注 |
| ---- | -------- | ---- |
| 0    | 未实名   |      |
| 1    | 待审核   |      |
| 2    | 已实名   |      |
| 3    | 认证失败 |      |

#### 系统消息类型约定 SysMessageFormat

| 代码 | 释义     | 备注                 |
| ---- | -------- | -------------------- |
| 0    | 全体消息 |                      |
| 1    | 个人消息 | 类似系统单独通知内容 |
|      |          |                      |

#### 标签类型约定 TagTypeFormat

| 代码 | 释义     | 备注 |
| ---- | -------- | ---- |
| 0    | 其他     |      |
| 1    | 初级标签 |      |
| 2    | 次级标签 |      |

