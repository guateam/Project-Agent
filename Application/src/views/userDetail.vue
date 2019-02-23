<template>
<div class="bigbox">
    <v-toolbar color="white" flat>
        <v-btn icon light @click="$router.push({name: 'myself'})">
            <v-icon color="grey darken-2">arrow_back</v-icon>
        </v-btn>

        <v-toolbar-title class="grey--text text--darken-4">账号资料</v-toolbar-title>
    </v-toolbar>

    <v-divider></v-divider>
    <div class="main">
        <div class="box" style="height: 6em">
            <div>头像</div>
            <div style="width: 5em;height: 5em;overflow: hidden;border-radius: 50%;">
                <img src="https://www.asgardusk.com/images/none.png" alt="img" style="width: 100%;height: 100%;border-radius: 50%">
            </div>
        </div>
        <v-divider></v-divider>
        <div class="box">
            <div>用户名</div>
            <div>拉拉人</div>
        </div>
        <v-divider></v-divider>
        <div class="box">
            <div>一句话描述</div>
            <div>这个人很懒什么也没留下</div>
        </div>
        <v-divider></v-divider>
        <div class="box">
            <div>密码修改</div>
        </div>
        <v-divider></v-divider>
        <div class="box">
            <div>行业</div>
            <div>互联网</div>
        </div>
        <v-divider></v-divider>
        <div class="box">
            <div>居住地</div>
            <div>浙江杭州</div>
        </div>
        <v-divider></v-divider>
    </div>
</div>
</template>

<script>
    export default {
        name: "userDetail"
    }
</script>

<style scoped>
    .bigbox{
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
    .main{
        width: 100%;
        background-color: white;
    }
    .box{
        display: flex;
        align-items: center;
        justify-content: space-between;
        height: 3em;
        padding-left: 1em;
        padding-right: 1em;
    }
</style>
