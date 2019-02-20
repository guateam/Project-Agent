<template>
    <div class="message">

        <v-layout row>
            <v-flex xs12 offset-sm3>
                <v-card>
                    <v-toolbar color="white" tabs>
                        <v-toolbar-title style="width: 100%; text-align: center;">我的消息</v-toolbar-title>
                        <v-tabs slot="extension" v-model="tabs" centered color="white" slider-color="#FFCC00">
                            <v-tab :key="1">私聊</v-tab>
                            <v-tab :key="2">好友</v-tab>
                            <v-tab :key="3">通知</v-tab>
                            <v-tab :key="4">群组</v-tab>
                        </v-tabs>
                    </v-toolbar>
                </v-card>
            </v-flex>
        </v-layout>

        <div style="margin-top: 1em;"></div>

        <v-tabs-items v-model="tabs">
            <v-tab-item :key="1">
                <v-card>
                    <v-list two-line>
                        <template v-for="(item, index) in items1">
                            <v-subheader v-if="item.header" :key="item.header">
                                {{ item.header }}
                            </v-subheader>
                            <v-divider v-else-if="item.divider" :inset="item.inset" :key="index"></v-divider>
                            <v-list-tile v-else :key="item.title" avatar @click="$router.push('./chat')">
                                <v-list-tile-avatar>
                                    <img :src="item.avatar">
                                </v-list-tile-avatar>
                                <v-list-tile-content>
                                    <v-list-tile-title v-html="item.title"></v-list-tile-title>
                                    <v-list-tile-sub-title v-html="item.subtitle"></v-list-tile-sub-title>
                                </v-list-tile-content>
                            </v-list-tile>
                        </template>
                    </v-list>
                </v-card>


            </v-tab-item>
            <v-tab-item :key="2">
                <v-list>
                    <v-list-group
                            v-for="item in friendList"
                            v-model="item.active"
                            :key="item.title"
                            no-action
                    >
                        <!--:prepend-icon="item.action"-->
                        <v-list-tile slot="activator">
                            <v-list-tile-content>
                                <v-list-tile-title>{{ item.title }}</v-list-tile-title>
                            </v-list-tile-content>
                        </v-list-tile>

                        <v-list-tile
                                v-for="subItem in item.items"
                                :key="subItem.nickname"
                        >
                            <v-list-tile-avatar>
                                <img :src="subItem.headportrait">
                            </v-list-tile-avatar>
                            <v-list-tile-content>
                                <v-list-tile-title>{{ subItem.nickname }}</v-list-tile-title>
                            </v-list-tile-content>

                            <!--<v-list-tile-action>-->
                            <!--<v-icon>{{ subItem.action }}</v-icon>-->
                            <!--</v-list-tile-action>-->
                        </v-list-tile>
                    </v-list-group>
                </v-list>
            </v-tab-item>
            <v-tab-item :key="3">
                <v-list two-line>
                    <template v-for="(item, index) in items3">
                        <v-subheader v-if="item.header" :key="item.header">
                            {{ item.header }}
                        </v-subheader>
                        <v-divider v-else-if="item.divider" :inset="item.inset" :key="index"></v-divider>
                        <v-list-tile v-else :key="item.title" avatar @click="$router.push('./approval')">
                            <v-list-tile-avatar>
                                <img :src="item.avatar">
                            </v-list-tile-avatar>
                            <v-list-tile-content>
                                <v-list-tile-title v-html="item.title"></v-list-tile-title>
                                <v-list-tile-sub-title v-html="item.subtitle"></v-list-tile-sub-title>
                            </v-list-tile-content>
                        </v-list-tile>
                    </template>
                </v-list>

                <v-divider></v-divider>

                <v-list two-line>
                    <template v-for="(item, index) in items4">
                        <v-subheader v-if="item.header" :key="item.header">
                            {{ item.header }}
                        </v-subheader>
                        <v-divider v-else-if="item.divider" :inset="item.inset" :key="index"></v-divider>
                        <v-list-tile v-else :key="item.title" avatar @click="$router.push('./callme')">
                            <v-list-tile-avatar>
                                <img :src="item.avatar">
                            </v-list-tile-avatar>
                            <v-list-tile-content>
                                <v-list-tile-title v-html="item.title"></v-list-tile-title>
                                <v-list-tile-sub-title v-html="item.subtitle"></v-list-tile-sub-title>
                            </v-list-tile-content>
                        </v-list-tile>
                    </template>
                </v-list>
            </v-tab-item>
            <v-tab-item :key="4">
                44444
            </v-tab-item>
        </v-tabs-items>

    </div>
