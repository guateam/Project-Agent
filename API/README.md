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

    - 接口 `/api/account/back_get_specialist_users()`

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
    - 接口 `/api/account/get_account_balance()`

    - 参数 `token`-token 

    - 返回值

    ```python
    {
        code: code,         # 0=未知用户 1=成功
        msg: msg,           # 信息
        data: data          # 余额
    }
    ```

23. ##### 增加钱包余额 add_account_balance
    - 接口 `/api/account/add_account_balance()`

    - 参数 `num`-增加量 `token`-token 

    - 返回值

    ```python
    {
        code: code,         # -2=用户不存在 0=数据库操作失败 1=成功
        msg: msg,           # 信息
    }
    ```

24. ##### 减少钱包余额 minus_account_balance
    - 接口 `/api/account/minus_account_balance()`

    - 参数 `num`-减少量 `token`-token 

    - 返回值

    ```python
    {
        code: code,         # -2=用户不存在 -1=余额不足 
                            #  0=数据库操作失败 1=成功
        msg: msg,           # 信息
    }
    ```

25. ##### 获取用户支付记录 history_pay
    - 接口 `/api/account/history_pay()`

    - 参数 `token`-token 

    - 返回值

    ```python
    {
        code: code,         # 0=用户不存在 1=成功
        msg: msg,           # 信息
        data: data,         # 支付记录
    }
    ```


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
    - 接口 `/api/questions/follow_question()`

    - 参数 `question_id`-问题的id `token`-token 

    - 返回值

    ```python
    {
        code: code,         # -2=用户不存在 -1=问题不存在  0=关注失败
                            # 1=成功
        msg: msg,           # 信息
    }
    ```

10. ##### 获取付费问题回答列表 get_priced_answer_list
    - 接口 `/api/questions/add_priced_answer_list()`

    - 参数 `question_id`-问题ID  `token`-token 

    - 返回值

    ```python
    {
        code: code,         # -2=问题不存在 -1=用户不存在 
                            # 0=数据库操作失败 1=成功
        msg: msg,           # 信息
    }
    ```

11. ##### 为查看付费问题付费 pay_question
    - 接口 `/api/questions/pay_question()`

    - 参数 `question_id`-问题ID  `token`-token 

    - 返回值

    ```python
    {
        code: code,         # -5=退钱失败   -4=创建支付记录失败
                            # -3=问题不存在 -2=用户不存在 
                            # -1=余额不足   0 =支付失败         1=成功
        msg: msg,           # 信息
    }
    ```

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
    - 接口 `/api/answer/collect_answer()`

    - 参数 `answer_id`-回答ID  `token`-token 

    - 返回值

    ```python
    {
        code: code,         # -1=回答不存在 -2=用户不存在 
                            # 0=关注失败 1=成功
        msg: msg,           # 信息
    }
    ```

9. ##### 编辑回答 edit_answer
    - 接口 `/api/answer/edit_answer()`

    - 参数 `answer_id`-回答ID  `content`-修改的内容

    - 返回值

    ```python
    {
        code: code,         # -1=回答不存在 0=编辑失败  1=成功 
        msg: msg,           # 信息
    }
    ```

10. ##### 举报评论 complain
   - 接口 `/api/answer/complain()`

    - 参数 `token`-token  `id`-评论的ID

    - 返回值

    ```python
    {
        code: code,         # -2=举报失败 -1=未知评论，0=用户不存在 1=举报成功 
        msg: msg,           # 信息
    }
    ```
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
    - 接口 `/api/article/add_article()`

    - 参数 `token`-token  `content`-文章内容  `title`-文章标题

    - 返回值

    ```python
    {
        code: code,         # -1=未知用户 0=添加失败 1=成功
        msg: msg,           # 信息
       
    }
    ```

2. ##### 编辑文章 edit_article
    - 接口 `/api/article/edit_article()`

    - 参数 `token`-token  `content`-文章内容  `title`-文章标题  `article_id`-文章ID

    - 返回值

    ```python
    {
        code: code,         # -1=文章不存在 0=修改失败 1=成功
        msg: msg,           # 信息
       
    }
    ```

