import Vue from 'vue'
import Router from 'vue-router'
import Topic from '../components/topic/topic'
import Login from '../components/login/login'
import AnswerDetail from '../components/answer-detail/answer-detail'

Vue.use(Router)

export default new Router({
    routes: [
        {
            path: '/',
            redirect: '/topic'
        },
        {
            path: '/topic',
            name: 'topic',
            component: Topic,
            children:[
                {
                    path: '../answer-detail',
                    name: 'answer-detail',
                    component: AnswerDetail
                }
            ]
        },
        {
            path: '/login',
            name: 'login',
            component: Login,
        },
        {
            path: '/answer-detail',
            name: 'answer-detail',
            component: AnswerDetail
        }
    ]
})
