<template>
    <div class="topic">

        <!--头部，主要是问题描述之类-->

        <div class="head" style="padding-left: 1em; padding-right: 1em;">
            <h2>{{topicTitle}}</h2>
            <div class="head-something">
                <div style="flex: 0 0 70%">
                    <p>标签 : <span v-for="item in topicTag">{{item.tag}}</span></p>
                    <p><span> {{peopleNum}} </span>人关注&nbsp;&nbsp;&nbsp;·&nbsp;&nbsp;&nbsp;<span>{{commentNum}} </span>
                        条评论</p>
                </div>
                <div class="attention" style="flex: 0 0 30%">+关注话题</div>
            </div>
            <p class="topicdetail">{{topicDetail}}</p>
        </div>

        <!--一个浅色的分割栏，只有回答数和排序-->

        <div class="line" style="padding-left: 1em; padding-right: 1em;">
            <p class="answerNum"><span>{{answerNum}}</span>条回答</p>
            <div>默认排序</div>
        </div>

        <!--页面主体，展示不同的回答列表-->

        <div>
            <div style="padding-left: 1em; padding-right: 1em;padding-bottom: 1em">
                <router-link to="answer-detail">
                    <p class="answerDetail">{{answerDetail}}</p>
                    <div class="answerImg">
                        <!--<img v-for="item in answerImg" :src="item.src" alt="">-->
                        <img src="./1.png" alt="">
                        <img src="./2.png" alt="">
                        <img src="./3.png" alt="">
                    </div>
                </router-link>
                <div class="like">这里应该是点赞和评论</div>
                <div style="width: 100%;display: flex;align-items: center;position: relative;">
                    <div class="userhead">
                        <img src="./head.png" alt="">
                    </div>
                    <p class="userName">{{userName}}</p>
                    &nbsp;&nbsp;&nbsp;
                    <p class="userTag">{{userTag}}</p>
                    <p class="answerTime">{{answerTime}}</p>
                </div>
            </div>
            <div style="width: 100%;height: 22px;background-color: #EBEBEB;"></div>
        </div>

        <!--懒得写循环，直接复制了一份，这里的可以删-->

        <div>
            <div style="padding-left: 1em; padding-right: 1em;padding-bottom: 1em">
                <router-link to="answer-detail">
                    <p class="answerDetail">{{answerDetail}}</p>
                    <div class="answerImg">
                        <!--<img v-for="item in answerImg" :src="item.src" alt="">-->
                        <img src="./1.png" alt="">
                        <img src="./2.png" alt="">
                        <img src="./3.png" alt="">
                    </div>
                </router-link>
                <div class="like">这里应该是点赞和评论</div>
                <div style="width: 100%;display: flex;align-items: center;position: relative;">
                    <div class="userhead">
                        <img src="./head.png" alt="">
                    </div>
                    <p class="userName">{{userName}}</p>
                    &nbsp;&nbsp;&nbsp;
                    <p class="userTag">{{userTag}}</p>
                    <p class="answerTime">{{answerTime}}</p>
                </div>
            </div>
            <div style="width: 100%;height: 22px;background-color: #EBEBEB;margin-bottom: 50px"></div>
        </div>

        <!--固定在底部的input等-->

        <div class="foot">
            <div class="footinput">
                <input type="text" placeholder="输入您的回答">
            </div>
            <div>又是俩icon</div>
        </div>

        <!--END-->

    </div>
</template>

<script>
    import img1 from './1.png'
    import img2 from './2.png'
    import img3 from './3.png'

    export default {
        name: "Topic",
        data() {
            return {
                topicTitle: '刚刚研制成功的世界首台分辨力最高紫外超分辨光刻装备意味着什么？对国内芯片行业有何影响？',  // 话题标题
                topicTag: [
                    {tag: '新闻'},
                    {tag: '芯片'}
                ],  // 标签
                peopleNum: '22222',  // 关注数量
                commentNum: '333',  // 评论数量
                topicDetail: '新闻资讯军报记者成都11月29日电（吕珍慧、记者邹维荣）国家重大科研装备研制项目“超...',  // 话题的具体内容
                answerNum: "123",  // 回答的数量
                answerDetail: '先回答大家最关心的两个问题:2、不吹不黑，这个装备真的这么厉害吗，还是只是吹牛？答：确实很厉害。',  // 回答的详细内容，这里只显示部分
                answerImg: [
                    {src: './1.png'},
                    {src: './2.png'},
                    {src: './3.png'}
                ],
                userName: '看风景的蜗牛君',  // 用户名
                userTag: '专家',  // 用户身份标签
                answerTime: '22小时前'  // 回答的时间
            }
        },
        methods: {}
    }
</script>

<style scoped>
    p {
        margin-bottom: 0;
    }

    a {
        text-decoration: none;
        outline: none;
    }

    .head {
        padding-top: 1em;
        line-height: 1.5;
    }

    .head-something {
        width: 100%;
        margin-top: 1.2em;
        display: flex;
        font-weight: 100;
    }

    .attention {
        float: right;
        display: flex;
        align-items: center;
        justify-content: center;
        border: 1px #FFCC00 solid;
        border-radius: 3px;
        color: #FFCC00;
        font-weight: 600;
    }

    .topicdetail {
        margin-top: 1.2em;
    }

    .line {
        width: 100%;
        height: 42px;
        background-color: #EBEBEB;
        margin-top: 1.2em;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .answerDetail {
        color: black;
        margin-bottom: 1em;
        line-height: 1.5;
        margin-top: 1em;
    }

    .answerImg {
        width: 100%;
        height: 120px;
        display: flex;
    }

    .answerImg img {
        display: flex;
        flex: 0 0 33.3%;
        width: 33.3%;
    }

    .like {
        line-height: 1.5;
        float: right;
        margin-top: 10px;
        margin-bottom: 10px;
    }

    .userhead {
        width: 40px;
        height: 40px;
        border-radius: 50%;
    }

    .userhead img {
        width: 40px;
        height: 40px;
        border-radius: 50%;
    }

    .userName {
        font-size: 1.3em;
        font-weight: 600;
    }

    .userTag {
        font-size: 1.2em;
        font-weight: 600;
        color: #FFCC00;
    }

    .answerTime {
        position: absolute;
        right: 0;
    }

    .foot {
        width: 100%;
        height: 50px;
        display: flex;
        align-items: center;
        position: fixed;
        bottom: 0;
        background-color: white;
        z-index: 100;
        line-height: 1.5;
        padding-left: 1em;
    }

    .footinput {
        display: flex;
        flex: 0 0 70%;
        height: 80%;
        border: 1px solid #EBEBEB;
        border-radius: 10px;
    }
    .foot input{
        padding-left: 1em;
        width: 100%;
        height: 100%;
        outline: #EBEBEB;
    }
</style>