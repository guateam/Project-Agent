<template>
    <v-container fluid grid-list-md>
        <v-layout row wrap>
            <v-flex d-flex xs12 sm6 md3>
                <v-card color="white lighten-2" dark>
                    <v-layout row wrap>
                        <v-flex d-flex>
                            <v-layout row wrap>
                                <v-flex d-flex xs6>
                                    <v-card color="blue lighten-2" dark>
                                        <v-card-text style="display: flex ;align-items: center;justify-content: center;">余额</v-card-text>
                                    </v-card>
                                </v-flex>
                                <v-flex d-flex xs6>
                                    <v-card color="blue lighten-2" dark>
                                        <v-card-text style="display: flex ;align-items: center;justify-content: center;">卡券</v-card-text>
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
</template>

<script>
    export default {
        name: "wallet",
        data(){
            return{
                items: [
                    { title: '交易记录', name:'oldpost'},
                    { title: '积分',  name:'collection'},
                    { title: '地址管理', name:'wallet'},
                    { title: '设置', name:'settings'},
                    { title: '客服中心  ', name:'settings'},
                ]
            }
        }
    }
</script>

<style scoped>
.foot{
    position: absolute;
    bottom: 0;
}
</style>
