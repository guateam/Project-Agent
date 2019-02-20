<template>
<div class="bigbox">
    <v-toolbar color="white" flat>
        <v-btn icon light @click="$router.push({name: 'myself'})">
            <v-icon color="grey darken-2">arrow_back</v-icon>
        </v-btn>

        <v-toolbar-title class="grey--text text--darken-4">数据中心</v-toolbar-title>
    </v-toolbar>
    <div class="head">
        <div class="head-box" style="border-right: 1px #eee solid">文章管理</div>
        <div class="head-box" style="border-right: 1px #eee solid">粉丝管理</div>
        <div class="head-box" style="border-right: 1px #eee solid">互动管理</div>
        <div class="head-box">创作激励</div>
    </div>
    <div class="notice">如果有公告的话</div>
    <div class="maindata">
        <div class="maindata-box" style="border-right: 1px #eee solid">
            <span>粉丝</span>
            <span>5566</span> <!--总数-->
            <span style="color: crimson">121</span><!--近期上涨-->
        </div>
        <div class="maindata-box" style="border-right: 1px #eee solid">
            <span>文章订阅</span>
            <span>556</span> <!--总数-->
            <span style="color: crimson">12</span><!--近期上涨-->
        </div>
        <div class="maindata-box">
            <span>所获资金</span>
            <span>55624</span> <!--总数-->
            <span style="color: crimson">12434</span><!--近期上涨-->
        </div>
    </div>
    <div class="maindata">
        <div class="maindata-box" style="border-right: 1px #eee solid">
            <span>评论</span>
            <span>5566</span> <!--总数-->
            <span style="color: crimson">121</span><!--近期上涨-->
        </div>
        <div class="maindata-box" style="border-right: 1px #eee solid">
            <span>点赞/推荐</span>
            <span>556</span> <!--总数-->
            <span style="color: crimson">12</span><!--近期上涨-->
        </div>
        <div class="maindata-box">
            <span>想不出来</span>
            <span>55624</span> <!--总数-->
            <span style="color: crimson">12434</span><!--近期上涨-->
        </div>
    </div>
    <div>
        <h3>最新文章</h3>
        这两部分做吗？做的话直接照搬我的发布就好了，不做就删了吧
    </div>
    <div>
        <h3>最新评论</h3>
    </div>
</div>
</template>

<script>
    export default {
        name: "dataCenter",
        data(){
            return{

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
    .head{
        width: 100%;
        background-color: white;
        height: 8em;
        display: flex;
        border: 1px solid #eee;
    }
    .head-box{
        display: flex;
        align-items: center;
        justify-content: center;
        flex: 0 0 25%;
    }
    .notice{
        width: 100%;
        height: 3em;
        display: flex;
        align-items: center;
        border-top: 1px #eee solid;
        border-bottom: 1px solid #eee;
    }
    .maindata{
        width: 100%;
        background-color: white;
        height: 6em;
        display: flex;
        border: solid 1px #eee;
    }
    .maindata-box{
        display: flex;
        align-items: center;
        justify-content: center;
        flex: 0 0 33.3%;
    }
</style>
