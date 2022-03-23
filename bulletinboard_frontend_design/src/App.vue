<template>
  <div id="app">
    
    <transition name="fade">
      <div>
        <router-view></router-view>        
      </div>
    </transition>

  </div>
</template>

<script>

export default {
  
}
</script>

<style>
    .fade-enter-active, .fade-leave-active {
      transition: opacity .5s
    }
    .fade-enter, .fade-leave-active {
      opacity: 0
    }
</style>