<template>
    <div id="e3" style="max-width: 400px; margin: auto;" class="grey lighten-3">
        <v-container fluid grid-list-lg style="background-color: white;">
            <v-layout row wrap>
                <!--留着懒得删，万一有用呢，反正这个页面还要改-->
                <!--<v-flex xs12>-->
                    <!--<v-card color="blue-grey darken-2" class="white&#45;&#45;text">-->
                        <!--<v-card-title primary-title>-->
                            <!--<div>-->
                                <!--<div class="headline">Unlimited music now</div>-->
                                <!--<span>Listen to your favorite artists and albums whenever and wherever, online and offline.</span>-->
                            <!--</div>-->
                        <!--</v-card-title>-->
                        <!--<v-card-actions>-->
                            <!--<v-btn flat dark>Listen now</v-btn>-->
                        <!--</v-card-actions>-->
                    <!--</v-card>-->
                <!--</v-flex>-->

                <v-flex xs12>
                    <v-card color="cyan darken-2" class="white--text">
                        <v-layout>
                            <v-flex xs5>
                                <v-img
                                        src="https://cdn.vuetifyjs.com/images/cards/foster.jpg"
                                        height="125px"
                                        contain
                                ></v-img>
                            </v-flex>
                            <v-flex xs7>
                                <v-card-title primary-title>
                                    <div>
                                        <div class="headline">Vue.js的过去现在和将来</div>
                                        <div>大漠孤烟 &nbsp;&nbsp;&nbsp; <span>2018/12/30</span></div>
                                        <div style="color: #ff4d4d;font-weight: 600;">￥99.98</div>
                                    </div>
                                </v-card-title>
                            </v-flex>
                        </v-layout>
                        <v-divider light></v-divider>
                        <v-card-actions class="pa-3">
                            查看详情
                            <v-spacer></v-spacer>
                            <v-rating
                                    value="3.5"
                                    background-color="orange lighten-3"
                                    color="orange"
                                    disabled
                                    medium
                                    readonly
                            ></v-rating>
                        </v-card-actions>
                    </v-card>
                </v-flex>

                <v-flex xs12>
                    <v-card color="indigo lighten-2" class="white--text">
                        <v-layout row>
                            <v-flex xs7>
                                <v-card-title primary-title>
                                    <div>
                                        <div class="headline">程序员如何有效预防颈椎病和秃头</div>
                                        <div>药别停还有救 &nbsp;&nbsp;&nbsp; <span>2019/01/09</span></div>
                                        <div style="color: #ff4d4d;font-weight: 600;">￥999.98</div>
                                    </div>
                                </v-card-title>
                            </v-flex>
                            <v-flex xs5>
                                <v-img
                                        src="https://cdn.vuetifyjs.com/images/cards/halcyon.png"
                                        height="125px"
                                        contain
                                ></v-img>
                            </v-flex>
                        </v-layout>
                        <v-divider light></v-divider>
                        <v-card-actions class="pa-3">
                            Rate this album
                            <v-spacer></v-spacer>
                            <v-rating
                                    value="4.5"
                                    background-color="orange lighten-3"
                                    color="orange"
                                    disabled
                                    medium
                                    readonly
                                    half-increments="true"
                            ></v-rating>
                        </v-card-actions>
                    </v-card>
                </v-flex>
                <v-flex xs12>
                    <v-card color="red lighten-2" class="white--text">
                        <v-layout>
                            <v-flex xs5>
                                <v-img
                                        src="https://cdn.vuetifyjs.com/images/cards/foster.jpg"
                                        height="125px"
                                        contain
                                ></v-img>
                            </v-flex>
                            <v-flex xs7>
                                <v-card-title primary-title>
                                    <div>
                                        <div class="headline">Vue.js的过去现在和将来</div>
                                        <div>大漠孤烟 &nbsp;&nbsp;&nbsp; <span>2018/12/30</span></div>
                                        <div style="color: #ff4d4d;font-weight: 600;">￥99.98</div>
                                    </div>
                                </v-card-title>
                            </v-flex>
                        </v-layout>
                        <v-divider light></v-divider>
                        <v-card-actions class="pa-3">
                            查看详情
                            <v-spacer></v-spacer>
                            <v-rating
                                    value="3.5"
                                    background-color="orange lighten-3"
                                    color="orange"
                                    disabled
                                    medium
                                    readonly
                            ></v-rating>
                        </v-card-actions>
                    </v-card>
                </v-flex>

                <v-flex xs12>
                    <v-card color="blue-grey" class="white--text">
                        <v-layout row>
                            <v-flex xs7>
                                <v-card-title primary-title>
                                    <div>
                                        <div class="headline">程序员如何有效预防颈椎病和秃头</div>
                                        <div>药别停还有救 &nbsp;&nbsp;&nbsp; <span>2019/01/09</span></div>
                                        <div style="color: #ff4d4d;font-weight: 600;">￥999.98</div>
                                    </div>
                                </v-card-title>
                            </v-flex>
                            <v-flex xs5>
                                <v-img
                                        src="https://cdn.vuetifyjs.com/images/cards/halcyon.png"
                                        height="125px"
                                        contain
                                ></v-img>
                            </v-flex>
                        </v-layout>
                        <v-divider light></v-divider>
                        <v-card-actions class="pa-3">
                            Rate this album
                            <v-spacer></v-spacer>
                            <v-rating
                                    value="4.5"
                                    background-color="orange lighten-3"
                                    color="orange"
                                    disabled
                                    medium
                                    readonly
                                    half-increments="true"
                            ></v-rating>
                        </v-card-actions>
                    </v-card>
                </v-flex>
            </v-layout>
        </v-container>
    </div>
</template>

<script>
    export default {
        name: "school",
        rating: '3'
    }
</script>

<style scoped>
.headline{
    overflow:hidden;
    display:-webkit-box;
    text-overflow:ellipsis;
    -webkit-line-clamp:2;
    -webkit-box-orient:vertical;
    white-space:normal;
}
</style>
