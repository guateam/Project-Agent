import Vue from 'vue'
import Router from 'vue-router'
import Topic from '../components/topic/topic'
import Home from '../components/home/home'
import Login from '../components/login/login'
import Register from '../components/register/register'
import AnswerDetail from '../components/answer-detail/answer-detail'
import Comment from '../components/comment/comment'
import Main from '../components/main/main'

Vue.use(Router)

export default new Router({
    routes: [
        {
            path: '/',
            redirect: '/home'
        },
        // {
        //     path: 'main',
        //     name: 'main',
        //     component: Main
        // },
        {
            path: '/topic',
            name: 'topic',
            component: Topic,
            children: [
                {
                    path: '../answer-detail',
                    name: 'answer-detail',
                    component: AnswerDetail,
                },
                {
                    path: '../comment',
                    name: 'comment',
                    component: Comment
                }
            ]
        },
        {
            path: '/home',
            name: 'home',
            component: Home,
        },
        {
            path: '/login',
            name: 'login',
            component: Login
        },
        {
            path: '/register',
            name: 'register',
            component: Register
        },
        {
            path: '/answer-detail',
            name: 'answer-detail',
            component: AnswerDetail
        },
        {
            path: '/comment',
            name: 'comment',
            component: Comment
        }
    ]
})
