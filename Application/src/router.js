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


const view = name => () => import(`./views/${name}`);
Vue.use(Router);

export default new Router({
    routes: [
        { path: '/settings', name: 'settings', component: view('Settings') },
        {
            path: '/',
            redirect: '/home'
        },
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
            path: '/school',
            name: 'school',
            component: School,
        },
        {
            path: '/home',
            name: 'home',
            component: Home,
        },
        {
            path: '/myself',
            name: 'myself',
            component: Myself,
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
        },
        {
            path: '/message',
            name: 'message',
            component: Message,
            children: [
            ]
        },
        {
            path: '/chat',
            name: 'chat',
            component: Chat,
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
})
