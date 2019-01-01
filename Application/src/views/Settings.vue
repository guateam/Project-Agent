<template>
    <div class="settings">
        <v-layout row>
            <v-flex xs12 sm6 offset-sm3>
                <v-card>
                    <v-toolbar color="white" flat>
                        <v-btn icon light @click="$router.push({name: 'myself'})">
                            <v-icon color="grey darken-2">arrow_back</v-icon>
                        </v-btn>

                        <v-toolbar-title class="grey--text text--darken-4">设置</v-toolbar-title>
                    </v-toolbar>

                    <v-divider></v-divider>

                    <v-list two-line>

                        <v-subheader>通用</v-subheader>
                        <v-list-tile>
                            <v-list-tile-action>
                                <v-checkbox v-model="checkboxOptions.bindContacts"></v-checkbox>
                            </v-list-tile-action>

                            <v-list-tile-content @click.prevent="checkboxOptions.bindContacts = !checkboxOptions.bindContacts">
                                <v-list-tile-title>查看通讯录好友</v-list-tile-title>
                                <v-list-tile-sub-title>开启后，他人也可以从通讯录中发现我的账号</v-list-tile-sub-title>
                            </v-list-tile-content>
                        </v-list-tile>

                        <v-list-tile>
                            <v-list-tile-action>
                                <v-checkbox v-model="checkboxOptions.internalSound"></v-checkbox>
                            </v-list-tile-action>

                            <v-list-tile-content @click.prevent="checkboxOptions.internalSound = !checkboxOptions.internalSound">
                                <v-list-tile-title>内置音效</v-list-tile-title>
                                <v-list-tile-sub-title>应用内按钮点击音效</v-list-tile-sub-title>
                            </v-list-tile-content>
                        </v-list-tile>

                        <v-list-tile>
                            <v-list-tile-action>
                                <v-checkbox v-model="checkboxOptions.noImageModel"></v-checkbox>
                            </v-list-tile-action>

                            <v-list-tile-content @click.prevent="checkboxOptions.noImageModel = !checkboxOptions.noImageModel">
                                <v-list-tile-title>无图模式</v-list-tile-title>
                                <v-list-tile-sub-title>使用非Wi-Fi网络时不下载图片</v-list-tile-sub-title>
                            </v-list-tile-content>
                        </v-list-tile>

                        <v-dialog v-model="dialog" fullscreen hide-overlay transition="dialog-bottom-transition">

                            <v-list-tile slot="activator">
                                <v-list-tile-content>
                                    <v-list-tile-title>视频自动播放</v-list-tile-title>
                                    <v-list-tile-sub-title>仅Wi-Fi</v-list-tile-sub-title>
                                </v-list-tile-content>
                            </v-list-tile>

                            <v-card>
                                <v-toolbar color="white" flat>
                                    <v-btn icon light @click="dialog = false">
                                        <v-icon>close</v-icon>
                                    </v-btn>

                                    <v-toolbar-title class="grey--text text--darken-4">视频自动播放</v-toolbar-title>
                                </v-toolbar>

                                <v-divider></v-divider>

                                <template v-for="(task, i) in networkOptions">
                                    <v-divider
                                            v-if="i !== 0"
                                            :key="`${i}-divider`"
                                    ></v-divider>

                                    <v-list-tile :key="`${i}-${task.text}`">
                                        <v-list-tile-action>
                                            <v-checkbox
                                                    v-model="task.done"
                                                    color="info darken-3"
                                            >
                                                <div
                                                        slot="label"
                                                        :class="task.done && 'grey--text' || 'text--primary'"
                                                        class="ml-3"
                                                        v-text="task.text"
                                                ></div>
                                            </v-checkbox>
                                        </v-list-tile-action>

                                        <v-spacer></v-spacer>

                                        <v-scroll-x-transition>
                                            <v-icon
                                                    v-if="task.done"
                                                    color="success"
                                            >
                                                check
                                            </v-icon>
                                        </v-scroll-x-transition>
                                    </v-list-tile>
                                </template>

                            </v-card>

                        </v-dialog>


                        <v-list-tile>
                            <v-list-tile-content>
                                <v-list-tile-title>字体大小</v-list-tile-title>
                                <v-list-tile-sub-title>除回答与专栏正文页面以外的字体调节</v-list-tile-sub-title>
                            </v-list-tile-content>
                        </v-list-tile>

                    </v-list>

                    <v-divider></v-divider>

                    <v-list two-line>

                        <v-subheader>通知</v-subheader>

                        <v-list-tile>
                            <v-list-tile-title>消息设置</v-list-tile-title>
                        </v-list-tile>

                        <v-list-tile>
                            <v-list-tile-title>推送通知设置</v-list-tile-title>
                        </v-list-tile>

                        <v-list-tile>
                            <v-list-tile-title>屏蔽设置</v-list-tile-title>
                        </v-list-tile>

                    </v-list>

                    <v-divider></v-divider>

                    <v-list two-line>

                        <v-subheader>安全</v-subheader>

                        <v-list-tile>
                            <v-list-tile-title>账号与安全</v-list-tile-title>
                        </v-list-tile>

                    </v-list>

                    <v-divider></v-divider>

                    <v-list two-line>

                        <v-subheader>其他</v-subheader>

                        <v-list-tile>
                            <v-list-tile-content>
                                <v-list-tile-title>清除缓存</v-list-tile-title>
                                <v-list-tile-sub-title>155.24MB</v-list-tile-sub-title>
                            </v-list-tile-content>
                        </v-list-tile>

                        <v-list-tile>
                            <v-list-tile-title>问题反馈</v-list-tile-title>
                        </v-list-tile>

                    </v-list>

                    <v-divider></v-divider>

                    <v-list>
                        <v-list-tile>
                            <v-flex>
                                <v-btn @click="logout" color="error" block>退出我的账号</v-btn>
                            </v-flex>
                        </v-list-tile>
                    </v-list>

                    <v-divider></v-divider>

                    <v-list>
                        <v-flex text-xs-center>
                            Gua Team Web Version 0.0.1 (1000)
                        </v-flex>
                    </v-list>

                </v-card>
            </v-flex>
        </v-layout>
    </div>
</template>

<script>
    export default {
        name: "settings",
        data() {
            return {
                checkboxOptions: {
                    bindContacts: false,  // 绑定通讯录
                    internalSound: false,  // 内置音效
                    noImageModel: true,  // 无图模式
                },  // Checkbox选项
                dialog: false,
                networkOptions: [
                    {
                        done: false,
                        text: 'Foobar'
                    },
                    {
                        done: false,
                        text: '123'
                    }
                ],
            }
        },
        methods: {
            logout() {
                // 注销用户
                import('js-cookie').then((Cookies) => {
                    Cookies.remove('token');
                });
                this.$router.push({name: 'myself'});
            },
        }
    }
</script>

<style scoped>

</style>