<template>
  <div>
    <div class="container py-3">
      <div class="row text-center">
          <div class="col-lg-8 mx-auto">
              <h1 class="text-uppercase">{{ user.name }}'s Profile</h1>
              <p class="small text-muted mb-0">You can update profile data and change password.</p>
          </div>
      </div>
    </div>

    <div class="container mw-600 text-center mb-5">
      <div class="shadow-lg p-3 mb-5 bg-body rounded">
        <img v-bind:src="user.image_url" alt="" width="100" class="img-fluid rounded-circle mb-3 img-thumbnail shadow-sm">
        <h5 class="mb-0 text-uppercase">{{ user.name }}</h5>
        <span class="small text-muted">{{ user.email }}</span>
        <div class="row">
          <ul class="col-sm mb-3 mt-3 list-unstyled text-right">
            <li>Role : </li>
            <li>Created by : </li>
            <li>Created at : </li>
            <li>Phone No. : </li>
            <li>Date of Birth : </li>
            <li>Address : </li>
          </ul>
          <ul class="social mb-3 mt-3 col-sm list-unstyled text-left">
            <li>{{ (user.user_type == 0) ? "Admin" : "User" }}</li>
            <li>{{ user.created_user_id }}</li>
            <li>{{ date_format(user.created_at) }}</li>
            <li>{{ user.phone }}</li>
            <li>Date of Birth : {{ date_format(user.dob) }}</li>
            <li>{{ user.address }}</li>
          </ul>
        </div>
        <div class="d-flex justify-content-between">
          <router-link :to="{ name: 'UserUpdate', query: { id: user.id }}" >Update profile?</router-link>
          <router-link :to="{ name: 'ChangePassword', query: { id: user.id }}" >Change Password?</router-link>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data(){
    return{
      user: [],
      api_header : {headers: {
        'Authorization': localStorage.getItem('token')
      }}
    }
  },

  created: function()
  {
    this.fetchUser();
  },

  methods: {
    fetchUser()
    {
      console.log(this.$route.query.id);
      let uri = 'http://localhost:3000/users/'+this.$route.query.id;
      this.axios.get(uri, this.api_header).then((response) => {
        this.user = response.data;
      });
    }
  }
}
</script>

<style>
  .mw-600 {
    max-width: 600px;
  }
  h1 {
    font-size: 20px;
  }
  .text-left {
    text-align: left;
  }
  .text-right {
    text-align: right;
  }
</style>