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
        methods: {
            DB() {
                let that=this;
                let myDB = {
                    name: "project-agent", version: 1, db: null
                };

                function openDB(name) {
                    let version = 1;
                    let request = window.indexedDB.open(name, version);
                    request.onerror = function (e) {
                        console.log(e.currentTarget.error.message);
                    };
                    request.onsuccess = function (e) {
                        myDB.db = e.target.result;
                    };
                    request.onupgradeneeded = function (e) {
                        let db = e.target.result;
                        if (!db.objectStoreNames.contains("user")) {
                            db.createObjectStore("user", {keyPath:'id',autoIncrement: true});
                        }
                        console.log('DB version changed to ' + version);
                    };
                }

                function getDataByKey(db, storeName, value) {
                    let transaction = db.transaction(storeName, 'readwrite');
                    let store = transaction.objectStore(storeName);
                    let request = store.get(value);
                    request.onsuccess = function (e) {
                        let data = e.target.result;
                        console.info(data);
                        that.GLOBAL.token=data.token;
                        that.GLOBAL.user_group=data.user_group;
                    };
                }

                openDB('user');
                setTimeout(function () {
                    getDataByKey(myDB.db,'user',1)
                }, 1000);
            }
        },
        mounted() {
            this.DB()
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
