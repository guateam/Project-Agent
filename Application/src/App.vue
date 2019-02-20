<template>
    <div id="app">

        <!--<my-header></my-header>-->

        <!--<router-view></router-view>-->

        <v-app>
            <!--<v-navigation-drawer app></v-navigation-drawer>-->
            <!--<v-toolbar app></v-toolbar>-->

            <v-content>
                <!--<v-container fill-width>-->
                <router-view></router-view>
                <!--</v-container>-->
            </v-content>

            <!--<div :style="{ marginBottom: '2em' }"></div>-->

            <v-footer app>
                <bottom-nav></bottom-nav>
            </v-footer>
        </v-app>
    </div>
</template>

<script>
    // @ is an alias to /src
    // import MyHeader from './components/my-header/my-header'
    import BottomNav from './components/bottom-nav/bottom-nav'

    export default {
        components: {
            // MyHeader,
            BottomNav,
        },
        created() {
            import('js-cookie').then(Cookies=>{
                this.GLOBAL.token=Cookies.get('token');
                this.GLOBAL.user_group=Cookies.get('user_group')
            })
        }
    }
</script>

<style>
    #app {
        font-family: 'Avenir', Helvetica, Arial, sans-serif;
        -webkit-font-smoothing: antialiased;
        -moz-osx-font-smoothing: grayscale;
        margin: 0;
        padding: 0;
        overflow: hidden;
        width: 100%;
    }
</style>
