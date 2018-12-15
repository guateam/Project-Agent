<template>
    <div class="home">
        <v-app id="inspire">
            <v-layout row>
                <v-flex xs12 sm6 offset-sm3>
                    <v-card>
                        <v-toolbar color="yellow lighten-1">
                            <!--<v-toolbar-side-icon></v-toolbar-side-icon>-->

                            <v-toolbar-title>首页</v-toolbar-title>

                            <v-spacer></v-spacer>

                            <!--<v-btn icon>-->
                                <!--<v-icon>search</v-icon>-->
                            <!--</v-btn>-->
                        </v-toolbar>

                        <v-card>
                            <v-container
                                    fluid
                                    grid-list-lg
                            >
                                <v-layout row wrap>
                                    <v-flex xs12 v-for="question in questionList" @click="turnToTopic()">
                                        <v-card color="yellow lighten-5" class="">
                                            <v-card-title primary-title>
                                                <div>
                                                    <div class="headline">{{question.title}}</div>
                                                    <span>{{question.description}}</span>
                                                </div>
                                            </v-card-title>
                                            <!--<v-card-actions>-->
                                                <!--<v-btn flat dark @click="Topic()">查看</v-btn>-->
                                            <!--</v-card-actions>-->
                                        </v-card>
                                    </v-flex>
                                </v-layout>
                            </v-container>
                        </v-card>
                    </v-card>
                </v-flex>
            </v-layout>
        </v-app>
    </div>
</template>

<script>
    import axios from 'axios';
    export default {
        data () {
            return {
                questionList: [
                    {
                        title: '如何评价……',
                        description: '就熬ID骄傲 i 到的就爱上',
                    }
                ]
            }
        },
        methods: {
            getQuestionList() {
                // 获取问题列表
                axios.get('http://127.0.0.1:5000/api/questions/get_question', {
                    responseType: 'json',
                }).then((response) => {
                    // console.log(response.data.data);
                    this.questionList = response.data.data;
                })
            },
            turnToTopic() {
                this.$router.push('/topic');
            },
        },
        mounted() {
            this.getQuestionList();
        }
    }
</script>

<style scoped>

</style>
