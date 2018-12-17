





<!-----------------这个组件基本被废弃了，勿修改，底部导航组件见bottom-nav------Wh/12/17--------------->






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
                    value="topic"
                    @click="$router.push('/topic')"
            >
                <span>首页</span>
                <v-icon>web</v-icon>
            </v-btn>

            <v-btn
                    color="teal"
                    flat
                    value="message"
                    @click="$router.push('/message')"
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