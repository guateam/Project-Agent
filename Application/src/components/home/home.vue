<template>
    <div class="home">

        <v-toolbar color="white" tabs>
            <!--搜索栏-->
            <v-autocomplete full-width append-icon="mic" :loading="loading" :items="items" :search-input.sync="search" v-model="select" cache-items class="mx-3" flat hide-no-data hide-details label="搜索你想要的信息" prepend-inner-icon="search" solo-inverted ></v-autocomplete>
            <!--<v-text-field append-icon="mic" class="mx-3" flat label="Search" prepend-inner-icon="search" solo-inverted></v-text-field>-->
            <!--<v-spacer></v-spacer>-->
            <!--<v-icon>widgets</v-icon>-->

            <!--分类标签栏-->
            <v-tabs slot="extension" v-model="tabs" centered color="transparent" slider-color="#FFCC00">
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
    import QuestionCard from '../question-card/question-card'

    Date.prototype.Format = function (fmt) { //author: meizz
        let o = {
            "M+": this.getMonth() + 1, //月份
            "d+": this.getDate(), //日
            "h+": this.getHours(), //小时
            "m+": this.getMinutes(), //分
            "s+": this.getSeconds(), //秒
            "q+": Math.floor((this.getMonth() + 3) / 3), //季度
            "S": this.getMilliseconds() //毫秒
        };
        if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
        for (var k in o)
            if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
        return fmt;
    };

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
                    img: 'https://cdn.vuetifyjs.com/images/cards/foster.jpg',  // 缩略图
                },
                {
                    questionID: 2,  // 问题ID
                    edittime: '12小时前',  // 编辑时间
                    title: '2018年，哪些经济学论文让你印象深刻？',  // 标题
                    tags: ['经济', '论文'],  // 标签
                    follow: 4342,  // 关注人数
                    comment: 40,  // 评论人数
                    img: 'https://cdn.vuetifyjs.com/images/cards/halcyon.png',  // 缩略图
                },
                {
                    questionID: 3,  // 问题ID
                    edittime: '12小时前',  // 编辑时间
                    title: '2018年，哪些经济学论文让你印象深刻？',  // 标题
                    tags: ['经济', '论文'],  // 标签
                    follow: 4342,  // 关注人数
                    comment: 40,  // 评论人数
                    img: 'https://cdn.vuetifyjs.com/images/cards/house.jpg',  // 缩略图
                },
                {
                    questionID: 4,  // 问题ID
                    edittime: '12小时前',  // 编辑时间
                    title: '未来三十年内，哪些行业的工作人员可能被人工智能取代？',  // 标题
                    tags: ['科技', '人工智能'],  // 标签
                    follow: 4342,  // 关注人数
                    comment: 40,  // 评论人数
                    img: 'https://cdn.vuetifyjs.com/images/cards/road.jpg',  // 缩略图
                },
            ],
            loading: false,
            items: [],
            search: null,
            select: null,
            states: [
                '未来三十年内，哪些行业的工作人员可能被人工智能取代？',
                '2018年，哪些经济学论文让你印象深刻？',
            ],
        }),
        watch: {
            search (val) {
                val && val !== this.select && this.querySelections(val);
            }
        },
        methods: {
            get_question_list() {
                // 获取问题列表
                import('axios').then((axios) => {
                    axios.get('http://127.0.0.1:5000/api/homepage/get_recommend', {
                        responseType: 'json',
                    }).then((response) => {
                        let data_list = response.data.data;
                        window.console.log(data_list);
                        this.question_list = [];
                        for (let i = 0; i < data_list.length; i += 1) {
                            if (data_list[i].type === 0) {
                                data_list[i].edittime = new Date(data_list[i].edittime).Format('yyyy-MM-dd');
                                this.question_list.unshift(data_list[i]);
                            }
                        }
                    })
                })
            },
            querySelections (v) {
                this.loading = true;
                // Simulated ajax query
                setTimeout(() => {
                    this.items = this.states.filter(e => {
                        return (e || '').toLowerCase().indexOf((v || '').toLowerCase()) > -1
                    });
                    this.loading = false;
                }, 500)
            },
            view_detail(id) {
                // 查看问题详情
                this.$router.push({name: 'topic', params: id});  // 跳转到话题详情页
            },
        },
        mounted() {
            this.get_question_list();
        },
    }
</script>

<style scoped>
    .v-toolbar {
        /*padding-top: 1em;*/
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
    .v-toolbar__content{
        height: 5em;
    }
</style>
