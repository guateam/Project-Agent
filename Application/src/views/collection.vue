<template>
    <div class="bigbox">
        <v-toolbar color="white" flat>
            <v-btn icon light @click="$router.push({name: 'myself'})">
                <v-icon color="grey darken-2">arrow_back</v-icon>
            </v-btn>

            <v-toolbar-title class="grey--text text--darken-4">我的收藏</v-toolbar-title>
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
                ],
                selected: [0,1,2,3],
                items: [
                    [],[],[]
                ]
            }
        },
        methods: {
            getCollections(){
                import('axios').then(axios => {
                    import('js-cookie').then((Cookies) => {
                        axios.get('https://'+this.GLOBAL.host+'/api/account/get_collections', {
                            responseType: 'json',
                            params: {
                                token:Cookies.get('token')
                            }
                        }).then(res => {
                            if (res.data.code === 1) {
                                this.items=res.data.data;
                            }
                        })
                    })
                })
            }
        },
        mounted() {
            this.getCollections()
        }
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
