<template>
    <div>

        <!--顶部话题描述-->

        <div style="padding-left: 1em; padding-right: 1em;padding-top: 1em">
            <h2>{{topicTitle}}</h2>
            <h2 style="line-height: 1.5;height: 1.5em">
                <router-link to="topic" class="totopic">查看话题></router-link>
            </h2>
        </div>

        <!--分隔线-->
        <div style="width: 100%;height: 12px;background-color: #EBEBEB;"></div>

        <!--回答者的用户信息关注等，这部分dom写的太复杂了所以先直接把style全写在template里面-->

        <div>
            <div style="display: flex;justify-content: space-between;margin-top: 1em;margin-bottom: 1em">
                <div style="display: flex;flex: 0 0 80%;">
                    <div style="display: flex;flex: 0 0 25%;align-items: center;justify-content: center">
                        <div style="width: 60px;height: 60px;border-radius: 50%">
                            <img src="./head.png" alt="" style="width: 100%;height: 100%;border-radius: 50%">
                        </div>
                    </div>
                    <div style="display: flex;flex-direction: column;justify-content: space-between;">
                        <h2 style="margin-top: 8px;">看风景的蜗牛君<span style="color: #ffcc00">&nbsp;&nbsp;专家</span></h2>
                        <p style="margin-bottom: 8px;">杭州<span>光学专家</span></p>
                    </div>
                </div>
                <div style="display: flex;flex: 0 0 20%;align-items: center;justify-content: center">
                    <div style="width: 70px;height: 38px;background-color: #FFCC00;color: black;font-weight: 600;display: flex;align-items: center;justify-content: center;">
                        关注
                    </div>
                </div>
            </div>
            <div style="padding-left: 1em; padding-right: 1em;display: flex;justify-content: space-between;border-bottom: 1px solid #EBEBEB">
                <p>上一次编辑 <span>· 19小时以前</span></p>
                <p>
                    <span>原创</span>
                    &nbsp;&nbsp;·&nbsp;&nbsp;
                    <span>不可转载</span>
                </p>
            </div>
        </div>

        <!--回答的答案-->

        <div class="intro" style="padding-left: 1em; padding-right: 1em;">
            <p v-html="intro"></p>
        </div>

        <!--评论这部分,是有组件的，但是这里不用，仅获取前三个类似热评一样的东西，不然样式不好写-->
        <div class="comment" style="padding-left: 1em; padding-right: 1em;">
            <h2>评论</h2>
            <router-link to="comment">
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
                </div>
            </router-link>

            <!--下面这俩div没有router-link，纯粹为了看起来舒服点加的，可以直接删-->

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
            </div>
        </div>

        <!--占位的div，用来把下面的foot所遮住的空间挤出来-->

        <div style="width: 100%;height: 50px;"></div>

        <!--固定在底部的input等-->

        <div class="foot">
            <div class="footinput">
                <input type="text" placeholder="输入您的回答">
            </div>
            <div>又是俩icon</div>
        </div>

        <!--END-->
    </div>
</template>

