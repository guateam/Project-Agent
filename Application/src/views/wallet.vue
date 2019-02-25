<template>
    <div class="bigbox">
        <v-container fluid grid-list-md>
            <v-layout row wrap>
                <v-toolbar color="white" flat style="">
                    <v-btn icon light @click="$router.push({name: 'myself'})">
                        <v-icon color="grey darken-2">arrow_back</v-icon>
                    </v-btn>
                    <v-toolbar-title class="grey--text text--darken-4">我的钱包</v-toolbar-title>
                </v-toolbar>
                <div style="width: 100%;height: 1px;background-color: black;margin-bottom: 1em;"></div>
                <v-flex d-flex xs12 sm6 md3>
                    <v-card color="white lighten-2" dark>
                        <v-layout row wrap>
                            <v-flex d-flex>
                                <v-layout row wrap>
                                    <v-flex d-flex xs6>
                                        <v-card color="blue lighten-2" dark>
                                            <v-card-text
                                                    style="display: flex ;align-items: center;justify-content: center;">
                                                余额: ￥{{wallet}}
                                            </v-card-text>
                                        </v-card>
                                    </v-flex>
                                    <v-flex d-flex xs6>
                                        <v-card color="blue lighten-2" dark>
                                            <v-card-text
                                                    style="display: flex ;align-items: center;justify-content: center;">
                                                卡券
                                            </v-card-text>
                                        </v-card>
                                    </v-flex>
                                </v-layout>
                            </v-flex>
                        </v-layout>
                    </v-card>
                </v-flex>
                <v-flex d-flex xs12 sm6 md3 style="margin-top: 2em">
                    <v-layout row wrap>
                        <v-flex d-flex>
                            <v-layout row wrap>
                                <v-flex
                                        v-for="item in items"
                                        @click="$router.push(item.name)"
                                        d-flex
                                        xs12
                                >
                                    <v-card
                                            color="red lighten-2"
                                            dark
                                    >
                                        <v-card-text>
                                            {{ item.title }}
                                        </v-card-text>
                                    </v-card>
                                </v-flex>
                            </v-layout>
                        </v-flex>
                    </v-layout>
                </v-flex>
            </v-layout>
        </v-container>
    </div>
</template>

<script>
    import axios from 'axios'

    export default {
        name: "wallet",
        data() {
            return {
                items: [
                    {title: '交易记录', name: 'oldpost'},
                    {title: '积分', name: 'collection'},
                    {title: '地址管理', name: 'wallet'},
                    {title: '设置', name: 'settings'},
                    {title: '客服中心  ', name: 'settings'},
                ],
                wallet: 0
            }
        },
        methods: {
            getWallet() {

                import('js-cookie').then((Cookies) => {
                    axios({
                        method: 'post',
                        url: 'https://'+this.GLOBAL.host+'/api/account/get_account_balance',
                        responseType: 'json',
                        data: {
                            token: this.GLOBAL.token
                        },
                        transformRequest: [function (data) {
                            // Do whatever you want to transform the data
                            let ret = '';
                            for (let it in data) {
                                ret += encodeURIComponent(it) + '=' + encodeURIComponent(data[it]) + '&'
                            }
                            return ret
                        }],
                        headers: {
                            'Content-Type': 'application/x-www-form-urlencoded'
                        }
                    }).then((res) => {
                        if (res.data.code === 1) {
                            this.wallet = res.data.data
                        }
                    })
                })

            }
        },
        mounted() {
            this.getWallet()
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
