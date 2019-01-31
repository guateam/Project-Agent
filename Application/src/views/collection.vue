<template>
    <div>
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
                    v-for="n in 4"
                    :key="n"
            >
                <v-layout row>
                    <v-flex xs12 sm6 offset-sm3>
                        <v-card>
                            <v-list two-line>
                                <template v-for="(item, index) in items">
                                    <v-list-tile
                                            :key="item.title"
                                            avatar
                                            ripple
                                            @click="toggle(index)"
                                    >
                                        <v-list-tile-content>
                                            <v-list-tile-title>{{ item.title }}</v-list-tile-title>
                                            <v-list-tile-sub-title class="text--primary">{{ item.headline }}</v-list-tile-sub-title>
                                            <v-list-tile-sub-title>{{ item.subtitle }}</v-list-tile-sub-title>
                                        </v-list-tile-content>

                                        <v-list-tile-action>
                                            <v-list-tile-action-text>{{ item.action }}</v-list-tile-action-text>
                                            <v-icon
                                            v-if="selected.indexOf(index) < 0"
                                            color="grey lighten-1"
                                            >
                                            star_border
                                            </v-icon>

                                            <v-icon
                                            v-else
                                            color="yellow darken-2"
                                            >
                                            star
                                            </v-icon>
                                        </v-list-tile-action>

                                    </v-list-tile>
                                    <v-divider
                                            v-if="index + 1 < items.length"
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
        name: "collection",
        data () {
            return {
                active: null,
                tabs:[
                    {title:'回答'},
                    {title:'提问'},
                    {title:'文章'},
                    {title:'专栏'},
                ],
                selected: [0,1,2,3],
                items: [
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
                ]
            }
        },
        methods: {}
    }
</script>

<style scoped>
</style>
