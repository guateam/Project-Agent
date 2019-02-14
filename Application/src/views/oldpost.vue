<template>
    <div class="bigbox">
        <v-toolbar color="white" flat>
            <v-btn icon light @click="$router.push({name: 'myself'})">
                <v-icon color="grey darken-2">arrow_back</v-icon>
            </v-btn>

            <v-toolbar-title class="grey--text text--darken-4">我发布的</v-toolbar-title>
        </v-toolbar>

        <v-divider></v-divider>
        <v-tabs
                v-model="active"
                color="cyan"
                dark
                slider-color="yellow"
        >
            <v-tab
                    v-for="item in tabs"
                    ripple
            >
                {{ item.title}}

            </v-tab>
            <v-tab-item
                    v-for="n in tabs.length"
                    :key="n"
            >
                <v-layout row>
                    <v-flex xs12 sm6 offset-sm3>
                        <v-card>
                            <v-list two-line>
                                <template v-for="(item, index) in items[n-1]">
                                    <v-list-tile
                                            :key="item.id"
                                            avatar
                                            ripple
                                            @click="toggle(index)"
                                    >
                                        <v-list-tile-content>
                                            <v-list-tile-title>{{ item.title }}</v-list-tile-title>
                                            <v-list-tile-sub-title class="text--primary">{{ item.headline }}
                                            </v-list-tile-sub-title>
                                            <v-list-tile-sub-title>{{ item.subtitle }}</v-list-tile-sub-title>
                                        </v-list-tile-content>

                                        <v-list-tile-action>
                                            <v-list-tile-action-text>{{ item.action }}</v-list-tile-action-text>
                                            <!--<v-icon-->
                                            <!--v-if="selected.indexOf(index) < 0"-->
                                            <!--color="grey lighten-1"-->
                                            <!--&gt;-->
                                            <!--star_border-->
                                            <!--</v-icon>-->

                                            <!--<v-icon-->
                                            <!--v-else-->
                                            <!--color="yellow darken-2"-->
                                            <!--&gt;-->
                                            <!--star-->
                                            <!--</v-icon>-->
                                        </v-list-tile-action>

                                    </v-list-tile>
                                    <v-divider
                                            v-if="index + 1 < items[n-1].length"
                                            :key="index"
                                    ></v-divider>
                                </template>
                            </v-list>
                        </v-card>
                    </v-flex>
                </v-layout>
            </v-tab-item>
        </v-tabs>
    </div>
</template>

