<template>
    <div>
        <div style="width: 100%; height: 3em; background-color: rgba(238, 238, 238, 0.7)"></div>
        <div class="title">
            <div class="off">
                <button @click="$router.go(-1)">
                X
                </button>
            </div>
            <h4>全部<span>5</span>条评论</h4>
            <span class="list">默认排序∨</span>
        </div>
        <div class="line" style="width: 100%;height: 1em;background-color: #eee"></div>
        <div class="main" style="padding-left: 1em;padding-right: 1em">
            <div v-for="(comment, index) in comments" :key="index" class="comment-item">
                <div class="comment-user">
                    <img :src="comment.user_headportrait" alt="">
                    <span class="comment-user-name">{{ comment.user_nickname }}</span>
                    <!--<span class="comment-user-tag">从业者</span>-->
                    <div class="comment-like">赞同 {{ comment.agree }}</div>
                </div>
                <div>
                    <p>{{ comment.content }}</p>
                </div>
                <div class="comment-item-foot">
                    <span>{{ comment.create_time }}</span>
                    &nbsp;&nbsp;&nbsp;
                    <span>查看回复</span>
                    <span style="position: absolute;right: 1em;">又是俩icon</span>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    export default {
        name: "comment",

        data() {
            return {
                comments: [
                    {
                        agree: 0,
                        content: "这是评论这是评论这是评论这是评论这是评论这是评论这是评论这是评论这是评论这是评论这是评论这是评论这是评论这是评论这是评论这是评论这是评论这是评论这是评论这是评论",
                        create_time: "Sat, 15 Dec 2018 19:08:09 GMT",
                        user_headportrait: "",
                        user_id: 1,
                        user_nickname: "拉拉人"
                    }
                ],
            }
        },

        methods: {
            // Request comments
            getComments() {
                import('axios').then(axios => {
                    axios.get('https://'+this.GLOBAL.host+'/api/get_answer_comment_list', {
                        responseType: 'json',
                        params: {
                            answer_id: this.$route.params.id
                        }
                    }).then(res => {
                        if (res.data.code === 1) {
                            this.comments = res.data.data;
                        }
                    })
                })
            },
        },

        mounted() {
            this.getComments();
        },
    }
</script>

<style scoped>
    a{
        text-decoration: none;
        outline: none;
        color: black;
    }
    .title{
        width: 100%;
        height: 3em;
        display: flex;
        align-items: center;
        justify-content: center;
    }
    .off{
        font-size: 1em;
        font-weight: 600;
        position: absolute;
        left: 1em;
    }
    .list{
        font-size: 0.8em;
        position: absolute;
        right: 1em;
    }
    .comment-item {
        width: 100%;
        border-bottom: 1px #eee solid;
        color: black;
    }

    .comment-user {
        display: flex;
        align-items: center;
    }

    .comment-user img {
        width: 40px;
        height: 40px;
        border-radius: 50%;
        margin: 1em 1em 1em 0;
    }

    .comment-user-name {
        font-size: 1.2em;
    }

    .comment-user-tag {
        color: #ffcc00;
        font-size: 1.0em;
        margin-left: 0.5em;
    }

    .comment-like {
        position: absolute;
        right: 2em;
    }

    .comment-item-foot{
        display: flex;
        align-items: center;
        line-height: 1.5;
    }
</style>
