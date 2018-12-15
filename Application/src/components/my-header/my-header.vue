<template>
    <div>
        <v-bottom-nav
                :active.sync="bottomNav"
                :value="true"
                absolute
                color="transparent"
        >
            <v-btn
                    color="teal"
                    flat
                    value="home"
                    @click="$router.push('/home')"
            >
                <span>首页</span>
                <v-icon>web</v-icon>
            </v-btn>

            <v-btn
                    color="teal"
                    flat
                    value="message"
            >
                <span>消息</span>
                <v-icon>question_answer</v-icon>
            </v-btn>

            <v-btn
                    color="teal"
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
        name: "my-header"
    }
</script>

<style scoped>

</style>