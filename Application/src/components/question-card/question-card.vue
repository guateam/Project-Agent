<template>
    <div class="question-card">
        <v-card>
            <v-container>
                <v-layout row justify-space-between>
                    <v-flex xs7>
                        <h3>{{ title }}</h3>
                    </v-flex>
                    <v-flex xs4>
                        <img :src="img" width="100%">
                    </v-flex>
                </v-layout>
                <v-layout row>
                    <v-flex xs12>标签 · <span v-for="(tag, index) in tags" :key="index">{{ index===0 ? '' : '/' }}{{ tag }}</span></v-flex>
                </v-layout>
                <v-layout row justify-space-between>
                    <v-flex xs8>{{ follow }} 人关注&nbsp;·&nbsp;{{ comment }} 条评论</v-flex>
                    <v-flex xs3>{{ edittime }}</v-flex>
                </v-layout>
            </v-container>
        </v-card>
    </div>
</template>

<script>
    export default {
        name: "question-card",
        props: ['title', 'img', 'tags', 'follow', 'comment', 'edittime'],
    }
</script>

<style scoped>
    .v-card {
        margin-top: 10px;
        margin-bottom: 10px;
    }
</style>
