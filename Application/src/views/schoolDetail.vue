


<!--布局有问题。。。。。页面高度貌似跟着父页面走了。。。等待修复-->




<template>
    <div class="bigbox">
        <v-container fluid grid-list-sm>
            <v-layout row wrap>
                <v-flex d-flex xs12 order-xs5>
                    <v-layout column>
                        <v-flex d-flex>
                            <!--主讲人信息，先搭框框懒得写就一个用户名，对接的时候后台直接把头像标签啥的信息全传过来吧-->
                            <v-card color="blue-grey" dark tile flat>
                                <v-card-text>大漠孤烟</v-card-text>
                            </v-card>
                        </v-flex>
                        <v-flex d-flex>
                            <v-card color="red lighten-2" dark tile flat>
                                <v-card-text>主讲人的个人简介主讲人的个人简介主讲人的个人简介主讲人的个人简介主讲人的个人简介主讲人的个人简介主讲人的个人简介</v-card-text>
                            </v-card>
                        </v-flex>
                        <v-flex d-flex>
                            <v-card color="indigo lighten-2" dark tile flat>
                                <v-card-text>
                                    <h3>课程简介</h3>
                                    <p>文章简介文章简介文章简介文章简介文章简介文章简介文章简介文章简介文章简介文章简介文章简介文章简介文章简介文章简介文章简介文章简介文章简介文章简介文章简介文章简介文章简介文章简介文章简介文章简介文章简介文章简介文章简介文章简介文章简介文章简介文章简介文章简介文章简介文章简介文章简介文章简介文章简介文章简介文章简介文章简介文章简介文章简介文章简介文章简介文章简介文章简介文章简介文章简介文章简介文章简介文章简介文章简介文章简介文章简介文章简介</p>
                                </v-card-text>
                            </v-card>
                        </v-flex>
                        <v-flex d-flex>
                            <v-card color="cyan darken-2" dark tile flat>
                                <v-card-text>
                                    <v-rating
                                            value="3.5"
                                            background-color="orange lighten-3"
                                            color="orange"
                                            disabled
                                            medium
                                            readonly
                                    ></v-rating>
                                </v-card-text>
                            </v-card>
                        </v-flex>
                        <v-flex d-flex>
                            <v-card color="blue-grey lighten-3" dark tile flat>
                                <v-card-text>
                                    <v-timeline>
                                        <v-timeline-item v-for="(year, i) in years" :key="i" :color="year.color" small>
                                            <span slot="opposite" :class="`headline font-weight-bold ${year.color}--text`" v-text="year.year"></span>
                                            <div class="py-3">
                                                <h2 :class="`headline font-weight-light mb-3 ${year.color}--text`">寻路</h2>
                                                <div>
                                                    Vue.js生命周期深入浅出
                                                </div>
                                            </div>
                                        </v-timeline-item>
                                    </v-timeline>
                                </v-card-text>
                            </v-card>
                        </v-flex>
                        <v-flex d-flex>
                            <v-card color="cyan darken-2" dark tile flat>
                                <v-card-text>更多推荐</v-card-text>
                            </v-card>
                        </v-flex>
                    </v-layout>
                </v-flex>
            </v-layout>
        </v-container>
        <div class="foot">立即参与 （<span>￥998</span>）</div>
    </div>
</template>

<script>
    export default {
        name: "schoolDetail",
        data() {
            return {
                rating: '3',
                lorem: `Lorem ipsum dolor sit amet, mel at clita quando. Te sit oratio vituperatoribus, nam ad ipsum posidonium mediocritatem, explicari dissentiunt cu mea. Repudiare disputationi vim in, mollis iriure nec cu, alienum argumentum ius ad. Pri eu justo aeque torquatos.`,
                years: [
                    {
                        color: 'cyan',
                        year: '第一章'
                    },
                    {
                        color: 'green',
                        year: '第二章'
                    },
                    {
                        color: 'pink',
                        year: '第三章'
                    },
                    {
                        color: 'amber',
                        year: '第四章'
                    },
                    {
                        color: 'orange',
                        year: '第五章'
                    }
                ]
            }
        }
    }
</script>

<style scoped>
    .bigbox {
        position: absolute;
        width: 100%;
        height: 100%;
        z-index: 200;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background-color: white;
    }

    .foot {
        position: fixed;
        display: flex;
        z-index: 250;
        border-top: 1px solid #eee;
        height: 4.3em;
        align-items: center;
        justify-content: center;
        background-color: royalblue;
    }
</style>