<script>
    import Comment from '../comment/comment'

    export default {
        name: "answer-detail",
        components: {
            Comment
        },
        data() {
            return {
                topicTitle: '刚刚研制成功的世界首台分辨力最高紫外超分辨光刻装备意味着什么？对国内芯片行业有何影响？',  // 话题标题
                intro: '先回答大家最关心的两个问题：\n' +
                    '1、我们可以实现芯片彻底国产化了吗？\n' +
                    '答：暂时还不行。\n' +
                    '2、不吹不黑，这个装备真的这么厉害吗，还是只是吹牛？\n' +
                    '答：确实很厉害。\n' +
                    '很多人只盯着新闻里22nm这个指标，其实大家要关注的是“365nm的光源，单次曝光线宽可达22nm”。注意到我加黑的那几个关键词了吗？22nm指标虽然很棒但是业界早就做过了，到底哪里厉害呢？所以关键是用365nm的光源单次曝光做到22nm，懂点光学的就知道这意味着什么：打破了传统的衍射极限。\n' +
                    '所以在我看来，这台机器最大的价值是验证了表面等离子体（SP）光刻加工的可行性。\n' +
                    '这台SP光刻机与ASML光刻机对比怎么样呢？举个不恰当的例子吧，这就像是初期的枪械与最厉害的弓箭的对比。早期枪械，比如火铳，无论是射击精度还是射击距离都远远比不上厉害的弓箭，但是如今的狙击枪早已把弓箭甩开十万八千里了，这就是原理性的胜利。\n' +
                    '要理解刚才说的这个“原理性的胜利”到底是怎么回事，我们首先得回顾一下以ASML为代表的传统光刻机是怎么做的。\n' +
                    '上面是ASML光刻机简单的原理图，抛开复杂的监测设备不谈，最核心的原理就是通过物镜系统将掩膜版上的图案进行缩印成像。涉及到成像过程，就不得不考虑光的衍射极限。即便抛开所有的几何像差，由于衍射的作用，一个无限小的点成像后也会变成一个弥散斑，被称为“艾里斑”。因此实际光学系统成像的分辨率就是两个艾里斑恰好能够分开的距离。\n' +
                    '所以由于衍射效应，成像分辨率会受到限制，最终的分辨率取决于波长、数值孔径等参数，波长越小、数值孔径越大分辨率则越高。所以ASML这些年来主要的研究方向就是利用更短的波长（近紫外-深紫外-极紫外）、增大数值孔径（更复杂的物镜、液体浸没）。但是每进一步都变得更加艰难，对系统设计、加工装配、误差检测等等诸多方面都提出了更为苛刻的要求，成本也越来越高昂。\n' +
                    '那么表面等离子体光刻又是怎么一回事呢？表面等离子体指的是一种局域在物质表面的特殊的电磁波，随着离开物质表面距离的增大迅速衰减，一般认为波长量级以上的区域就不存在了。\n' +
                    '更为神奇的是，虽然表面等离子体波是由其他电磁波激发的，但是波长会被极大地压缩，而压缩的比例取决于材料的电磁性质等参数。\n' +
                    '这就意味着，利用表面等离子体波进行光刻时，从原理上就不在受到传统衍射极限的限制了。\n' +
                    '在光刻机研制方面，我们一直有两个选择：沿用ASML的老路走一遍，还是另辟蹊径通过新原理弯道超车？我们国家很有钱，两个选择都在做。而这台SP光刻机的研制成功，就是让我们看到了弯道超车的可能性。其实从原理上，这简直就不是弯道超车了，而是在别的人还在绕山路的时候，我们尝试着打了一条隧道……虽然还没有完全挖通，但曙光就在眼前了。\n' +
                    '这个装备是我在的课题组主导研发的（但我没做这个方向），从原理提出、项目立项到装备最终验收通过，前前后后有十几年的时间。十几年磨一剑，挥洒了许许多多的老师和师兄师姐的智慧、汗水与青春。向他们致敬~',  // 回答内容
            }
        }
    }
</script>

<style scoped>

    * {
        line-height: 1.5;
    }

    a {
        text-decoration: none;
        outline: none;
    }

    .totopic {
        color: #ffcc00;
        float: right;
        line-height: 1.5;
    }

    .intro {
        margin-top: 1em;
        line-height: 1.5;
        /*margin-bottom: 50px;*/
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

    .foot {
        width: 100%;
        height: 50px;
        display: flex;
        align-items: center;
        position: fixed;
        bottom: 0;
        background-color: white;
        z-index: 100;
        line-height: 1.5;
        padding-left: 1em;
    }

    .footinput {
        display: flex;
        flex: 0 0 70%;
        height: 80%;
        border: 1px solid #EBEBEB;
        border-radius: 10px;
    }

    .foot input {
        padding-left: 1em;
        width: 100%;
        height: 100%;
        outline: #EBEBEB;
    }
</style>