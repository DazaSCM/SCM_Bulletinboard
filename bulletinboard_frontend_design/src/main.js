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
import UserUpdate from './components/UserUpdate.vue';
import ConfirmUser from './components/ConfirmUser.vue';
import ChangePassword from './components/ChangePassword.vue';
import PostLists from './components/PostLists.vue';
import PostDetails from './components/PostDetails.vue';
import CreatePost from './components/CreatePost.vue';
import UpdatePost from './components/UpdatePost.vue';
import CSVupload from './components/CSVupload.vue';
import ResetPassword from './components/ResetPassword.vue';
import UpdatePassword from './components/UpdatePassword.vue';

import VueBlobJsonCsv from 'vue-blob-json-csv';

Vue.use(VueBlobJsonCsv)

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
  },
  {
    name: 'UserUpdate',
    path: '/update_user',
    component: UserUpdate
  },
  {
    name: 'ConfirmUser',
    path: '/confirm_user',
    component: ConfirmUser
  },
  {
    name: 'ChangePassword',
    path: '/change_password',
    component: ChangePassword
  },
  {
    name: 'PostLists',
    path: '/all_posts',
    component: PostLists
  },
  {
    name: 'PostDetails',
    path: '/post_details',
    component: PostDetails
  },
  {
    name: 'CreatePost',
    path: '/create_post',
    component: CreatePost
  },
  {
    name: 'UpdatePost',
    path: '/update_post',
    component: UpdatePost
  },
  {
    name: 'CSVupload',
    path: '/csv_upload',
    component: CSVupload
  },
  {
    name: 'ResetPassword',
    path: '/reset_password',
    component: ResetPassword,
    meta: {
      hideNavbar: true,
    }
  },
  {
    name: 'UpdatePassword',
    path: '/update_password',
    component: UpdatePassword,
    meta: {
      hideNavbar: true,
    }
  }
];

Vue.mixin({
  methods: {
    date_format (value) {
      return moment(new Date(value)).format('MM/DD/YYYY')
    }
  },
});

const router = new VueRouter({ mode: 'history', routes: routes });

router.beforeEach((to, from, next) => {
  console.log("to - ", to.name, "from - ", from.name);
  if (!localStorage.getItem('token')) {
    if (to.name == 'SignIn' || to.name == 'ResetPassword' || to.name == 'UpdatePassword') {
      next()
    }
    else {
      next({ name: 'SignIn'})
    }
  }
  else {
    if (to.name == 'SignIn' || to.name == 'ResetPassword' || to.name == 'UpdatePassword') {
      next ({name: 'UserListsAdmin'})
    }
    else {
      next()
    }
  }
});

new Vue({
  router,
  render: h => h(App)
}).$mount('#app')
