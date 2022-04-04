<template>
  <div class="container w-400 m-top">
    <h2 class="text-center mb-5">Change Password</h2>
    <div class="m-auto">
      <form v-on:submit.prevent="change" class="form">
        <div class="form-group mb-4">
            <input type="password" class="form-control" id="current_pass" v-model="user.current_password" placeholder="Current Password" tabindex="1">
            <span class="err_msg">{{ errors.current_password }}</span>
        </div>                            
        <div class="form-group mb-4">
            <input type="password" class="form-control" id="new_pass" v-model="user.new_password" placeholder="New Password" tabindex="2">
            <span class="err_msg">{{ errors.new_password }}</span>
        </div>
        <div class="form-group">
            <input type="password" class="form-control" id="confirm_pass" v-model="user.confirm_password" name="confirm_password" placeholder="Confirm Password" tabindex="2">
            <span class="err_msg">{{ errors.confirm_password }}</span>
        </div>
        <div class="d-flex justify-content-around">
          <button type="submit" class="btn btn-start-order">Change</button>
          <router-link :to="{ name: 'UserProfile', query: { id: user_id }}" class="btn btn-end-order" >Cancel</router-link>
        </div>                              
      </form>
    </div>
  </div>
</template>

<script>
export default {
  data(){
    return{
      user: {},
      errors: {},
      user_id: this.$route.query.id,
      api_header : {headers: {
        'Authorization': localStorage.getItem('token')
      }}
    }
  },

  methods: {
    isValidate(){
      this.errors = {};
      var isChecked = true;
      if(this.user.current_password == null) {
        this.errors.current_password = "Current password must not be blank!";
        isChecked = false;
      }
      if(this.user.new_password == null) {
        this.errors.new_password = "New password must not be blank!";
        isChecked = false;
      }
      if(this.user.confirm_password == null) {
        this.errors.confirm_password = "Confirm password must not be blank!";
        isChecked = false;
      }
      if(this.user.new_password != this.user.confirm_password) {
        this.errors.confirm_password = "New password and Confirm password must be the same!";
        isChecked = false;
      }
      return isChecked
    },
    change()
    {
      this.isValidate();
      if(this.isValidate() == true) {
        let uri = 'http://localhost:3000/change_password/'+this.user_id;
        this.axios.post(uri, this.user, this.api_header).then(() => {
          this.$router.push({name: 'UserProfile', query: {id: this.user_id}, params: {message: "Password has successfully changed"}});
        }).catch(error => {
          if(error){
            this.isValidate();
            this.errors.current_password = "Invalid Current Password!"
            console.log(this.errors.current_password);
          }
        });
      }
    }
  }
}
</script>

<style>
  
</style>