3. ##### 收藏文章 collect_article
    - 接口 `/api/article/collect_article()`

    - 参数 `token`-token  `article_id`-文章内容 

    - 返回值

    ```python
    {
        code: code,         # -2=用户不存在 -1=文章不存在 0=收藏失败 1=成功
        msg: msg,           # 信息
       
    }
    ```

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
   - 接口 `/api/message/get_friend_list()`

   - 参数 `token`-token  

   - 返回值

     ```python
     {
         code: code,    # 0=未知用户 1=成功
         msg: msg,      # 信息
         data: data     # 好友列表
     }
     ```

5. ##### 获取点赞列表 get_agree_list
   - 接口 `/api/message/get_agree_list()`

   - 参数 `token`-token  

   - 返回值

     ```python
     {
         code: code,    # 0=未知用户 1=成功
         msg: msg,      # 信息
         data: data     # 点赞列表
     }
     ```
6. ##### 获取@列表 get_at_list
   - 接口 `/api/message/get_at_list()`

   - 参数 `token`-token  

   - 返回值

     ```python
     {
         code: code,    # 0=未知用户 1=成功
         msg: msg,      # 信息
         data: data     # @列表
     }
     ```
7. ##### 发送系统通知 add_sys_notice
   - 接口 `/api/message/add_sys_notice()`

   - 参数 `token`-token  `content`-内容  `type`-类型  `target`-目标

   - 返回值

     ```python
     {
         code: code,    # -2=无法添加 -1=权限不足 0=未知用户 1=成功
         msg: msg,      # 信息
     }
     ```
8. ##### 获取系统消息 get_sys_message
   - 接口 `/api/message/get_sys_message()`

   - 参数 `token`-token  

   - 返回值

     ```python
     {
         code: code,    # 0=未知用户 1=成功
         msg: msg,      # 信息
         data: data     # 系统消息
     }
     ```
9. ##### 获取某用户的私信 get_message
   - 接口 `/api/message/get_message()`

   - 参数 `token`-token  

   - 返回值

     ```python
     {
         code: code,    # -1=获取失败 0=未知用户 1=成功
         msg: msg,      # 信息
         list: list     # 私信列表
     }
     ```
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
   - 接口 `/api/upload/upload_identity_card()`

   - 参数 `front`-正面照片  `back`-背面照片  `token`-token

   - 返回值

     ```python
     {
         code: code,    # -2=无法自动识别 -1=文件格式不正确 
                        # 0=未知用户 1=成功
         msg: msg,      # 信息
         data:data      # 文件上传路径
     }
     ```
3. 

#### Algorithm 算法

1. ##### 建立文章的评分矩阵 build_article_rate_rect
   - 接口 `/api/algorithm/build_article_rate_rect()`

   - 参数 

   - 返回值

     ```python
     {
         code: code,    # 0=失败 1=成功
         msg: msg,      # 信息
     }
     ```

2. ##### 建立问题的评分矩阵 build_question_rate_rect
   - 接口 `/api/algorithm/build_question_rate_rect()`

   - 参数 

   - 返回值

     ```python
     {
         code: code,    # 0=失败 1=成功
         msg: msg,      # 信息
     }
     ```

3. #### 模糊匹配待选搜索项 before_vague_search_api
   - 接口 `/api/algorithm/before_vague_search_api()`

   - 参数 `word`-搜索词

   - 返回值

     ```python
     {
         code: code,    # 0=失败 1=成功
         msg: msg,      # 信息
         data: data     # 推荐的搜索项
     }
     ```

4. #### 模糊搜索 search
   - 接口 `/api/algorithm/search()`

   - 参数 `word`-搜索词  `type`-搜索内容 question=问题 article=文章

   - 返回值

     ```python
     {
         code: code,    # 0=失败 1=成功
         msg: msg,      # 信息
         data: data     # 搜索结果
     }
     ```
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
   - 接口 `/api/specialist/get_my_articles()`

   - 参数 `token`-token

   - 返回值

     ```python
     {
         code: code,    # 0=用户不存在 1=成功
         msg: msg,      # 信息
         data: data     # 文章列表
     }
     ```
3. ##### 获取自己的粉丝列表 get_my_fans
   - 接口 `/api/specialist/get_my_fans()`

   - 参数 `token`-token

   - 返回值

     ```python
     {
         code: code,    # 0=用户不存在 1=成功
         msg: msg,      # 信息
         data: data     # 粉丝列表
     }
     ```
4. ##### 获取付费预约的列表 get_order_list
   - 接口 `/api/specialist/get_order_list()`

   - 参数 `token`-token

   - 返回值

     ```python
     {
         code: code,    # 0=用户不存在 1=成功
         msg: msg,      # 信息
         data: data     # 预约列表
     }
     ```
