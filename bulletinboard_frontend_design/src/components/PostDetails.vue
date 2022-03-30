<template>
  <div>
    <div class="container py-3">
      <div class="row text-center">
          <div class="col-lg-8 mx-auto">
              <h1 class="text-uppercase">Post Details</h1>
              <p class="small text-muted mb-0">You can see your post's details here.</p>
          </div>
      </div>
    </div>

    <div class="container mw-600 text-center mb-5">
      <div class="shadow-lg p-3 mb-5 bg-body rounded">
        <h5 class="mb-0 text-uppercase">{{ post.title }}</h5>
        <div class="row">
          <ul class="col-sm lh-3 mb-3 mt-3 list-unstyled text-right">
            <li>Description : </li>
            <li>Status : </li>
            <li>Posted by : </li>
            <li>Posted at : </li>
          </ul>
          <ul class="social mb-3 lh-3 mt-3 col-sm list-unstyled text-left">
            <li>{{ post.description }}</li>
            <li>{{ (post.status == 1) ? "Active" : "Inactive" }}</li>
            <li>{{ post.user_id }}</li>
            <li>{{ date_format(post.created_at) }}</li>
          </ul>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data(){
    return{
      post: {},
      api_header : {headers: {
        'Authorization': localStorage.getItem('token')
      }}
    }
  },

  created: function()
  {
    this.fetchPost();
  },

  methods: {
    fetchPost()
    {
      var uri = 'http://localhost:3000/';
      if (localStorage.getItem("user_type") == 0){
        uri = uri+'admin_show/'+this.$route.query.id;
      }
      else {
        uri = uri+'users/'+this.$route.query.user_id+'/posts/'+this.$route.query.id;
      }
      this.axios.get(uri, this.api_header).then((response) => {
        this.post = response.data;
      });
    }
  }
}
</script>

<style>
  .mw-600 {
    max-width: 600px;
  }
  h1, h5 {
    font-family: 'Times New Roman', Times, serif;
    font-weight: bold;
    font-size: 24px;
  }
  .lh-3 {
    line-height: 3;
  }
  li {
    font-size: 18px !important;
  }
  .text-left {
    text-align: left;
  }
  .text-right {
    text-align: right;
  }
</style>