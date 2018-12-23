<!--@我的-->

<template>
    <div class="callme">
        <div class="head">
            <span class="goback" @click="$router.push('./message')">&lt;</span>
            <h2>@我的</h2>
        </div>
        <div class="line"></div>
        <div class="box">
            <div style="display: flex;align-items: center;height: 5em">
                <div style="width: 50px;height: 50px;border-radius: 50%;overflow:hidden;position: absolute;"><img
                        style="width: 50px;height: 50px;border-radius: 50%;" src="./head.png" alt=""></div>
                <div style="display: flex;justify-content: space-between;flex-direction: column;margin-left: 60px">
                    <div>张三</div>
                    <p><span style="color: blue">@李一半</span>&nbsp;&nbsp;感谢分享呀</p>
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
            <div style="display: flex;align-items: center;height: 5em">
                <div style="width: 50px;height: 50px;border-radius: 50%;overflow:hidden;position: absolute;"><img
                        style="width: 50px;height: 50px;border-radius: 50%;" src="./head.png" alt=""></div>
                <div style="display: flex;justify-content: space-between;flex-direction: column;margin-left: 60px">
                    <div>张三</div>
                    <p><span style="color: blue">@李一半</span>&nbsp;&nbsp;感谢分享呀</p>
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
            <div style="display: flex;align-items: center;height: 5em">
                <div style="width: 50px;height: 50px;border-radius: 50%;overflow:hidden;position: absolute;"><img
                        style="width: 50px;height: 50px;border-radius: 50%;" src="./head.png" alt=""></div>
                <div style="display: flex;justify-content: space-between;flex-direction: column;margin-left: 60px">
                    <div>张三</div>
                    <p><span style="color: blue">@李一半</span>&nbsp;&nbsp;感谢分享呀</p>
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
            <div style="display: flex;align-items: center;height: 5em">
                <div style="width: 50px;height: 50px;border-radius: 50%;overflow:hidden;position: absolute;"><img
                        style="width: 50px;height: 50px;border-radius: 50%;" src="./head.png" alt=""></div>
                <div style="display: flex;justify-content: space-between;flex-direction: column;margin-left: 60px">
                    <div>张三</div>
                    <p><span style="color: blue">@李一半</span>&nbsp;&nbsp;感谢分享呀</p>
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
        name: "callme",
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

    .callme {
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
        height: 13em;
        background-color: white;
        padding-left: 1em;
        padding-right: 1em;
        border-bottom: 1px #eee solid;
    }
</style>