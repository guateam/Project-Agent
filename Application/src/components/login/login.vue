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
                    url: 'https://' + this.GLOBAL.host + '/api/account/login',
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
                    // 把token写入cookies
                    if (response.data.code === 1) {
                        this.DB({
                            id:1,
                            token: response.data.data.token,
                            user_group: response.data.data.data.group.value
                        });
                        this.GLOBAL.token = response.data.data.token;
                        this.GLOBAL.user_group = response.data.data.data.group.value;
                        this.$router.push({name: 'myself'});
                    }
                })
            },
            DB(data) {
                let myDB = {
                    name: "project-agent", version: 1, db: null
                };

                function openDB(name) {
                    let version = 1;
                    let request = window.indexedDB.open(name, version);
                    request.onerror = function (e) {
                        console.log(e.currentTarget.error.message);
                    };
                    request.onsuccess = function (e) {
                        myDB.db = e.target.result;
                    };
                    request.onupgradeneeded = function (e) {
                        let db = e.target.result;
                        if (!db.objectStoreNames.contains("user")) {
                            db.createObjectStore("user", {keyPath:'id',autoIncrement: true});
                        }
                        console.log('DB version changed to ' + version);
                    };
                }

                function addData(db, storeName, data) {
                    let transaction = db.transaction(storeName, 'readwrite');
                    let store = transaction.objectStore(storeName);
                    store.put(data)
                }

                openDB('user');
                setTimeout(function () {
                    addData(myDB.db, "user", data);
                }, 1000);
            }
        }
    }
</script>

<style scoped>
    a {
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
