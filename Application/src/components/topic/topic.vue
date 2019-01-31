<template>
    <div class="topic">

        <!--头部，主要是问题描述之类-->

        <div class="head" style="padding-left: 1em; padding-right: 1em;">
            <h2>{{questionData.title}}</h2>
            <div class="head-something">
                <div style="flex: 0 0 70%">
                    <p>标签 : <span v-for="(tag, index) in questionData.tags" :key="index">{{tag}} </span></p>
                    <p><span> {{questionData.follow}} </span>人关注&nbsp;&nbsp;&nbsp;·&nbsp;&nbsp;&nbsp;<span>{{questionData.commentsNum}} </span>
                        条评论</p>
                </div>
                <div class="attention" style="flex: 0 0 30%">+关注话题</div>
            </div>
            <p class="topicdetail">
                <span v-if="!showAll">{{ questionData.content.length > 65 ? questionData.content.substring(0, 65) + '...' : questionData.content }} </span>
                <span v-else>{{ questionData.content }} </span>
                <button id="show-all-button" v-if="questionData.content.length > 65" @click="showAll = !showAll">
                    <span v-if="!showAll">显示全部</span>
                    <span v-else>收起</span>
                </button>
            </p>
        </div>

        <!--一个浅色的分割栏，只有回答数和排序-->

        <div class="line" style="padding-left: 1em; padding-right: 1em;">
            <p class="answerNum"><span>{{answerNum}}</span>条回答</p>
            <div>默认排序</div>
        </div>

        <!--页面主体，展示不同的回答列表-->

        <div v-for="(answer, index) in answersDataList" :key="index">
            <div style="padding-left: 1em; padding-right: 1em;padding-bottom: 1em">
                <router-link :to="{name: 'answer-detail', params: {id: answer.answerID}, query: {redirect: $route.fullPath}}">
                    <p class="answerDetail">{{ answer.content.length > 70 ? answer.content.substring(0, 70) + '...' : answer.content }}</p>
                    <div class="answerImg">
                        <!--<img v-for="item in answerImg" :src="item.src" alt="">-->
                        <img src="./1.png" alt="">
                        <img src="./2.png" alt="">
                        <img src="./3.png" alt="">
                    </div>
                </router-link>
                <div class="like">点赞: {{answer.agree}} 反对: {{ answer.disagree }}</div>
                <div style="width: 100%;display: flex;align-items: center;position: relative;">
                    <div class="userhead">
                        <img :src="answer.headportrait" alt="">
                    </div>
                    <p class="userName">{{answer.nickname}}</p>
                    &nbsp;&nbsp;&nbsp;
                    <!--<p class="userTag">{{answer.user.tag}}</p>-->
                    <p class="answerTime">{{answer.edittime}}</p>
                </div>
            </div>
            <div style="width: 100%;height: 22px;background-color: #EBEBEB;"></div>
        </div>

        <!--固定在底部的input等-->

        <!--<div class="foot">-->
            <!--<div class="footinput">-->
                <!--<input type="text" placeholder="输入您的回答">-->
            <!--</div>-->
            <!--<div>又是俩icon</div>-->
        <!--</div>-->

        <!--END-->

    </div>
</template>

<script>
    import axios from 'axios'

    export default {
        name: "Topic",
        data() {
            return {
                showAll: false,
                questionData: {
                    title: '刚刚研制成功的世界首台分辨力最高紫外超分辨光刻装备意味着什么？对国内芯片行业有何影响？',  // 问题标题
                    tags: ['新闻', '芯片'],  // 标签
                    follow: '22222',  // 关注人数
                    commentsNum: '333',  // 评论数量
                    content: '新闻资讯军报记者成都11月29日电（吕珍慧、记者邹维荣）国家重大科研装备研制项目“超...',  // 内容
                },
                answerNum: "123",  // 回答的数量
                answersDataList: [
                    {
                        content: '先回答大家最关心的两个问题:2、不吹不黑，这个装备真的这么厉害吗，还是只是吹牛？答：确实很厉害。',
                        nickname: '看风景',  // 用户昵称
                        edittime: '2小时前',  // 回答时间
                        agree: '233',  // 点赞
                        commentsNum: '',  //评论数量
                    },
                ],  // 答案列表
            }
        },
        methods: {
            // getQuestion(questionID) {
            //     // 获取问题信息
            //     axios.get()
            // },
            getAnswers(questionID) {
                // 获取答案信息
                axios.get('http://127.0.0.1:5000/api/questions/get_answer_list', {
                    responseType: 'json',
                    params: {
                        question_id: questionID,
                    },
                }).then((response) => {
                    // console.log(response.data.data);
                    this.answersDataList = response.data.data;
                    this.answerNum=response.data.data.length;
                });
            },
            getQuestion(questionID){
                axios.get('http://127.0.0.1:5000/api/questions/get_question', {
                    responseType: 'json',
                    params: {
                        question_id: questionID,
                    },
                }).then((response) => {
                    // console.log(response.data.data);
                    const data = response.data.data;
                    this.questionData.title=data.title;
                    this.questionData.content=data.description;
                    //this.questionData.tags=data.tags;
                });
            }
        },
        mounted() {
            const id = this.$route.params.id;
            this.getAnswers(id);
            this.getQuestion(id);
        },
    }
</script>

<style scoped>
    .topic {
        position: fixed;
        width: 100%;
        height: 100%;
        z-index: 200;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background-color: white;
    }
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
    #show-all-button {
        color: grey;
    }
</style>
