import Vue from 'vue';
import VueRouter from 'vue-router';
import VueAxios from 'vue-axios';
import axios from 'axios';
import '../node_modules/bootstrap/dist/css/bootstrap.min.css';

import App from './App.vue';
import SignIn from './components/SignIn.vue';

Vue.use(VueRouter);
Vue.use(VueAxios, axios);

Vue.config.productionTip = false

const routes = [
  {
    name: 'SignIn',
    path: '/',
    component: SignIn,
    meta: {
      hideNavbar: true,
    }
  }
];

const router = new VueRouter({ mode: 'history', routes: routes });

new Vue({
  router,
  render: h => h(App)
}).$mount('#app')
