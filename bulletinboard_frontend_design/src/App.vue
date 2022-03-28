<template>
  <div id="app">

    <nav v-if="!$route.meta.hideNavbar" class="navbar navbar-expand-lg p-20" style="background-color: #0a4275;">
      <div class="container-fluid">
        <a class="navbar-brand txt-style" href="#">SCM BulletinBoard</a>
        <div class="collapse navbar-collapse container-fluid mb-0" id="navbarText">
          <ul class="navbar-nav me-auto mb-2 mb-lg-0">
            <li class="nav-item">
              <router-link :to="{ name: 'UserListsAdmin' }" class="nav-link">Users</router-link>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#">Posts</a>
            </li>
          </ul>

          <ul class="navbar-nav">
            <li class="nav-item dropdown">
              <a
                class="dropdown-toggle text-white mb-0 text-uppercase"
                href="#"
                id="navbarDropdownMenuLink"
                role="button"
                data-bs-toggle="dropdown"
                aria-expanded="false"
              >
                {{ this.username }}
              </a>
              <ul class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
                <li>
                  <a class="dropdown-item" href="#">Profile</a>
                </li>
                <li>
                  <router-link :to="{ name: 'SignIn' }"><span class="dropdown-item" @click="logout">Log Out</span></router-link>
                </li>
              </ul>
            </li>
          </ul>
        </div>
      </div>
    </nav>
    
    <transition name="fade">
      <div class="pb-40">
        <router-view></router-view>        
      </div>
    </transition>

    <footer v-if="!$route.meta.hideNavbar" class="p-15" style="background-color: #0a4275;">
      <!-- Copyright -->
      <div class="d-flex justify-content-between" >
        <a class="text-white text-decoration-none txt" href="#">Seattle Consulting Myanmar Co., Ltd</a>
        <span class="text-white txt">© Copyright</span>
      </div>
      <!-- Copyright -->
    </footer>

  </div>
</template>

<script>

export default {
  data() {
    return {
      username: localStorage.getItem("username")
    }
  },
  methods: {
    logout (){
      localStorage.removeItem("token");
      localStorage.removeItem("username");
    }
  }
}
</script>

<style>
  .fade-enter-active, .fade-leave-active {
    transition: opacity .5s
  }
  .fade-enter, .fade-leave-active {
    opacity: 0
  }
  .pb-40 {
    padding-bottom: 40px;
  }
  .p-20 {
    padding: 8px 20px;
    position: sticky;
    top: 0;
  }
  .p-15 {
    width: 100%;
    position: fixed;
    bottom:0;
    padding: 10px 20px;
  }
  .txt-style {
    font-size: 24px !important;
    font-weight: bold !important;
    color: chartreuse !important;
  }
  li {
    font-size: 16px !important;
  }
  .nav-link {
    color: white !important;
  }
  .nav-link:hover {
    color: chartreuse !important;
  }
  .txt {
    font-size: 18px;
  }
</style>