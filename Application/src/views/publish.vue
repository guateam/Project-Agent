<template>
    <div class="bigbox">
        <v-toolbar color="white" flat>
            <v-btn icon light @click="$router.push({name: 'myself'})">
                <v-icon color="grey darken-2">arrow_back</v-icon>
            </v-btn>

            <v-toolbar-title class="grey--text text--darken-4">发布文章</v-toolbar-title>
        </v-toolbar>

        <v-divider></v-divider>

        <v-card
                class="mx-auto"
                style="max-width: 500px;"
        >
            <v-form
                    ref="form"
                    v-model="form"
                    class="pa-3 pt-4"
            >
                <v-text-field
                        v-model="title"
                        box
                        color="deep-purple"
                        counter="30"
                        label="文章标题"
                        style="min-height: 96px"
                ></v-text-field>
                <v-text-field
                        v-model="description"
                        box
                        color="deep-purple"
                        label="内容简介"
                ></v-text-field>
                <v-textarea
                        v-model="content"
                        auto-grow
                        box
                        color="deep-purple"
                        label="正文内容"
                        rows="1"
                ></v-textarea>
            </v-form>
            <v-divider></v-divider>
            <v-card-actions>
                <v-btn
                        flat
                        @click="$refs.form.reset()"
                >
                    清空
                </v-btn>
                <v-spacer></v-spacer>
                <v-btn
                        :disabled="!form"
                        :loading="isLoading"
                        class="white--text"
                        color="deep-purple accent-4"
                        depressed
                        @click="send()"
                >确认
                </v-btn>
            </v-card-actions>
        </v-card>
    </div>
</template>

<script>
    import axios from 'axios';

    export default {
        name: "publish",
        data: () => ({
            agreement: false,
            content: '',
            dialog: false,
            form: false,
            isLoading: false,
            title: undefined,
            description: undefined,
            rules: {
                // email: v => (v || '').match(/@/) || 'Please enter a valid email',
                // length: len => v => (v || '').length >= len || `Invalid character length, required ${len}`,
                // password: v => (v || '').match(/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*(_|[^\w])).+$/) ||
                //     'Password must contain an upper case letter, a numeric character, and a special character',
                // required: v => !!v || 'This field is required'
            }
        }),
        methods: {
            send() {
                axios({
                    method: 'post',
                    url: 'https://' + this.GLOBAL.host + '/api/article/add_article',
                    data: {
                        token: this.GLOBAL.token,
                        title: this.title,
                        content: this.content
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
                        console.info('success');
                        this.$router.push({name: 'myself'});
                    }
                })
            }
        }
    }
</script>

<style scoped>
    .bigbox {
        position: absolute;
        width: 100%;
        height: 100%;
        z-index: 200;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background-color: white;
    }
</style>
