<template>
    <div class="myself">
        <div class="head" @click="$router.push('/login')">
            <div class="head-main">
                <div class="head-items">
                    <div class="pic">
                        <img :src="head_portrait" alt="">
                    </div>
                    <div style="display: flex;justify-content: space-between;flex-direction: column;">
                        <div style="margin-left: 0.8em">
                            <span style="font-size: 1.5em;font-weight: 600">{{nickname}}</span>
                            <span style="border: 2px solid black;border-radius: 5px;padding: 0.3em;margin-left: 0.5em">{{ group }}</span>
                        </div>
                        <div style="margin-left: 0.8em;display: flex;align-items: center">
                            <span style="font-size: 1.3em;font-weight: 600;position: absolute;width: 2.5em">lv.1</span>
                            <v-progress-linear style="margin-left: 3em" v-model="valueDeterminate" color="#F93E2C"
                                               height="10"></v-progress-linear>
                        </div>
                    </div>
                </div>
                <div style="font-size: 2.5em"> ></div>
            </div>
        </div>
        <div class="box">
            <div class="box-main">
                <div class="box-main-items" style="border-right: 2px black solid;">关注 <span class="box-number">22</span>
                </div>
                <div class="box-main-items">粉丝 <span class="box-number">3</span></div>
            </div>
        </div>
        <div class="main">
            <v-list three-line>
                <v-list-tile
                        v-for="item in items"
                        :key="item.title"
                        avatar
                        @click="$router.push({name: 'settings'})"
                >
                    <v-list-tile-avatar>
                        <!--图片和icon都应该改一下，先做完懒得去找icon-->
                        <img :src="item.avatar">
                    </v-list-tile-avatar>

                    <v-list-tile-content>
                        <v-list-tile-title v-html="item.title"></v-list-tile-title>
                    </v-list-tile-content>

                    <v-list-tile-action>
                        <v-icon :color="item.active ? 'teal' : 'grey'">chat_bubble</v-icon>
                    </v-list-tile-action>
                </v-list-tile>
            </v-list>
        </div>
    </div>
</template>

<script>
    import axios from 'axios'

    export default {
        name: "myself",
        data() {
            return {
                nickname: '默认用户名',  // 用户名
                head_portrait: 'https://cdn.vuetifyjs.com/images/lists/1.jpg',
                valueDeterminate: 50,  // 经验等级进度条
                group: '未知',
                items: [
                    {active: true, title: '我发布的', avatar: 'https://cdn.vuetifyjs.com/images/lists/1.jpg'},
                    {active: true, title: '我的收藏', avatar: 'https://cdn.vuetifyjs.com/images/lists/2.jpg'},
                    {title: '我的钱包', avatar: 'https://cdn.vuetifyjs.com/images/lists/3.jpg'},
                    {title: '设置', avatar: 'https://cdn.vuetifyjs.com/images/lists/4.jpg'}
                ],
            }
        },
        methods: {
            get_user_info() {
                import('js-cookie').then((Cookies) => {
                    let token = Cookies.get('token');
                    axios.get('http://127.0.0.1:5000/api/route/get_user_by_token', {
                        responseType: 'json',
                        params: {
                            token: token,
                        }
                    }).then((response) => {
                        let group = {
                            0: '从业者',
                            1: '专家',
                        };
                        let user_info = response.data.data;
                        this.nickname = user_info.nickname;
                        this.valueDeterminate = user_info.exp;
                        this.head_portrait = user_info.head_portrait;
                        this.group = group[user_info['user_group']];
                    });
                });
            }
        },
        mounted() {
            this.get_user_info();
        }
    }
</script>

<style scoped>
    .myself {
        width: 100%;
        height: 100%;
        margin: 0;
        padding: 0;
        line-height: 1.5;
    }

    .myself p {
        margin-bottom: 0;
    }

    .head {
        height: 16em;
        width: 100%;
        background-color: #FFCC00;
        display: flex;;
        align-items: center;;
        justify-content: center;
    }

    .head-main {
        width: 100%;
        height: 6em;
        padding-left: 1.5em;
        padding-right: 1.5em;
        background-color: transparent;
        display: flex;
        align-items: center;
        justify-content: space-between;
    }

    .pic {
        width: 5em;
        height: 5em;
        overflow: hidden;
        border-radius: 50%;
    }

    .pic img {
        width: 5em;
        height: 5em;
        overflow: hidden;
        border-radius: 50%;
    }

    .head-items {
        display: flex;
        align-items: center;
    }

    .box {
        width: 100%;
        height: 6em;
        background-color: transparent;
        margin-top: -3em;
        display: flex;;
        align-items: center;
        justify-content: center;
    }

    .box-main {
        width: 78%;
        height: 4.6em;
        border-radius: 10px;
        box-shadow: 0 0 3px #888888;
        background-color: white;
        border: 2px solid #eee;
        display: flex;
        align-items: center;
    }

    .box-main-items {
        display: flex;
        flex: 0 0 50%;
        padding-left: 1.9em;
        align-items: center;
    }

    .box-number {
        margin-left: 1.7em;
        font-size: 1.4em;
        font-weight: 600
    }

    .main {
        width: 100%;
        background-color: white;
        margin-top: 2em;
    }
</style>