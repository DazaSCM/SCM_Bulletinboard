<template>
  <div class="container w-400 m-auto">
    <h2 class="text-center m-50">Change Password</h2>
    <div class="m-auto">
      <form v-on:submit.prevent="change" class="form">
        <div class="form-group mb-4">
            <input type="password" class="form-control" id="current_pass" v-model="user.current_password" placeholder="Current Password" tabindex="1" required>
            <p id="current"></p>
        </div>                            
        <div class="form-group mb-4">
            <input type="password" class="form-control" id="new_pass" v-model="user.new_password" placeholder="New Password" tabindex="2" required>
            <p id="new"></p>
        </div>
        <div class="form-group">
            <input type="password" class="form-control" id="confirm_pass" name="confirm_password" placeholder="Confirm Password" tabindex="2" required>
            <p id="confirm"></p>
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
      user_id: this.$route.query.id,
      api_header : {headers: {
        'Authorization': localStorage.getItem('token')
      }}
    }
  },

  methods: {
    change()
    {
      console.log("id is",this.user_id);
      // let current = document.getElementById("current_pass").value;
      // let new_one = document.getElementById("new_pass").value;
      // let confirm = document.getElementById("confirm_pass").value;

      let uri = 'http://localhost:3000/change_password/'+this.user_id;
      this.axios.post(uri, this.user, this.api_header).then(() => {
        this.$router.push({name: 'UserProfile', query: {id: this.user_id}});
      });
    }
  }
}
</script>

<style>
  .w-400 {
    max-width: 400px;
  }
  .m-50 {
    margin: 50px 0;
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