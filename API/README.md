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

1. 用户登录

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

2. 