<template>
    <div class="bottom-nav">
        <v-bottom-nav
                :active.sync="bottomNav"
                :value="true"
                absolute
                color="white"
        >
            <v-btn
                    color="yellow lighten-1"
                    flat
                    value="home"
                    @click="$router.push('/home')"
            >
                <span>首页</span>
                <v-icon>question_answer</v-icon>
            </v-btn>

            <v-btn
                    color="yellow lighten-1"
                    flat
                    value="school"
            >
                <span>学院</span>
                <v-icon>school</v-icon>
            </v-btn>

            <v-btn
                    color="yellow lighten-1"
                    flat
                    value="message"
            >
                <span>消息</span>
                <v-icon>speaker_notes</v-icon>
            </v-btn>

            <v-btn
                    color="yellow lighten-1"
                    flat
                    value="mine"
                    @click="$router.push('/login')"
            >
                <span>我的</span>
                <v-icon>account_circle</v-icon>
            </v-btn>
        </v-bottom-nav>
    </div>
</template>

<script>
    export default {
        name: "bottom-nav",
        data() {
            return {
                bottomNav: 'message',
            }
        }
    }
</script>

<style scoped>

</style>