5. ##### 确认预约 confirm_order
   - 接口 `/api/specialist/confirm_order()`

   - 参数 `token`-token

   - 返回值

     ```python
     {
         code: code,    # -1=预约订单不存在或者用户不匹配 
                        # 0=用户不存在 1=成功
         msg: msg,      # 信息
     }
     ```
6. ##### 拒绝预约 refuse_order
   - 接口 `/api/specialist/refuse_order()`

   - 参数 `token`-token

   - 返回值

     ```python
     {
         code: code,    # -1=预约订单不存在或者用户不匹配 
                        # 0=用户不存在 1=成功
         msg: msg,      # 信息
     }
     ```
7. ##### 获取点击量图表 get_click_info

8. ##### 获取关注量增减图表 get_fans_info

9. ##### 预约付费咨询 add_order
   - 接口 `/api/specialist/add_order()`

   - 参数 `token`-token

   - 返回值

     ```python
     {
         code: code,    # -1=无法添加 0=用户不存在 1=成功
         msg: msg,      # 信息
     }
     ```
10. ##### 申请升级为专家 request_upgrade
   - 接口 `/api/specialist/request_upgrade()`

   - 参数 `token`-token

   - 返回值

     ```python
     {
         code: code,    # -1=无法申请 0=用户不存在 1=成功
         msg: msg,      # 信息
     }
     ```
11. 

#### Enterprise 企业

1. ##### 添加需求 add_demand
   - 接口 `/api/enterprise/add_demand()`

   - 参数 `token`-token

   - 返回值

     ```python
     {
         code: code,    # -1=无法添加 0=用户不存在 1=成功
         msg: msg,      # 信息
     }
     ```

2. ##### 获取自己的需求列表 get_my_demands
   - 接口 `/api/enterprise/get_my_demands()`

   - 参数 `token`-token

   - 返回值

     ```python
     {
         code: code,    # 0=用户不存在 1=成功
         msg: msg,      # 信息
         data:data,     # 需求列表
     }
     ```

3. ##### 获取报名该需求的用户列表 get_signed_users
   - 接口 `/api/enterprise/get_signed_users()`

   - 参数 `token`-token

   - 返回值

     ```python
     {
         code: code,    # 0=用户不存在 1=成功
         msg: msg,      # 信息
         data:data,     # 用户列表
     }
     ```

4. ##### 确认报名的用户 confirm_signed_user
   - 接口 `/api/enterprise/confirm_signed_user()`

   - 参数 `token`-token

   - 返回值

     ```python
     {
         code: code,    # -1=确认失败 0=用户不存在 1=成功
         msg: msg,      # 信息
     }
     ```

5. ##### 拒绝报名的用户 refuse_signed_user
   - 接口 `/api/enterprise/refuse_signed_user()`

   - 参数 `token`-token

   - 返回值

     ```python
     {
         code: code,    # -1=拒绝失败 0=用户不存在 1=成功
         msg: msg,      # 信息
     }
     ```

6. ##### 结束需求 close_demand
   - 接口 `/api/enterprise/close_demand()`

   - 参数 `token`-token

   - 返回值

     ```python
     {
         code: code,    # -1=关闭失败或用户不匹配 0=用户不存在 1=成功
         msg: msg,      # 信息
     }
     ```

7. ##### 开始需求 start_demand
   - 接口 `/api/enterprise/start_demand()`

   - 参数 `token`-token

   - 返回值

     ```python
     {
         code: code,    # -1=开始失败或用户不匹配 0=用户不存在 1=成功
         msg: msg,      # 信息
     }
     ```

8. ##### 申请升级为企业账户 request_enterprise_upgrade
   - 接口 `/api/enterprise/request_enterprise_upgrade()`

   - 参数 `token`-token

   - 返回值

     ```python
     {
         code: code,    # -1=申请失败 0=用户不存在 1=成功
         msg: msg,      # 信息
     }
     ```

9. 

#### Board 告示板

1. ##### 报名需求 sign_to_demand
   - 接口 `/api/board/sign_to_demand()`

   - 参数 `token`-token

   - 返回值

     ```python
     {
         code: code,    # -1=报名失败 0=用户不存在 1=成功
         msg: msg,      # 信息
     }
     ```

