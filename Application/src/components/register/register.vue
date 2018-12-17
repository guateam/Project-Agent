<template>
    <div>
        <div class="title">
            <div style="margin-left: 2em" @click="$router.push('/home')">X</div>
            <span style="margin-right: 2em">
                <router-link to="login">登录</router-link>
            </span>
        </div>
        <div class="main">
            <div class="theform">
                <v-stepper v-model="e1">

                    <!--用来显示步进条的header，这份DOM好像是不能删的？没找到可用的api，只能强行设置不显示了-->

                    <v-stepper-header style="display: none;">
                        <v-stepper-step :complete="e1 > 1" step="1">Name of step 1</v-stepper-step>
                        <v-divider></v-divider>
                        <v-stepper-step :complete="e1 > 2" step="2">Name of step 2</v-stepper-step>
                        <v-divider></v-divider>
                        <v-stepper-step step="3">Name of step 3</v-stepper-step>
                    </v-stepper-header>

                    <v-stepper-items>
                        <v-stepper-content step="1">
                            <div class="titlere"><h1>注册</h1></div>
                            <v-form v-model="valid">
                                <v-text-field v-model="email" :rules="emailRules" :counter="30" label="请输入邮件"
                                              required></v-text-field>
                            </v-form>
                            <v-btn color="#ffcc00" @click="e1 = 2" style="float: right">下一步</v-btn>
                        </v-stepper-content>

                        <v-stepper-content step="2">
                            <div class="titlere"><h1>注册</h1></div>
                            <v-form v-model="valid">
                                <v-text-field v-model="paw" :rules="pawRules" :counter="30" label="请输入密码"
                                              required></v-text-field>
                                <v-text-field v-model="paw" :rules="PawRules" :counter="30" label="请确认密码"
                                              required></v-text-field>
                            </v-form>
                            <v-btn color="#ffcc00" @click="e1 = 3" style="float: right">注册</v-btn>
                            <v-btn @click="e1 = 1" flat>上一步</v-btn>
                        </v-stepper-content>

                        <v-stepper-content step="3">
                            <div style="margin-bottom: 2em">
                                <h1>注册成功<br/>欢迎来到<span style="color: #ffcc00">&nbsp;&nbsp;&nbsp;批批乎</span></h1>
                            </div>
                            注册成功，已发送验证邮件，请验证邮箱再进行后续操作
                        </v-stepper-content>
                    </v-stepper-items>
                </v-stepper>
            </div>
        </div>
    </div>
</template>

<script>
    export default {
        name: "register",
        data() {
            return {
                email: '',  // 邮箱地址
                e1: 0  // 步进的位置
            }
        },
    }
</script>

<style scoped>
    a {
        text-decoration: none;
        outline: none;
        color: black;
    }

    .title {
        height: 4.2em;
        width: 100%;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .main {
        margin-top: 3em;
        padding: 0 3em;
    }

    .theform {
        margin-top: 2em;
    }

    .titlere {
        margin-bottom: 1em;
    }


    .v-form {
        margin-bottom: 1.5em;
    }

    .v-stepper {
        height: 30em;
        background-color: transparent;
    }

    .theme--light.v-stepper {
        background: transparent;
        box-shadow: 0 0 0;
    }
</style>
