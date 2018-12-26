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
                            v-for="item in items2"
                            v-model="item.active"
                            :key="item.title"
                            :prepend-icon="item.action"
                            no-action
                    >
                        <v-list-tile slot="activator">
                            <v-list-tile-content>
                                <v-list-tile-title>{{ item.title }}</v-list-tile-title>
                            </v-list-tile-content>
                        </v-list-tile>

                        <v-list-tile
                                v-for="subItem in item.items"
                                :key="subItem.title"
                        >
                            <v-list-tile-content>
                                <v-list-tile-title>{{ subItem.title }}</v-list-tile-title>
                            </v-list-tile-content>

                            <v-list-tile-action>
                                <v-icon>{{ subItem.action }}</v-icon>
                            </v-list-tile-action>
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
                        <v-list-tile v-else :key="item.title" avatar  @click="$router.push('./approval')">
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
                        <v-list-tile v-else :key="item.title" avatar  @click="$router.push('./callme')">
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
                items2: [
                    {
                        action: 'local_activity',
                        title: '分组一',
                        items: [
                            {title: '赵一'}
                        ]
                    },
                    {
                        action: 'restaurant',
                        title: '分组二',
                        active: true,
                        items: [
                            {title: '钱二'},
                            {title: '孙三'},
                            {title: '李四'}
                        ]
                    },
                    {
                        action: 'school',
                        title: '分组三',
                        items: [
                            {title: '周五'}
                        ]
                    }
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
    }
</script>

<style scoped>
</style>
