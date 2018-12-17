<template>
    <div class="home">

        <v-toolbar color="white" tabs>
            <v-text-field append-icon="mic" class="mx-3" flat label="Search" prepend-inner-icon="search" solo-inverted></v-text-field>
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
                <v-card color="white" style="margin-top: 1em" @click="$router.push('/topic')">
                    <v-container grid-list-md text-xs-center>
                        <v-layout row wrap>
                            <v-flex xs7 style="text-align: left">
                                <h3>{{title}}</h3>
                            </v-flex>
                            <v-flex xs5>
                                <img src="./1.png" style="width: 100%">
                            </v-flex>
                            <div style="display: flex;width: 100%;text-align: left;justify-content: space-between;">
                                <div>
                                    <p>标签&nbsp;&nbsp;·&nbsp;&nbsp;<span>科技/人工智能</span></p>
                                    <p><span>4342</span>人关注&nbsp;&nbsp;&nbsp;·&nbsp;&nbsp;&nbsp;<span>40</span>条评论
                                    </p>
                                </div>
                                <div>
                                    <p style="margin-top: 1em">12小时前</p>
                                </div>
                            </div>
                        </v-layout>
                    </v-container>
                </v-card>

                <!--以下为复制的内容，不用管了。可以直接删-->

                <v-card color="white" style="margin-top: 1em" @click="$router.push('/topic')">
                    <v-container grid-list-md text-xs-center>
                        <v-layout row wrap>
                            <v-flex xs7 style="text-align: left">
                                <h3>{{title}}</h3>
                            </v-flex>
                            <v-flex xs5>
                                <img src="./1.png" style="width: 100%">
                            </v-flex>
                            <div style="display: flex;width: 100%;text-align: left;justify-content: space-between;">
                                <div>
                                    <p>标签&nbsp;&nbsp;·&nbsp;&nbsp;<span>科技/人工智能</span></p>
                                    <p><span>4342</span>人关注&nbsp;&nbsp;&nbsp;·&nbsp;&nbsp;&nbsp;<span>40</span>条评论
                                    </p>
                                </div>
                                <div>
                                    <p style="margin-top: 1em">12小时前</p>
                                </div>
                            </div>
                        </v-layout>
                    </v-container>
                </v-card>
                <v-card color="white" style="margin-top: 1em" @click="$router.push('/topic')">
                    <v-container grid-list-md text-xs-center>
                        <v-layout row wrap>
                            <v-flex xs7 style="text-align: left">
                                <h3>{{title}}</h3>
                            </v-flex>
                            <v-flex xs5>
                                <img src="./1.png" style="width: 100%">
                            </v-flex>
                            <div style="display: flex;width: 100%;text-align: left;justify-content: space-between;">
                                <div>
                                    <p>标签&nbsp;&nbsp;·&nbsp;&nbsp;<span>科技/人工智能</span></p>
                                    <p><span>4342</span>人关注&nbsp;&nbsp;&nbsp;·&nbsp;&nbsp;&nbsp;<span>40</span>条评论
                                    </p>
                                </div>
                                <div>
                                    <p style="margin-top: 1em">12小时前</p>
                                </div>
                            </div>
                        </v-layout>
                    </v-container>
                </v-card>
                <v-card color="white" style="margin-top: 1em" @click="$router.push('/topic')">
                    <v-container grid-list-md text-xs-center>
                        <v-layout row wrap>
                            <v-flex xs7 style="text-align: left">
                                <h3>{{title}}</h3>
                            </v-flex>
                            <v-flex xs5>
                                <img src="./1.png" style="width: 100%">
                            </v-flex>
                            <div style="display: flex;width: 100%;text-align: left;justify-content: space-between;">
                                <div>
                                    <p>标签&nbsp;&nbsp;·&nbsp;&nbsp;<span>科技/人工智能</span></p>
                                    <p><span>4342</span>人关注&nbsp;&nbsp;&nbsp;·&nbsp;&nbsp;&nbsp;<span>40</span>条评论
                                    </p>
                                </div>
                                <div>
                                    <p style="margin-top: 1em">12小时前</p>
                                </div>
                            </div>
                        </v-layout>
                    </v-container>
                </v-card>


                <!--复制结束，下面的items都是空的，直接把最上面的v-card搬过来就OK-->


            </v-tab-item>
            <v-tab-item :key="2">
                22222
            </v-tab-item>
            <v-tab-item :key="3">
                33333
            </v-tab-item>
            <v-tab-item :key="4">
                44444
            </v-tab-item>
            <v-tab-item :key="5">
                55555
            </v-tab-item>
        </v-tabs-items>

    </div>
</template>

<script>
    import axios from 'axios';

    export default {
        data: () => ({
            tabs: 0,
            question_list: [
                {
                    questionID: 1,
                    title: '程序员是如何看待「祖传代码」的？',
                    image: 'https://cdn.vuetifyjs.com/images/cards/halcyon.png',
                    tags: ['互联网', '程序员'],
                    edittime: '12小时前',
                    description: '说明一下……此处「祖传代码」与百度搜索「祖传代码」词条出现的某直',
                    follow: 1,
                    comment: 2,
                }
            ],
            title: '未来三十年内，哪些行业的工作人员可能被人工智能取代？',

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
        },
        mounted() {
            this.getQuestionList();
        }
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
