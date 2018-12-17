<template>
    <div class="message">
        <v-layout row>
            <v-flex xs12 sm6 offset-sm3>
                <v-card>
                    <v-toolbar color="white" dense>
                        <v-toolbar-title>我的消息</v-toolbar-title>

                        <v-spacer></v-spacer>

                        <v-btn icon>
                            <v-icon>search</v-icon>
                        </v-btn>

                        <v-tabs
                                slot="extension"
                                color="white"
                                slider-color="#FFCC00"
                                centered
                        >
                            <v-tab
                                    v-for="(tab, index) in tabs"
                                    :key="index"
                            >
                                {{ tab }}
                            </v-tab>
                        </v-tabs>

                    </v-toolbar>

                    <v-list two-line>
                        <template v-for="(item, index) in items">
                            <v-subheader
                                    v-if="item.header"
                                    :key="item.header"
                            >
                                {{ item.header }}
                            </v-subheader>

                            <v-divider
                                    v-else-if="item.divider"
                                    :inset="item.inset"
                                    :key="index"
                            ></v-divider>

                            <v-list-tile
                                    v-else
                                    :key="item.title"
                                    avatar
                            >
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
            </v-flex>
        </v-layout>

    </div>
</template>

<script>
    export default {
        name: "message",
        data () {
            return {
                tabs: ['私信', '好友', '通知', '群组'],
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
