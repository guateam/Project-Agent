<template>
    <div>
        <div class="title">
            <div style="margin-left: 2em" @click="$router.push('/myself')">X</div>
            <span style="margin-right: 2em">
                <router-link to="register">注册</router-link></span>
        </div>
        <div class="main">
            <div>
                <h1>你好，<br/>欢迎来到<span style="color: #ffcc00">&nbsp;&nbsp;&nbsp;批批乎</span></h1>
            </div>
            <div class="the-form">
                <v-form>
                    <v-text-field
                            v-model="email"
                            :counter="30"
                            label="请输入邮件"
                            required
                    ></v-text-field>
                    <v-text-field
                            v-model="psw"
                            label="请输入密码"
                            type="password"
                            required
                    ></v-text-field>
                </v-form>
                <span style="position: absolute;right: 3em">忘记密码？</span>
                <div style="margin-top: 4em">
                    <v-btn block color="#ffcc00" @click="submit()">登录</v-btn>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    import axios from 'axios'

    export default {
        name: "login",
        data() {
            return {
                email: '',
                psw: '',
            }
        },
        methods: {
            submit() {
                axios({
                    method: 'post',
                    url: 'http://localhost:5000/api/account/login',
                    data: {
                        username: this.email,  // 用户名
                        password: this.psw,  // 密码
                    },
                    transformRequest: [function (data) {
                        // Do whatever you want to transform the data
                        let ret = '';
                        for (let it in data) {
                            ret += encodeURIComponent(it) + '=' + encodeURIComponent(data[it]) + '&'
                        }
                        return ret
                    }],
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded'
                    }
                }).then((response) => {
                    window.console.log(response);
                    // 把token写入cookies
                    import('js-cookie').then((Cookies) => {
                        Cookies.set('token', response.data.data.token);
                    });
                    this.$router.push({name: 'myself'});
                })
            }
        }
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

    .the-form {
        margin-top: 2em;
    }
</style>
