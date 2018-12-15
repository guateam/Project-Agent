<template>
  <div id="app">
    <Myheader></Myheader>
    <!--<router-view></router-view>-->

    <v-app>
      <!--<v-navigation-drawer app></v-navigation-drawer>-->
      <!--<v-toolbar app></v-toolbar>-->

      <v-content>
        <!--<v-container fill-width>-->
          <router-view></router-view>
        <!--</v-container>-->
      </v-content>

      <v-footer app>
        <BottomNav></BottomNav>
      </v-footer>
    </v-app>
  </div>
</template>

<script>
    // @ is an alias to /src
    import Myheader from './components/my-header/my-header'
    import BottomNav from './components/bottom-nav/bottom-nav'

    export default {
        components: {
            Myheader,
            BottomNav,
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
