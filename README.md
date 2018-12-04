# Project-Agent
工业技术类从业者与领域专家的交流平台

[TOC]

## 2018-12-04周任务

> 此文档暂时用于制定任务目标，具体项目文档请写在各自文件夹中
>
> 温馨提示：
>
> 文档和代码注释越详细越好！
>
> 文档和代码注释越详细越好！
>
> 文档和代码注释越详细越好！

#### 设计(HBQ)

1. 登录/注册页面原型
2. 首页原型（登录后跳到首页，首页显示热门问题列表
3. 首页底部应有导航栏，暂定为`话题`、`学院`、`消息`、`我的`
4. 优化现有原型，添加页面间过渡动画
5. 建议修改布局，不要和知乎太像（通过修改组件样式、按钮位置、图标、配色达到目的

#### 页面(WH,LPZ)

1. 登录页
2. 注册页
3. 话题-问题页（包含右上角功能
4. 话题-答案页（包含右上角功能
5. 话题-评论详情（遮罩层
6. 问题页和答案页右上角的 `更多` 弹出遮罩层

#### 接口(ZY,YYZ)

1. 登录

2. 注册

3. 获取问题（暂时不排序）

    ```shell
    params: question_type  # 领域内推荐，领域外推荐，热门，关键字搜索
    {
        code: 1,  # 状态码
        msg: 'success',  # 提示
        data: {
            question_list: (list),
        },
    }
    ```

4. 获取答案（暂时按点赞数降序）

    ```shell
    params: question_id
    {
        code: 1,
        msg: 'success',
        data: {
            answer_list: (list),
        },
    }
    ```

5. 获取评论（暂时按点赞数降序）

    ```shell
    params: answer_id
    {
        # 同上
    }
    ```

6. 添加评论

    ```shell
    # 评论了哪个答案，评论内容是什么，是谁评论的
    params: answer_id, content, user_id
    {
        code: 1,
        msg: 'success',
    }
    ```

7. 给答案点赞

    ```shell
    params: answer_id
    {
        code: 1,
        msg: 'success',
    }
    ```

8. 给答案点踩

    ```shell
    # 同上
    ```

9. 给评论点赞

    ```shell
    params: comment_id
    {
        code: 0,
        msg: 'success',
    }
    ```


#### 算法

先打酱油吧