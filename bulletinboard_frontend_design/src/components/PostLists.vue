<template>
  <div class="container">
    <form v-on:submit.prevent="search" class="search">
      <div class="form-group-stylish row">
        <div class="col-sm-5">
          <input type="text" class="form-control" placeholder="Search by Title" @keyup="isClear" v-model="title">
        </div>
        <div class="col-sm-1">
          <button class="btn btn-info" type="submit" style="max-width: 120px;">Search</button>
        </div>
        <div class="col-sm-1">
          <router-link :to="{ name: 'CreatePost' }" class="btn btn-primary w-80" >Add</router-link>
        </div>
        <div class="col-sm-1">
          <vue-blob-json-csv
            file-type="csv"
            class="btn btn-primary w-80"
            file-name="todos"
            :data="post_lists"
          >
            Download
          </vue-blob-json-csv>
        </div>
        <div class="col-sm-1">
          <router-link :to="{ name: 'CSVupload' }" class="btn btn-primary w-80" >Upload</router-link>
        </div>
      </div>
    </form>
    <table class="table align-middle mt-3 mb-5 shadow-lg p-3 mb-5 bg-body rounded">
      <thead class="bg-light">
        <tr>
          <th>Title</th>
          <th>Description</th>
          <th>Posted User</th>
          <th>Posted Date</th>
          <th colspan="2">Actions</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="post in posts" :key="post.id">
          <td>
            <p class="fw-bold mb-1">{{ post.title }}</p>
          </td>
          <td>
            <p class="fw-normal mb-1">{{ post.description }}</p>
          </td>
          <td>
            <p class="fw-normal mb-1">{{ post.user_id }}</p>
          </td>
          <td>
            <p class="fw-normal mb-1">{{ date_format(post.created_at) }}</p>
          </td>
          <td>
            <router-link :to="{ name: 'PostDetails', query: { user_id: post.user_id, id: post.id }}" class="btn btn-outline-info" >Details</router-link>
          </td>
          <td>
            <button type="button" class="btn btn-outline-danger" @click="deletePost(post.user_id, post.id)">Delete</button>
          </td>
        </tr>
      </tbody>
    </table>
  </div>
  
</template>

<script>

  export default {
    data(){
      return{
        posts: {},
        post_lists: [],
        title: '',
        api_header : {headers: {
          'Authorization': localStorage.getItem('token')
        }}
      }
    },

    created: function()
    {
      this.fetchPosts();
    },

    methods: {
      fetchPosts()
      {
        var uri = 'http://localhost:3000/';
        if (localStorage.getItem("user_type") == 0){
          uri = uri+'all_posts';
        }
        else{
          uri = uri+'users/'+localStorage.getItem("id")+'/posts';
        }
        this.axios.get(uri, this.api_header).then((response) => {
          this.posts = response.data;
          this.post_lists = response.data;
        });
      },
      
      search()
      {
        let uri = 'http://localhost:3000/post_search?title='+this.title;
        this.axios.get(uri, this.api_header).then((response) => {
          this.posts = response.data;
        });
      },
      isClear(){
        if(!this.title){
          this.fetchPosts();
        }
      },
      deletePost(user_id, id)
      {
        let uri = 'http://localhost:3000/users/'+user_id+'/posts/'+id;
        this.axios.delete(uri, this.api_header).then(() => {
          this.fetchPosts();
        })
      }
    }
  }
</script>

<style>
  .search {
    margin: 30px auto;
  }
  .col-sm-1 {
    width: unset;
  }
  .w-80 {
    width: 100px;
  }
</style>