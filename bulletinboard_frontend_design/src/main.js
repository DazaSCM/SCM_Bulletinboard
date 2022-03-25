import Vue from 'vue';
import VueRouter from 'vue-router';
import VueAxios from 'vue-axios';
import axios from 'axios';
import '../node_modules/bootstrap/dist/css/bootstrap.min.css';
import '../node_modules/bootstrap/dist/js/bootstrap.bundle.min.js';
import moment from 'moment';

import App from './App.vue';
import SignIn from './components/SignIn.vue';
import UserListsAdmin from './components/UserListsAdmin.vue';
import UserProfile from './components/UserProfile.vue';
import CreateUser from './components/CreateUser.vue';

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
  },
  {
    name: 'UserListsAdmin',
    path: '/admin_index',
    component: UserListsAdmin
  },
  {
    name: 'UserProfile',
    path: '/user_details',
    component: UserProfile
  },
  {
    name: 'CreateUser',
    path: '/create_user',
    component: CreateUser
  }
];

Vue.mixin({
  methods: {
    date_format (value) {
      return moment(value).format('MM/DD/YYYY')
    }
  },
});

const router = new VueRouter({ mode: 'history', routes: routes });

new Vue({
  router,
  render: h => h(App)
}).$mount('#app')
