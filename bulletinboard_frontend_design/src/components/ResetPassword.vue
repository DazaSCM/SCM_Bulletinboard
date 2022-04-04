<template>
  <div class="container w-400  m-top">
    <h2 class="text-center mb-5">Reset Password</h2>
    <p v-if="errors.invalid_email" class="err_msg text-center mb-3">{{ errors.invalid_email }}</p>
    <div class="m-auto">
      <form v-on:submit.prevent="search" class="form">
        <div class="form-group mb-4">
            <input type="text" class="form-control" id="current_pass" v-model="user.email" placeholder="Enter Email" tabindex="1">
            <span class="err_msg">{{ errors.null_email }}</span>
        </div>                            
        <div class="d-flex justify-content-around">
          <button type="submit" class="btn btn-start-order">Search</button>
          <router-link :to="{ name: 'SignIn'}" class="btn btn-end-order" >Cancel</router-link>
        </div>                              
      </form>
    </div>
  </div>
</template>

<script>
export default {
  data(){
    return{
      errors: {},
      user: {}
    }
  },
  methods: {
    isValid() {
      this.errors = {};
      var isChecked = true;
      if (this.user.email == null) {
        this.errors.null_email = "Email is required to search!"
        isChecked = false;
      }
      return isChecked
    },
    search() {
      this.isValid();
      if (this.isValid() == true) {
        let uri = 'http://localhost:3000/find_user?email='+this.user.email;
        this.axios.post(uri).then((response) => {
          if(response.data.notice == null) {
            console.log(response.data.success);
            this.$router.push({name: 'SignIn', params: {message: response.data.success}});
          }
          else {
            this.isValid();
            console.log(response.data.notice);
            this.errors.invalid_email = response.data.notice;
          }
        });
      }
    }
  }
}
</script>

<style>
  .w-400 {
    max-width: 400px;
  }
  .m-top {
    margin: 150px auto auto auto;
  }
  textarea {
	resize: none;
  }
  .form-label {
    font-size: 12px;
    color: #5e9bfc;
    margin: 0;
    display: block;
    opacity: 1;
    -webkit-transition: .333s ease top, .333s ease opacity;
    transition: .333s ease top, .333s ease opacity;
  }
  .form-control {
    border-radius: 0;
    border-color: #ccc;
      border-width: 0 0 2px 0;
      border-style: none none solid none;
      box-shadow: none;
  }
  .form-control:focus {
    box-shadow: none;
    border-color: #5e9bfc;
  }
  .js-hide-label {
    opacity: 0; 	
  }
  .js-unhighlight-label {
    color: #999 
  }
  .btn-start-order, .btn-end-order {
    background: 0 0 #ffffff;
      border: 1px solid #2f323a;
      border-radius: 3px;
      color: #3307ac;
      font-family: "Raleway", sans-serif;
      font-size: 16px;
      line-height: inherit;
      margin: 30px 0;
      padding: 10px 15px;
      text-transform: uppercase;
      transition: all 0.25s ease 0s;
  }
  .btn-start-order:hover,.btn-start-order:active, .btn-start-order:focus {
    border-color: #1fe019;
    color: #40e22a;
  }
  .btn-end-order:hover,.btn-end-order:active, .btn-end-order:focus {
    border-color: #c9d426;
    color: #b5b825;
  }
</style>