import Vue from 'vue'
import Router from 'vue-router'
import Topic from './components/topic/topic'
import Home from './components/home/home'
import Login from './components/login/login'
import Register from './components/register/register'
import AnswerDetail from './components/answer-detail/answer-detail'
import Comment from './components/comment/comment'
import Message from './components/message/message'
import School from './components/school/school'
import Chat from './components/chat/chat'
import ChatSetting from './components/chatSetting/chatSetting'
import Myself from './components/myself/myself'
import Approval from './components/approval/approval'
import Notice from './components/notice/notice'
import Reply from './components/reply/reply'
import Callme from './components/callme/callme'
import SchoolDetail from './views/schoolDetail'
import dataCenter from './views/dataCenter'
import publish from './views/publish'
import userDetail from './views/userDetail'
import fanList from './views/fanList'


const view = name => () => import(`./views/${name}`);
Vue.use(Router);

export default new Router({
    routes: [
        {
            path: '/',
            redirect: '/home',
        },
        {
            path: '/home',
            name: 'home',
            component: Home,
            children: [
                {
                    path: '/answer-detail/:id',
                    name: 'answer-detail',
                    component: AnswerDetail,
                },
                {
                    path: '/topic/:id',
                    name: 'topic',
                    component: Topic,
                },
                {
                    path: '/comment/:id',
                    name: 'comment',
                    component: Comment
                },
            ]
        },
        {
            path: '/school',
            name: 'school',
            component: School,
            children: [
                {
                    path: '/schooldetail',
                    name: 'schooldetail',
                    component: SchoolDetail,
                },
            ]
        },
        {
            path: '/message',
            name: 'message',
            component: Message,
            children: [
                {
                    path: '/chat',
                    name: 'chat',
                    component: Chat
                },
                {
                    path: '/chatSetting',
                    name: 'chatSetting',
                    component: ChatSetting,
                },
                {
                    path: '/approval',
                    name: 'approval',
                    component: Approval,
                },
                {
                    path: '/notice',
                    name: 'notice',
                    component: Notice,
                },
                {
                    path: '/reply',
                    name: 'reply',
                    component: Reply,
                },
                {
                    path: '/callme',
                    name: 'callme',
                    component: Callme,
                },
            ]
        },
        {
            path: '/myself',
            name: 'myself',
            component: Myself,
            children:[
                {
                    path: '/userDetail',
                    name: 'userDetail',
                    component: view('userDetail')
                },
                {
                    path: '/fanList',
                    name: 'fanList',
                    component: view('fanList')
                },
                {
                    path: '/settings',
                    name: 'settings',
                    component: view('Settings')
                },
                {
                    path: '/publish',
                    name: 'publish',
                    component: view('publish')
                },
                {
                    path: '/collection',
                    name: 'collection',
                    component: view('collection')
                },
                {
                    path: '/dataCenter',
                    name: 'dataCenter',
                    component: view('dataCenter')
                },
                {
                    path: '/oldpost',
                    name: 'oldpost',
                    component: view('oldpost')
                },
                {
                    path: '/wallet',
                    name: 'wallet',
                    component: view('wallet')
                },
            ]
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
    ],
    scrollBehavior (to, from, savedPosition) {
        return { x: 0, y: 0 }
    }
})
