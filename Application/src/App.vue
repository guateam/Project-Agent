<template>
  <div id="app">
    <Myheader></Myheader>
    <router-view></router-view>
    <v-bottom-nav
            :active.sync="bottomNav"
            :value="true"
            absolute
            color="transparent"
    >
      <v-btn
              color="teal"
              flat
              value="home"
              @click="$router.push('/home')"
      >
        <span>首页</span>
        <v-icon>web</v-icon>
      </v-btn>

      <v-btn
              color="teal"
              flat
              value="message"
      >
        <span>消息</span>
        <v-icon>question_answer</v-icon>
      </v-btn>

      <v-btn
              color="teal"
              flat
              value="mine"
              @click="$router.push('/login')"
      >
        <span>我的</span>
        <v-icon>account_circle</v-icon>
      </v-btn>
    </v-bottom-nav>
  </div>
</template>

<script>
    // @ is an alias to /src
    import Myheader from './components/my-header/my-header'

    export default {
        components: {
            Myheader
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
