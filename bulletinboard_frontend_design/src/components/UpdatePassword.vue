<template>
  <div class="container w-400  m-top">
    <h2 class="text-center mb-5">Update Password</h2>
    <p v-if="errors.expired" class="err_msg text-center mb-3">{{ errors.expired }}</p>
    <div class="m-auto">
      <form v-on:submit.prevent="change" class="form">
        <div class="form-group mb-4">
            <input type="password" class="form-control" id="new_pass" v-model="user.password" placeholder="Enter New Password" tabindex="1">
            <span class="err_msg">{{ errors.new_pass }}</span>
        </div>
        <div class="form-group mb-4">
            <input type="password" class="form-control" id="confirm_pass" v-model="user.confirm_password" placeholder="Re-enter Password" tabindex="1">
            <span class="err_msg">{{ errors.confirm_pass }}</span>
        </div>                              
        <div class="text-center">
          <button type="submit" class="btn btn-start-order">Change</button>
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
      if(this.user.password == null) {
        this.errors.new_pass = "New Password must not be blank!";
        isChecked = false;
      }
      if(this.user.confirm_password == null) {
        this.errors.confirm_pass = "Confirm Password must not be blank!";
        isChecked = false;
      }
      if(this.user.password != this.user.confirm_password) {
        this.errors.confirm_pass = "Two password fields must be the same";
        isChecked = false;
      }
      return isChecked
    },
    change() {
      this.isValid();
      if (this.isValid() == true) {
        this.user.reset_token = this.$route.query.reset_token;
        let uri = 'http://localhost:3000/update_password';
        this.axios.post(uri, this.user).then((response) => {
          console.log(response.data);
          this.$router.push({name: 'SignIn', params: {message: response.data.notice}});
        }).catch(error => {
          if(error){
            this.isValid();
            this.errors.expired = "The password reset time limit is over, try again!"
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