2. ##### 获取需求推荐 get_board_recommend
   - 接口 `/api/board/get_board_recommend()`

   - 参数 `token`-token

   - 返回值

     ```python
     {
         code: code,    # 0=用户不存在 1=成功
         msg: msg,      # 信息
         data: data     # 需求列表
     }
     ```

3. ##### 获取告示板分类 get_board_category
    - 接口 `/api/board/get_board_category()`

   - 参数 

   - 返回值

     ```python
     {
         code: code,    # 1=成功
         msg: msg,      # 信息
         data: data     # 分类信息
     }
     ```

4. ##### 获取父级标签下的子集标签 get_child_category
   - 接口 `/api/board/get_child_category()`

   - 参数 `tag_id`-父级标签的ID

   - 返回值

     ```python
     {
         code: code,    # 0=父级标签不存在 1=成功
         msg: msg,      # 信息
         data: data     # 子集标签
     }
     ```

5. ##### 获取需求信息 get_demand
   - 接口 `/api/board/get_demand()`

   - 参数 `demand_id`-需求的ID

   - 返回值

     ```python
     {
         code: code,    # 0=需求不存在 1=成功
         msg: msg,      # 信息
         data: data     # 需求信息
     }
     ```

6. ##### 获取该tag下的所有需求 get_demands_by_tag
   - 接口 `/api/board/get_demands_by_tag()`

   - 参数 `tag_id`-标签的ID

   - 返回值

     ```python
     {
         code: code,    # 1=成功
         msg: msg,      # 信息
         data: data     # 需求列表
     }
     ```
7. ##### 后台获取需求列表 back_get_demands
   - 接口 `/api/board/back_get_demands()`

   - 参数 `X-Token`-X-Token
   
   - 返回值

     ```python
     {
         code: code,    # 0=用户不存在 1=成功
         msg: msg,      # 信息
         data: data     # 需求列表
     }
     ```
8. ##### 清除需求 delete_demand
   - 接口 `/api/board/delete_demand()`

   - 参数 `X-Token`-X-token

   - 返回值

     ```python
     {
         code: code,    # -1=删除失败 0=用户不存在 1=成功
         msg: msg,      # 信息
         data: data     # 需求列表
     }
     ```

#### 学院接口 school
1. ##### 获取免费文章 get_free_article
   - 接口 `/api/school/get_free_article()`

   - 参数 

   - 返回值

     ```python
     {
         code: code,    # 0=无文章 1=成功
         msg: msg,      # 信息
         data: data     # 文章列表
     }
     ```
2. ##### 获取收费文章 get_charge_article
   - 接口 `/api/school/get_charge_article()`

   - 参数 

   - 返回值

     ```python
     {
         code: code,    # 0=无文章 1=成功
         msg: msg,      # 信息
         data: data     # 文章列表
     }
     ```
3. ##### 获取某用户发表的文章 get_user_article
   - 接口 `/api/school/get_user_article()`

   - 参数 `token`-token

   - 返回值

     ```python
     {
         code: code,    # -1=用户不存在 0=无文章 1=成功
         msg: msg,      # 信息
         data: data     # 文章列表
     }
     ```
4. ##### 根据tag查找文章 get_article_by_tag
   - 接口 `/api/school/get_article_by_tag()`

   - 参数 `tag_id`-标签的ID

   - 返回值

     ```python
     {
         code: code,    # 0=无文章 1=成功
         msg: msg,      # 信息
         data: data     # 文章列表
     }
     ```
5. ##### 推荐相似文章 get_similar_article
   - 接口 `/api/school/get_similar_article()`

   - 参数 `article_id`-文章的ID

   - 返回值

     ```python
     {
         code: code,    # 0=评分矩阵不存在 1=成功
         msg: msg,      # 信息
         data: data     # 文章列表
     }
     ```
6. ##### 根据用户最近浏览进行文章推荐 get_recommend_article
   - 接口 `/api/school/get_recommend_article()`

   - 参数 `token`-token

   - 返回值

     ```python
     {
         code: code,    # -1=评分矩阵未建立 0=无文章 1=成功
         msg: msg,      # 信息
         data: data     # 文章列表
     }
     ```

#### 群聊接口 group
1. ##### 新建群组 new_group
   - 接口 `/api/group/new_group()`

   - 参数 `token`-token `name`-群名称 `description`-群简介                        `head_portrait`-群肖像 

   - 返回值

     ```python
     {
         code: code,    # -1=新建失败 0=用户不存在 1=成功
         msg: msg,      # 信息
     }
     ```
