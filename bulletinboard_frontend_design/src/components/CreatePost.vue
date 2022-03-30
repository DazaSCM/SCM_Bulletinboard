<template>
  <div>
    <form v-if="isCreate" v-on:submit.prevent="confirmUser" class="post-form">
      <h1>Create Post</h1>
      <label class="form-label">
        <p class="label-txt">Title</p>
        <input type="text" class="input" v-model="post.title">
        <div class="line-box">
          <div class="line"></div>
        </div>
        <span class="err_msg">{{ errors.title }}</span>
      </label>
      <label class="form-label">
        <p class="label-txt">Description</p>
        <input type="text" class="input" v-model="post.description">
        <div class="line-box">
          <div class="line"></div>
        </div>
        <span class="err_msg">{{ errors.description }}</span>
      </label>
      <label class="form-label">
        <h6 class="mb-2 pb-1 header">Status: </h6>

        <div class="form-check mr-50 form-check-inline">
          <input
            class="form-check-input"
            type="radio"
            name="inlineRadioOptions"
            id="active"
            value="1"
            v-model="post.status"
            checked
          />
          <label class="form-check-label" for="user">Active</label>
        </div>

        <div class="form-check form-check-inline">
          <input
            class="form-check-input"
            type="radio"
            name="inlineRadioOptions"
            id="inactive"
            value="0"
            v-model="post.status"
          />
          <label class="form-check-label" for="admin">Inactive</label>
        </div><br>
        <span class="err_msg">{{ errors.status }}</span>
      </label>
      <div class="d-flex justify-content-around">
        <button type="submit" class="post-btn">Submit</button>
        <router-link :to='{name: "PostLists"}' class="post-cancel-btn">Cancel</router-link>
      </div>
    </form>
    <ConfirmPost v-else :post="post" :user_id='user_id' @cancelConfirm="cancel" @submitPost="addPost"/>
  </div>
  
</template>

<script>
import ConfirmPost from './ConfirmPost.vue';
export default {
  name: "CreatePost",
  components: {
    ConfirmPost
  },
  data() {
    return {
      post: {},
      errors: {},
      isCreate: true,
      user_id: localStorage.getItem("id"),
      api_header : {headers: {
        'Authorization': localStorage.getItem('token')
      }}
    }
  },
  methods: {
    isValidate(){
      this.errors = {};
      var isChecked = true;
      if(!this.post.title ){
        this.errors.title = 'Title is required!';
        isChecked = false;
      }
      if(!this.post.description) {
        this.errors.description = 'Description is required!';
        isChecked = false;
      }
      if(!this.post.status) {
        this.errors.status = "Status is required!";
        isChecked = false;
      }
      return isChecked;
    },
    confirmUser(){
      this.isValidate();
      if(this.isValidate() == true) {
        this.isCreate = false;
      }
    },
    cancel(){
      this.isCreate = true;
    },
    addPost(){
      let uri = 'http://localhost:3000/users/'+localStorage.getItem("id")+'/posts';
      this.axios.post(uri, this.post, this.api_header).then((response) => {
          this.$router.push({name: 'PostLists'});
           console.log(response.data);
        });
    }
  }
}
</script>

<style>
  .post-form {
  width: 40%;
  margin: 60px auto;
  background: #efefef;
  padding: 20px 40px;
  text-align: center;
  -webkit-box-shadow: 2px 2px 3px rgba(0,0,0,0.1);
  box-shadow: 2px 2px 3px rgba(0,0,0,0.1);
  }
  .form-label {
    display: block;
    position: relative;
    margin: 40px 0px;
  }
  .label-txt {
    position: absolute;
    top: -1.6em;
    padding: 10px;
    font-family: sans-serif;
    font-size: 1.3em;
    letter-spacing: 1px;
    color: rgb(120,120,120);
    transition: ease .3s;
  }
  .input {
    width: 100%;
    padding: 10px;
    background: transparent;
    border: none;
    outline: none;
  }

  .line-box {
    position: relative;
    width: 100%;
    height: 2px;
    background: #BCBCBC;
  }

  .line {
    position: absolute;
    width: 0%;
    height: 2px;
    top: 0px;
    left: 50%;
    transform: translateX(-50%);
    background: #8BC34A;
    transition: ease .6s;
  }

  .input:focus + .line-box .line {
    width: 100%;
  }

  .label-active {
    top: -3em;
  }

  .post-btn, .post-cancel-btn {
    display: inline-block;
    padding: 12px 24px;
    background: rgb(220,220,220);
    font-weight: bold;
    color: rgb(120,120,120);
    border: none;
    outline: none;
    border-radius: 3px;
    cursor: pointer;
    transition: ease .3s;
  }

  .post-btn:hover {
    background: #8BC34A;
    color: #ffffff;
  }

  .post-cancel-btn:hover {
    background: rgb(56, 25, 231);
    color: #ffffff;
  }

  .header {
    font-size: 20px;
  }
  .mr-50 {
    margin-right: 50px;
  }
  .form-check-label {
    font-size: 16px !important;
  }
  .err_msg {
    color: red;
    margin-top: 10px;
  }
</style>