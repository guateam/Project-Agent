
<!--系统通知-->

<template>
    <div>系统通知</div>
</template>

<script>
    export default {
        name: "notice",
        methods: {},
        mounted() {
            import('js-cookie').then((Cookies) => {
                import('axios').then((axios) => {
                    axios.get('https://'+this.GLOBAL.host+'/api/message/get_message_list', {
                        responseType: 'json',
                        params: {
                            token: this.GLOBAL.token,
                        }
                    }).then((response) => {
                        window.console.log(response);
                    })
                })
            })
        }
    }
</script>

<style scoped>

</style>
