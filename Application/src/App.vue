<template>
  <div id="app">
    <!--<Myheader></Myheader>-->
    <router-view></router-view>
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