2. ##### 添加组员 add_group_member
   - 接口 `/api/group/add_group_member()`

   - 参数 `token`-token `group_id`-群ID `user_id`-用户ID

   - 返回值

     ```python
     {
         code: code,    # -1=添加失败 0=用户不存在 1=成功
         msg: msg,      # 信息
     }
     ```
3. ##### 确认加入群组 confirm_invite
   - 接口 `/api/group/confirm_invite()`

   - 参数 `token`-token `group_id`-群ID 

   - 返回值

     ```python
     {
         code: code,    # -1=确认失败 0=用户不存在 1=成功
         msg: msg,      # 信息
     }
     ```
4. ##### 设置群管理员 set_admin
   - 接口 `/api/group/set_admin()`

   - 参数 `token`-token `group_id`-群ID `user_id`-用户ID

   - 返回值

     ```python
     {
         code: code,    # -2=群内未知用户 -1=设置失败 0=用户不存在 1=成功
         msg: msg,      # 信息
     }
     ```
5. ##### 取消设置群管理员 set_normal
   - 接口 `/api/group/set_normal()`

   - 参数 `token`-token `group_id`-群ID `user_id`-用户ID

   - 返回值

     ```python
     {
         code: code,    # -2=群内未知用户 -1=设置失败 0=用户不存在 1=成功
         msg: msg,      # 信息
     }
     ```
6. ##### 加入群聊 join_group
   - 接口 `/api/group/join_group()`

   - 参数 `token`-token `group_id`-群ID

   - 返回值

     ```python
     {
         code: code,    # -1=加入失败 0=用户不存在 1=成功
         msg: msg,      # 信息
     }
     ```
7. ##### 同意加群申请 confirm_join
   - 接口 `/api/group/confirm_join()`

   - 参数 `token`-token `group_id`-群ID `user_id`-用户ID

   - 返回值

     ```python
     {
         code: code,    # -1=同意失败 0=用户不存在 1=成功
         msg: msg,      # 信息
     }
     ```
8. ##### 拒接加群申请 refuse_join
   - 接口 `/api/group/refuse_join()`

   - 参数 `token`-token `group_id`-群ID `user_id`-用户ID

   - 返回值

     ```python
     {
         code: code,    # -1=拒绝失败 0=用户不存在 1=成功
         msg: msg,      # 信息
     }
     ```
9.  ##### 禁言某成员 silent_user
   - 接口 `/api/group/silent_user()`

   - 参数 `token`-token `group_id`-群ID `user_id`-用户ID

   - 返回值

     ```python
     {
         code: code,    # -1=禁言失败 0=用户不存在 1=成功
         msg: msg,      # 信息
     }
     ```

10. ##### 解除禁言某群员 un_silent_user
   - 接口 `/api/group/un_silent_user()`

   - 参数 `token`-token `group_id`-群ID `user_id`-用户ID

   - 返回值

     ```python
     {
         code: code,    # -1=解除失败 0=用户不存在 1=成功
         msg: msg,      # 信息
     }
     ```

11. ##### 发送消息 send_group_message
   - 接口 `/api/group/send_group_message()`

   - 参数 `token`-token `group_id`-群ID `content`-消息内容

   - 返回值

     ```python
     {
         code: code,    # -1=发送失败 0=用户不存在 1=成功
         msg: msg,      # 信息
     }
     ```

12. ##### 获取群聊消息 get_group_message
   - 接口 `/api/group/get_group_message()`

   - 参数 `token`-token `group_id`-群ID 

   - 返回值

     ```python
     {
         code: code,    # -1=群组不可访问 0=用户不存在 1=成功
         msg: msg,      # 信息
         data: data,    # 群聊消息列表
     }
     ```
13. ##### 获取某用户的所有群组 get_groups
   - 接口 `/api/group/get_groups()`

   - 参数 `token`-token

   - 返回值

     ```python
     {
         code: code,    # 0=用户不存在 1=成功
         msg: msg,      # 信息
         data: {[
             id:groupID,                #群组ID
             head_portrait:head_portrait,#群组头像
             name:name,                 #群名称
             description:description,   #群简介
             last_message:{
                 nickname:nickname,     #最近一条信息的发送者昵称
                 content:content,       #内容
                 time:time              #发送时间
             }
        ]}
     }
     ```
