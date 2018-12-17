<template>
    <div class="home">

        <v-toolbar color="white" tabs>
            <!--搜索栏-->
            <v-text-field append-icon="mic" class="mx-3" flat label="Search" prepend-inner-icon="search" solo-inverted></v-text-field>

            <!--分类标签栏-->
            <v-tabs slot="extension" v-model="tabs" centered color="white" slider-color="#FFCC00">
                <v-tab :key="1">推荐</v-tab>
                <v-tab :key="2">计算机</v-tab>
                <v-tab :key="3">互联网</v-tab>
                <v-tab :key="4">通信</v-tab>
                <v-tab :key="5">信息安全</v-tab>
            </v-tabs>
        </v-toolbar>

        <v-tabs-items v-model="tabs">
            <v-tab-item :key="1">
                <question-card @click.native="view_detail(question.questionID)" v-for="question in question_list" :key="question.questionID" v-bind="question"></question-card>
            </v-tab-item>

            <v-tab-item :key="2">
                <question-card @click.native="view_detail(question.questionID)" v-for="question in question_list" :key="question.questionID" v-bind="question"></question-card>
            </v-tab-item>

            <v-tab-item :key="3">
                <question-card @click.native="view_detail(question.questionID)" v-for="question in question_list" :key="question.questionID" v-bind="question"></question-card>
            </v-tab-item>

            <v-tab-item :key="4">
                <question-card @click.native="view_detail(question.questionID)" v-for="question in question_list" :key="question.questionID" v-bind="question"></question-card>
            </v-tab-item>

            <v-tab-item :key="5">
                <question-card @click.native="view_detail(question.questionID)" v-for="question in question_list" :key="question.questionID" v-bind="question"></question-card>
            </v-tab-item>

        </v-tabs-items>

    </div>
</template>

<script>
    import axios from 'axios';
    import QuestionCard from '../question-card/question-card'

    export default {
        components: {
            QuestionCard,
        },
        data: () => ({
            tabs: 0,
            question_list: [
                {
                    questionID: 1,  // 问题ID
                    edittime: '12小时前',  // 编辑时间
                    title: '未来三十年内，哪些行业的工作人员可能被人工智能取代？',  // 标题
                    tags: ['科技', '人工智能'],  // 标签
                    follow: 4342,  // 关注人数
                    comment: 40,  // 评论人数
                    img: 'https://cdn.vuetifyjs.com/images/cards/halcyon.png',  // 缩略图
                },
                {
                    questionID: 2,  // 问题ID
                    edittime: '12小时前',  // 编辑时间
                    title: '未来三十年内，哪些行业的工作人员可能被人工智能取代？',  // 标题
                    tags: ['科技', '人工智能'],  // 标签
                    follow: 4342,  // 关注人数
                    comment: 40,  // 评论人数
                    img: 'https://cdn.vuetifyjs.com/images/cards/halcyon.png',  // 缩略图
                },
                {
                    questionID: 3,  // 问题ID
                    edittime: '12小时前',  // 编辑时间
                    title: '未来三十年内，哪些行业的工作人员可能被人工智能取代？',  // 标题
                    tags: ['科技', '人工智能'],  // 标签
                    follow: 4342,  // 关注人数
                    comment: 40,  // 评论人数
                    img: 'https://cdn.vuetifyjs.com/images/cards/halcyon.png',  // 缩略图
                },
                {
                    questionID: 4,  // 问题ID
                    edittime: '12小时前',  // 编辑时间
                    title: '未来三十年内，哪些行业的工作人员可能被人工智能取代？',  // 标题
                    tags: ['科技', '人工智能'],  // 标签
                    follow: 4342,  // 关注人数
                    comment: 40,  // 评论人数
                    img: 'https://cdn.vuetifyjs.com/images/cards/halcyon.png',  // 缩略图
                },
            ],
        }),

        watch: {},
        methods: {
            getQuestionList() {
                // 获取问题列表
                axios.get('http://127.0.0.1:5000/api/homepage/get_recommend', {
                    responseType: 'json',
                }).then((response) => {
                    let data_list = response.data.data;
                    window.console.log(data_list);
                })
            },
            view_detail(id) {
                // 查看问题详情
                this.$router.push({name: 'answer-detail', params: id});  // 跳转到详情页
            },
        },
        mounted() {
            // this.getQuestionList();
        },
    }
</script>

<style scoped>
    .v-toolbar {
        padding-top: 1em;
    }
    p {
        margin-bottom: 0;
    }

    .head {
        width: 100%;
        height: 8em;
        position: fixed;
        top: 0;
        border: 1px solid #eee;
    }
    .search{
        margin: 0 auto;
    }
    .cardtitle {
        font-size: 20px;
    }
</style>
