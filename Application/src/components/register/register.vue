<template>
    <div>
        <div class="title">
            <div style="margin-left: 2em">X</div>
            <span style="margin-right: 2em">
                <router-link to="login">登录</router-link></span>
        </div>
        <div class="main">
            <div>
                <h1>你好，<br/>欢迎来到<span style="color: #ffcc00">&nbsp;&nbsp;&nbsp;批批乎</span></h1>
            </div>
            <div class="theform">
                <v-form v-model="valid">
                    <v-text-field
                            v-model="email"
                            :rules="emailRules"
                            :counter="10"
                            label="请输入邮件"
                            required
                    ></v-text-field>
                </v-form>
                <div style="margin-top: 4em">
                    <v-btn block color="#ffcc00">下一步</v-btn>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    export default {
        name: "register"
    }
</script>

<style scoped>
    a{
        text-decoration: none;
        outline: none;
        color: black;
    }
    .title {
        height: 3em;
        width: 100%;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .main {
        margin-top: 6em;
        padding: 0 3em;
    }

    .theform {
        margin-top: 2em;
    }
</style>