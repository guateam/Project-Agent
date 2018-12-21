
<!--评论和回复-->

<template>
    <div class="reply">
        <div class="head">
            <span class="goback" @click="$router.push('./message')">&lt;</span>
            <h2>评论和回复</h2>
        </div>
        <div class="line"></div>
        
        <!--文字回复-->
        
        <div class="box">
            <div style="display: flex;padding-top: 1em;padding-bottom: 1em">
                <div style="width: 50px;height: 50px;border-radius: 50%;overflow:hidden;position: absolute;"><img
                        style="width: 50px;height: 50px;border-radius: 50%;" src="./head.png" alt=""></div>
                <div style="display: flex;justify-content: space-between;flex-direction: column;margin-left: 60px">
                    <div>张三</div>
                    <p>回复的内容回复的内容回复的内容回复的内容回复的内容回复的内容回复的内容回复的内容回复的内容回复的内容回复的内容回复的内容回复的</p>
                </div>
            </div>
            <div>
                <p style="background-color: #eee">
                    <span>李一半</span>:
                    <span>要是不用工作就好了</span>
                    &nbsp;&nbsp;&nbsp;
                    {{text}}
                </p>
            </div>
        </div>
        
        <!--图片回复-->
        
        <div class="box">
            <div style="display: flex;padding-top: 1em;padding-bottom: 1em">
                <div style="width: 50px;height: 50px;border-radius: 50%;overflow:hidden;position: absolute;"><img
                        style="width: 50px;height: 50px;border-radius: 50%;" src="./head.png" alt=""></div>
                <div style="display: flex;justify-content: space-between;flex-direction: column;margin-left: 60px">
                    <div>张三</div>
                    <p></p>
                    <img style="width: 100px;height: 100px;object-fit: cover;" src="./head.png" alt="">
                </div>
            </div>
            <div>
                <p style="background-color: #eee">
                    <span>李一半</span>:
                    <span>要是不用工作就好了</span>
                    &nbsp;&nbsp;&nbsp;
                    {{text}}
                </p>
            </div>
        </div>

        <!--以下为复制-->
        <div class="box">
            <div style="display: flex;padding-top: 1em;padding-bottom: 1em">
                <div style="width: 50px;height: 50px;border-radius: 50%;overflow:hidden;position: absolute;"><img
                        style="width: 50px;height: 50px;border-radius: 50%;" src="./head.png" alt=""></div>
                <div style="display: flex;justify-content: space-between;flex-direction: column;margin-left: 60px">
                    <div>张三</div>
                    <p>回复的内容回复的内容回复的内容回复的内容回复的内容回复的内容回复的内容回复的内容回复的内容回复的内容回复的内容回复的内容回复的</p>
                </div>
            </div>
            <div>
                <p style="background-color: #eee">
                    <span>李一半</span>:
                    <span>要是不用工作就好了</span>
                    &nbsp;&nbsp;&nbsp;
                    {{text}}
                </p>
            </div>
        </div>
        <div class="box">
            <div style="display: flex;padding-top: 1em;padding-bottom: 1em">
                <div style="width: 50px;height: 50px;border-radius: 50%;overflow:hidden;position: absolute;"><img
                        style="width: 50px;height: 50px;border-radius: 50%;" src="./head.png" alt=""></div>
                <div style="display: flex;justify-content: space-between;flex-direction: column;margin-left: 60px">
                    <div>张三</div>
                    <p></p>
                    <img style="width: 100px;height: 100px;object-fit: cover;" src="./head.png" alt="">
                </div>
            </div>
            <div>
                <p style="background-color: #eee">
                    <span>李一半</span>:
                    <span>要是不用工作就好了</span>
                    &nbsp;&nbsp;&nbsp;
                    {{text}}
                </p>
            </div>
        </div>

        
    </div>
</template>

<script>
    export default {
        name: "reply",
        data() {
            return {
                text: '这里是内容简略显示，大概显示三行的样子这里是内容简略显示，大概显示三行的样子这里是内容简略显示，大概显示三行的样子这里是内容简略显示，大概显示三行的样子'
            }
        }
    }
</script>

<style scoped>
    p {
        margin-bottom: 0;
    }

    .reply {
        margin: 0;
        padding: 0;
        width: 100%;
        height: 100%;
    }

    .head {
        width: 100%;
        height: 3em;
        display: flex;
        align-items: center;
        justify-content: center;
        position: fixed;
        margin-bottom: 1em;
        z-index: 100;
        background-color: white;
    }

    .goback {
        position: absolute;
        left: 0.5em;
        font-size: 2em;
        font-weight: 600;
    }

    .line {
        width: 100%;
        height: 4em;
        background-color: #eee;
    }

    .box {
        width: 100%;
        padding-bottom: 1em;
        background-color: white;
        padding-left: 1em;
        padding-right: 1em;
        border-bottom: 1px #eee solid;
    }
</style>