14. ##### 获取某群组的成员列表 get_group_members
   - 接口 `/api/group/get_group_members()`

   - 参数 `group_id`-群ID 

   - 返回值

     ```python
     {
         code: code,    # 1=成功
         msg: msg,      # 信息
         data: data,    # 成员列表
     }
     ```
15. ##### 封禁用户 ban_user
   - 接口 `/api/group/ban_user()`

   - 参数 `token`-token `group_id`-群ID `user_id`-用户ID

   - 返回值

     ```python
     {
         code: code,    # -1=封禁失败 0=用户不存在 1=成功
         msg: msg,      # 信息
     }
     ```
16. ##### 后台获取群聊 back_get_groups
   - 接口 `/api/group/back_get_groups()`

   - 参数 `X-Token`-X-Token

   - 返回值

     ```python
     {
         code: code,    # 0=用户不存在 1=成功
         msg: msg,      # 信息
     }
     ```
17. ##### 清除群聊 delete_group
   - 接口 `/api/group/delete_group()`

   - 参数 `X-Token`-X-Token `group_id`-群ID

   - 返回值

     ```python
     {
         code: code,    # -1=清除失败 0=用户不存在 1=成功
         msg: msg,      # 信息
     }
     ```

## 数据库 DataBase

### 类型约定 Format

#### 用户行为类型约定 TypeFormat

| 代码 | 释义             | 备注 |
| ---- | ---------------- | ---- |
| 1    | 对答案点赞          |      |
| 2    | 对答案点踩          |      |
| 3    | 对答案的评论点赞     |      |
| 4    | 对答案的评论点踩     |      |
| 5    | 举报答案的评论    |      |
| 6    | 举报答案    |      |
| 11   | 浏览问题            |      |
| 12   | 关注问题            |      |
| 13   | 回答问题            |      |
| 14   | 对问题的评论点赞     |      |
| 15   | 举报问题            |      |
| 21   | 浏览文章            |      |
| 22   | 收藏文章            |      |
| 23   | 点赞文章            |      |
| 24   | 点踩文章            |      |
| 25   | 评论文章            |      |
| 26   | 举报文章            |      |
| 31 | 管理员通过实名认证 | |
| 32 | 管理员不通过实名认证 | |
| 33 | 管理员通过专家认证 | |
| 34 | 管理员不通过专家认证 | |
| 35 | 管理员通过企业账户认证 | |
| 36 | 管理员不通过企业账户认证 | |
| 37 | 管理员封禁账户 | |
| 38 | 管理员清除需求 | |
| 39 | 管理员清除问题 | |
| 40 | 管理员清除回答 | |
| 41 | 管理员清除群聊 | |
| 42 | 管理员通过举报 | |
| 43 | 管理员不通过举报 | |
| 50 | 关注问题 | |

#### 问题回答等状态类型约定 StateFormat
| 代码 | 释义 | 备注 |
| ---- | ---- | ---- |
| -1   | 违规  |      |
| 0   | 正常  |      |
| 1 | 待审核 | |


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

| 代码 | 释义     | 备注                       |
| ---- | -------- | -------------------------- |
| 0    | 全体消息 |                            |
| 1    | 个人消息 | 类似系统单独通知内容       |
| 2    | 群聊通知 | 类似QQ群管理助手发布的内容 |

#### 标签类型约定 TagTypeFormat

| 代码 | 释义     | 备注 |
| ---- | -------- | ---- |
| 0    | 其他     |      |
| 1    | 初级标签 |      |
| 2    | 次级标签 |      |

#### 群聊群员状态类型约定 GroupMemberStateFormat

| 代码 | 释义                           | 备注 |
| ---- | ------------------------------ | ---- |
| 0    | 群主                           |      |
| 1    | 管理员                         |      |
| 2    | 普通群员                       |      |
| 3    | 管理员或群主邀请加群未通过审核 |      |
| 4    | 用户申请加群未通过管理员审核   |      |
| 5    | 封禁                           |      |

#### 群聊群员禁言类型约定 GroupMemberSilentFormat

| 代码 | 释义   | 备注 |
| ---- | ------ | ---- |
| 0    | 正常   |      |
| 1    | 被禁言 |      |

#### 群组状态类型约定 GroupStateFormat

| 代码 | 释义   | 备注 |
| ---- | ------ | ---- |
| -1   | 被解散 |      |
| 0    | 正常   |      |

