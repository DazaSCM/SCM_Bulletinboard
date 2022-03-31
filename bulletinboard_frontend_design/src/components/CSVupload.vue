<template>
  <div>
    <form v-on:submit.prevent="addPost" class="post-form">
      <h1 class="mb-5">Upload CSV File</h1>
        <div class="form-group mb-4">
          <p class="label-txt">Upload CSV file </p>
          <input type="file" class="form-control" @change="upload">
          <span class="err_msg">{{ csv_err }}</span>
        </div>
        
      <div class="d-flex justify-content-around mb-4">
        <button type="submit" class="post-btn">Submit</button>
        <router-link :to='{name: "PostLists"}' class="post-cancel-btn">Cancel</router-link>
      </div>
    </form>
  </div>
  
</template>

<script>
export default {
  name: "CreatePost",
  
  data() {
    return {
      csv_err: '',
      isCreate: true,
      user_id: localStorage.getItem("id"),
      form: new FormData,
      api_header : {headers: {
        'Authorization': localStorage.getItem('token')
      }}
    }
  },
  methods: {
    isValidate(){
      this.csv_err = '';
      var isChecked = true;
      if(this.form.get("csv_file") == null ){
        this.csv_err = 'File is required!';
        isChecked = false;
      }
      return isChecked;
    },
    upload: function(e) {
      let file = e.target.files[0];
      this.form.append('csv_file', file);
    },
    addPost() {
      this.isValidate();
      this.form.append('user_id', this.user_id);
      let uri = 'http://localhost:3000/csv_create';
      if (this.isValidate() == true) {
        this.axios.post(uri, this.form, this.api_header).then((response) => {
          this.$router.push({name: 'PostLists'});
            console.log(response.data);
        });
      }
    }
  }
}
</script>

<style>
  .post-form {
    width: 40%;
    margin: 120px auto;
    background: #efefef;
    padding: 40px 40px;
    text-align: center;
    -webkit-box-shadow: 2px 2px 3px rgba(0,0,0,0.1);
    box-shadow: 2px 2px 3px rgba(0,0,0,0.1);
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