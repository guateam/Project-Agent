<template>
    <div class="message">

        <v-layout row>
            <v-flex xs12 sm6 offset-sm3>
                <v-card>
                    <v-toolbar color="white" tabs>
                        <v-toolbar-title style="width: 100%;text-align: center">我的消息</v-toolbar-title>
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



        <v-tabs-items v-model="tabs">
            <v-tab-item :key="1">
                <v-card>
                    <v-list two-line>
                        <template v-for="(item, index) in items">
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
                22222
            </v-tab-item>
            <v-tab-item :key="3">
                33333
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
        data () {
            return {
                tabs: 0,
                items: [
                    { header: '今天' },
                    {
                        avatar: 'https://cdn.vuetifyjs.com/images/lists/1.jpg',
                        title: 'Brunch this weekend?',
                        subtitle: "I'll be in your neighborhood doing errands this weekend. Do you want to hang out?"
                    },
                    { divider: true, inset: true },
                    {
                        avatar: 'https://cdn.vuetifyjs.com/images/lists/2.jpg',
                        title: 'Summer BBQ',
                        subtitle: "Wish I could come, but I'm out of town this weekend."
                    },
                    { divider: true, inset: true },
                    {
                        avatar: 'https://cdn.vuetifyjs.com/images/lists/3.jpg',
                        title: 'Oui oui',
                        subtitle: "Do you have Paris recommendations? Have you ever been?"
                    },
                ]
            }
        },
    }
</script>

<style scoped>
</style>