<script>
    export default {
        name: "oldpost",
        data() {
            return {
                active: 1,
                tabs: [
                    {title: '回答'},
                    {title: '提问'},
                    {title: '文章'},
                ],
                selected: [2],
                items: [
                    [], [
                        {
                            action: '15 min',
                            headline: '去你大爷的你才是非酋非酋非酋非酋非酋非酋非酋非酋非酋非酋非酋非酋非酋非酋非酋非酋非酋非酋非酋非酋非酋非酋非酋非酋非酋非酋非酋',
                            title: '为什么有些非洲人就是不愿意承认自己的血统？',
                            subtitle: "3赞同  ·  4评论"
                        },
                        {
                            action: '2 hr',
                            headline: '',
                            title: '请问什么姿势才能捞到闪电然后单抽出紫雨心？',
                            subtitle: "8回答  ·  4评论"
                        },
                        {
                            action: '6 hr',
                            headline: '这里应该是文章的内容吧emmm这里应该是文章的内容吧emmm这里应该是文章的内容吧emmm',
                            title: '假装这里是一篇文章',
                            subtitle: '4赞同  ·  4评论'
                        },
                        {
                            action: '12 hr',
                            headline: '不然太像知乎了',
                            title: '专栏？应该没有这玩意',
                            subtitle: '3订阅  ·  9评论'
                        }
                    ], [], []
                ]
            }
        },
        methods: {
            get_my_questions() {
                import('js-cookie').then((Cookies) => {
                    import('axios').then((axios) => {
                        axios.get('http://localhost:5000/api/questions/get_my_questions', {
                            responseType: 'json',
                            params: {
                                token: Cookies.get('token'),
                            }
                        }).then((data) => {
                            if (data.data.code === 1) {
                                data = data.data.data;
                                let items = [];
                                data.forEach((value) => {
                                    items.push({
                                        title: value['title'],
                                        headline: value['description'],
                                        action: this.get_date(value['edittime']),
                                        subtitle: value['follow'] + '订阅  ·  ' + value['comments'] + '评论',
                                        id:'q'+value['questionID']
                                    })
                                });
                                this.items[1] = items
                            }
                        })
                    })
                })
            },
            get_date(date) {
                let old = new Date(date);
                let now = new Date();
                let time = now.getTime() - old.getTime();
                if (time < 60 * 1000) {
                    return "刚刚"
                } else if (time > 60 * 1000 && time < 60 * 60 * 1000) {
                    return time / 60 / 1000 + '分钟前'
                } else if (time > 60 * 60 * 1000 && time < 24 * 60 * 60 * 1000) {
                    return time / 60 / 60 / 1000 + '小时前'
                } else if (time > 24 * 60 * 60 * 1000 && time < 10 * 60 * 60 * 1000) {
                    return time / 24 / 60 / 60 / 1000 + '天前'
                } else {
                    return old.Format('MM-dd')
                }
            },
            get_my_answers() {
                import('js-cookie').then((Cookies) => {
                    import('axios').then((axios) => {
                        axios.get('http://localhost:5000/api/answer/get_user_answers', {
                            responseType: 'json',
                            params: {
                                token: Cookies.get('token'),
                            }
                        }).then((data) => {
                            if (data.data.code === 1) {
                                data = data.data.data;
                                let items = [];
                                data.forEach((value) => {
                                    items.push({
                                        title: value['content'],
                                        headline: value['title'],
                                        action: this.get_date(value['edittime']),
                                        subtitle: value['follow'] + '订阅  ·  ' + value['comments'] + '评论',
                                        id:'an'+value['answerID']
                                    })
                                });
                                this.items[0] = items
                            }
                        })
                    })
                })
            },
            get_my_articles() {
                import('js-cookie').then((Cookies) => {
                    import('axios').then((axios) => {
                        axios.get('http://localhost:5000/api/article/get_user_articles', {
                            responseType: 'json',
                            params: {
                                token: Cookies.get('token'),
                            }
                        }).then((data) => {
                            if (data.data.code === 1) {
                                data = data.data.data;
                                let items = [];
                                data.forEach((value) => {
                                    items.push({
                                        title: value['title'],
                                        headline: value['content'],
                                        action: this.get_date(value['edittime']),
                                        subtitle: value['follow'] + '订阅',
                                        id:'ar'+value['articleID']
                                    })
                                });
                                this.items[2] = items
                            }
                        })
                    })
                })
            },
            get_category() {
                import('js-cookie').then((Cookies) => {
                    import('axios').then((axios) => {
                        axios.get('http://localhost:5000/api/article/get_article_allowed_group', {
                            responseType: 'json',
                            params: {
                                token: Cookies.get('token'),
                            }
                        }).then((data) => {
                            if (data.data.code === 1) {
                                this.tabs = [
                                    {title: '回答'},
                                    {title: '提问'},
                                    {title: '文章'},
                                ];
                                this.get_my_articles()
                            }else if(data.data.code===-1){
                                this.tabs = [
                                    {title: '回答'},
                                    {title: '提问'},
                                ]
                            }else {
                                this.tabs=[
                                    {title:'错误'}
                                ]
                            }
                        })
                    })
                })
            }
        },
        mounted() {
            this.get_my_answers();
            this.get_my_questions();
            this.get_category();

        },
    }
</script>

<style scoped>
    .bigbox {
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
</style>
