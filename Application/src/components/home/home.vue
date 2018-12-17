<template>
    <div class="home">
        <div>
            <v-toolbar
                    color="#0065cc"
                    dark
                    tabs
                    style="padding-top: 1em"
            >
                <v-text-field
                        append-icon="mic"
                        class="mx-3"
                        flat
                        label="Search"
                        prepend-inner-icon="search"
                        solo-inverted
                ></v-text-field>

                <v-tabs
                        slot="extension"
                        v-model="tabs"
                        centered
                        color="transparent"
                        slider-color="white"
                >
                    <v-tab
                            v-for="n in 3"
                            :key="n"
                    >
                        Item {{ n }}
                    </v-tab>
                </v-tabs>
            </v-toolbar>

            <v-tabs-items v-model="tabs">
                <v-tab-item
                        v-for="n in 3"
                        :key="n"
                >
                    <v-card>
                        <v-card-text>
                            {{ text }}
                        </v-card-text>
                    </v-card>
                </v-tab-item>
            </v-tabs-items>
        </div>
    </div>
</template>

<script>
    import axios from 'axios';
    export default {
        data: () => ({
            tabs: null,
            text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.'
        }),

        watch: {
        },
        methods: {
            // getQuestionList() {
            //     // 获取问题列表
            //     axios.get('http://127.0.0.1:5000/api/questions/get_questions', {
            //         responseType: 'json',
            //     }).then((response) => {
            //         // console.log(response.data.data);
            //         this.questionList = response.data.data;
            //     })
            // },
            // turnToTopic() {
            //     this.$router.push('/topic');
            // },
        },
        // mounted() {
        //     this.getQuestionList();
        // }
    }
</script>

<style scoped>
.head{
    width: 100%;
    height: 8em;
    position: fixed;
    top: 0;
    border: 1px solid #eee;
}
    .search{
        margin: 0 auto;
    }
</style>
