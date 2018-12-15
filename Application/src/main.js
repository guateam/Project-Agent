import Vue from 'vue'
import App from './App.vue'
import router from './router/router'
import store from './store'
import Vuetify from 'vuetify'
import 'vuetify/dist/vuetify.min.css'

Vue.use(Vuetify)

new Vue({
    el: '#app',
    router,
    store,
    render: h => h(App)
})