</template>

<script>
    export default {
        name: "message",
        data() {
            return {
                tabs: 0,
                items1: [
                    {header: '今天'},
                    {
                        avatar: 'https://cdn.vuetifyjs.com/images/lists/1.jpg',
                        title: 'Brunch this weekend?',
                        subtitle: "I'll be in your neighborhood doing errands this weekend. Do you want to hang out?"
                    },
                    {divider: true, inset: true},
                    {
                        avatar: 'https://cdn.vuetifyjs.com/images/lists/2.jpg',
                        title: 'Summer BBQ',
                        subtitle: "Wish I could come, but I'm out of town this weekend."
                    },
                    {divider: true, inset: true},
                    {
                        avatar: 'https://cdn.vuetifyjs.com/images/lists/3.jpg',
                        title: 'Oui oui',
                        subtitle: "Do you have Paris recommendations? Have you ever been?"
                    },
                ],
                friendList: [
                    {
                        title: '分组一',
                        active: true,
                        items: [
                            {nickname: '赵一', user_id: -1,},
                        ]
                    },
                ],
                items3: [
                    {header: '今天'},
                    {
                        avatar: 'https://cdn.vuetifyjs.com/images/lists/1.jpg',
                        title: '系统消息',
                        subtitle: "您有新的系统通知。"
                    },
                    {divider: true, inset: true},
                    {
                        avatar: 'https://cdn.vuetifyjs.com/images/lists/2.jpg',
                        title: '踩和赞',
                        subtitle: "赵一和王五赞了您的回答"
                    },
                    {divider: true, inset: true},
                    {
                        avatar: 'https://cdn.vuetifyjs.com/images/lists/3.jpg',
                        title: '评论和回复',
                        subtitle: "神奇的我等十人回复了你的评论"
                    },
                ],
                items4: [
                    {header: '昨天'},
                    {
                        avatar: 'https://cdn.vuetifyjs.com/images/lists/1.jpg',
                        title: '@我的',
                        subtitle: "用户123@了你"
                    }
                ],
            }
        },
        methods: {
            get_friend_list() {
                // 获取好友列表
                import('js-cookie').then((Cookies) => {
                    import('axios').then((axios) => {
                        axios.get('https://'+this.GLOBAL.host+'/api/message/get_friend_list', {
                            responseType: 'json',
                            params: {
                                token: this.GLOBAL.token,
                            }
                        }).then((response) => {
                            window.console.log(this.friendList[0]);
                            this.friendList[0].items = response.data.data;
                        })
                    })
                })
            },
            get_message_list() {
                import('js-cookie').then((Cookies) => {
                    import('axios').then((axios) => {
                        axios.get('https://'+this.GLOBAL.host+'/api/message/get_message_list', {
                            responseType: 'json',
                            params: {
                                token: this.GLOBAL.token,
                            }
                        }).then((data) => {
                            if (data.data.code === 1) {
                                data = data.data.data;
                                let date = new Date();
                                let items = [];
                                items.push({header: date.Format('MM-dd')});
                                data.forEach((value) => {
                                    let new_date = new Date(value['post_time'] + ' 00:00:00');
                                    if (new_date < date) {
                                        items.push({header: new_date.Format('MM-dd')});
                                    }
                                    items.push({
                                        avatar: value['headportrait'],
                                        title: value['nickname'],
                                        subtitle: value['content']
                                    });
                                    items.push({divider: true, inset: true})
                                });
                                this.items1 = items
                            }
                        })
                    })
                })
            }
        },
        mounted() {
            this.get_friend_list();
            this.get_message_list();
            // import('js-cookie').then((Cookies) => {
            //     import('axios').then((axios) => {
            //         axios.get('http://127.0.0.1:5000/api/message/get_message_list', {
            //             responseType: 'json',
            //             params: { token: this.GLOBAL.token }
            //         }).then((response) => {
            //             let data_list = response.data.data;
            //             window.console.log(data_list);
            //         })
            //     })
            // })
        }
    }
</script>

<style scoped>
</style>
