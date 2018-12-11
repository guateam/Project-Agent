<template>
    <div>
        <div style="width: 100%; height: 3em; background-color: rgba(238, 238, 238, 0.7)"></div>
        <div class="title">
            <div class="off">
                <router-link to="answer-detail">
                X
                </router-link>
            </div>
            <h4>全部<span>5</span>条评论</h4>
            <span class="list">默认排序∨</span>
        </div>
        <div class="line" style="width: 100%;height: 1em;background-color: #eee"></div>
        <div class="main" style="padding-left: 1em;padding-right: 1em">
            <div class="comment-item">
                <div class="comment-user">
                    <img src="./head.png" alt="">
                    <span class="comment-user-name">李一半</span>
                    <span class="comment-user-tag">从业者</span>
                    <div class="comment-like">一个icon</div>
                </div>
                <div>
                    <p>不知道我的理解对不对。激发表面等离子激源要光源波长和材料表面自由电子相耦合。以后要突破更小...</p>
                </div>
                <div class="comment-item-foot">
                    <span>2018-12-12</span>
                    &nbsp;&nbsp;&nbsp;
                    <span>查看回复</span>
                    <span style="position: absolute;right: 1em;">又是俩icon</span>
                </div>
            </div>
            <div class="comment-item">
                <div class="comment-user">
                    <img src="./head.png" alt="">
                    <span class="comment-user-name">李一半</span>
                    <span class="comment-user-tag">从业者</span>
                    <div class="comment-like">一个icon</div>
                </div>
                <div>
                    <p>不知道我的理解对不对。激发表面等离子激源要光源波长和材料表面自由电子相耦合。以后要突破更小...</p>
                </div>
                <div class="comment-item-foot">
                    <span>2018-12-12</span>
                    &nbsp;&nbsp;&nbsp;
                    <span>查看回复</span>
                    <span style="position: absolute;right: 1em;">又是俩icon</span>
                </div>
            </div>
            <div class="comment-item">
                <div class="comment-user">
                    <img src="./head.png" alt="">
                    <span class="comment-user-name">李一半</span>
                    <span class="comment-user-tag">从业者</span>
                    <div class="comment-like">一个icon</div>
                </div>
                <div>
                    <p>不知道我的理解对不对。激发表面等离子激源要光源波长和材料表面自由电子相耦合。以后要突破更小...</p>
                </div>
                <div class="comment-item-foot">
                    <span>2018-12-12</span>
                    &nbsp;&nbsp;&nbsp;
                    <span>查看回复</span>
                    <span style="position: absolute;right: 1em;">又是俩icon</span>
                </div>
            </div>
            <div class="comment-item">
                <div class="comment-user">
                    <img src="./head.png" alt="">
                    <span class="comment-user-name">李一半</span>
                    <span class="comment-user-tag">从业者</span>
                    <div class="comment-like">一个icon</div>
                </div>
                <div>
                    <p>不知道我的理解对不对。激发表面等离子激源要光源波长和材料表面自由电子相耦合。以后要突破更小...</p>
                </div>
                <div class="comment-item-foot">
                    <span>2018-12-12</span>
                    &nbsp;&nbsp;&nbsp;
                    <span>查看回复</span>
                    <span style="position: absolute;right: 1em;">又是俩icon</span>
                </div>
            </div>
            <div class="comment-item">
                <div class="comment-user">
                    <img src="./head.png" alt="">
                    <span class="comment-user-name">李一半</span>
                    <span class="comment-user-tag">从业者</span>
                    <div class="comment-like">一个icon</div>
                </div>
                <div>
                    <p>不知道我的理解对不对。激发表面等离子激源要光源波长和材料表面自由电子相耦合。以后要突破更小...</p>
                </div>
                <div class="comment-item-foot">
                    <span>2018-12-12</span>
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
        name: "comment"
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