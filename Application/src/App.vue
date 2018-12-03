<template>
    <div id="app">
        <v-app>
            <v-navigation-drawer app></v-navigation-drawer>
            <v-toolbar app></v-toolbar>
            <v-content>
                <v-container fluid>
                    <login></login>
                </v-container>
            </v-content>
            <v-footer app></v-footer>
        </v-app>
    </div>
</template>

<script>
    import HelloWorld from './components/HelloWorld.vue'
    import Login from "./components/Login";

    export default {
        name: 'app',
        components: {
            Login,
            HelloWorld
        }
    }
</script>

<style>
    #app {
        font-family: 'Avenir', Helvetica, Arial, sans-serif;
        -webkit-font-smoothing: antialiased;
        -moz-osx-font-smoothing: grayscale;
        text-align: center;
        color: #2c3e50;
        margin-top: 60px;
    }
</style>
