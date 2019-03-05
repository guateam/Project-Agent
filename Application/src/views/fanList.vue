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
                slider-color="#ffcc00"
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


                            <v-layout row>
                                <v-flex xs12 sm6 offset-sm3>
                                    <v-card>

                                        <v-list subheader>
                                            <v-subheader>特别关注</v-subheader>
                                            <v-list-tile
                                                    v-for="item in items1"
                                                    :key="item.title"
                                                    avatar
                                                    @click=""
                                            >
                                                <v-list-tile-avatar>
                                                    <img :src="item.avatar">
                                                </v-list-tile-avatar>

                                                <v-list-tile-content>
                                                    <v-list-tile-title v-html="item.title"></v-list-tile-title>
                                                </v-list-tile-content>

                                                <v-list-tile-action>
                                                    <v-icon color="teal">fas fa-badge-check</v-icon>
                                                </v-list-tile-action>
                                            </v-list-tile>
                                        </v-list>

                                        <v-divider></v-divider>

                                        <v-list subheader>
                                            <v-subheader>特别关注</v-subheader>
                                            <v-list-tile
                                                    v-for="item in items2"
                                                    :key="item.title"
                                                    avatar
                                                    @click=""
                                            >
                                                <v-list-tile-avatar>
                                                    <img :src="item.avatar">
                                                </v-list-tile-avatar>

                                                <v-list-tile-content>
                                                    <v-list-tile-title v-html="item.title"></v-list-tile-title>
                                                </v-list-tile-content>

                                                <v-list-tile-action>
                                                    <v-icon color="teal">fas fa-badge-check</v-icon>
                                                </v-list-tile-action>
                                            </v-list-tile>
                                        </v-list>
                                    </v-card>
                                </v-flex>
                            </v-layout>


                        </v-card>
                    </v-flex>
                </v-layout>
            </v-tab-item>
        </v-tabs>
    </div>
</template>

<script>
    export default {
        name: "fanList",
        data() {
            return {
                active: 0,
                tabs: [
                    {title: '我的关注'},
                    {title: '我的粉丝'}
                ],
                selected: [2],
                items1: [
                    { title: '满莫安', avatar: 'https://cdn.vuetifyjs.com/images/lists/3.jpg' },
                    { title: '钱欠延', avatar: 'https://cdn.vuetifyjs.com/images/lists/4.jpg' }
                ],
                items2: [
                    { active: true, title: '张三', avatar: 'https://cdn.vuetifyjs.com/images/lists/1.jpg' },
                    { active: true, title: '赵四', avatar: 'https://cdn.vuetifyjs.com/images/lists/2.jpg' },
                    { title: '满莫安', avatar: 'https://cdn.vuetifyjs.com/images/lists/3.jpg' },
                    { title: '钱欠延', avatar: 'https://cdn.vuetifyjs.com/images/lists/4.jpg' }
                ],
            }
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
