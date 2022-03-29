<template>
  <div class="container">
    <form v-on:submit.prevent="search" class="search">
      <div class="form-group-stylish row">
        <div class="col-sm-5">
          <input type="text" class="form-control" placeholder="Search by Name" @keyup="isClear" v-model="name">
        </div>
        <div class="col-sm-1">
          <button class="btn btn-primary" type="submit" style="max-width: 120px;">Search</button>
        </div>
        <div v-if="type == 0" class="col-sm-2">
          <router-link :to="{ name: 'CreateUser' }" class="btn btn-success" >Add New</router-link>
        </div>
      </div>
    </form>

    <table class="table align-middle mt-3 mb-5 shadow-lg p-3 mb-5 bg-body rounded">
      <thead class="bg-light">
        <tr>
          <th>Name</th>
          <th>Email</th>
          <th>Created By</th>
          <th>Created Date</th>
          <th v-if="type == 0" colspan="2">Actions</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="user in users" :key="user.id">
          <td>
            <div class="d-flex align-items-center">
              <img
                  v-bind:src="user.image_url"
                  alt=""
                  style="width: 45px; height: 45px"
                  class="rounded-circle"
                  />
              <div class="ms-3">
                <p class="fw-bold mb-1">{{ user.name }}</p>
              </div>
            </div>
          </td>
          <td>
            <p class="fw-normal mb-1">{{ user.email }}</p>
          </td>
          <td>
            <p class="fw-normal mb-1">{{ user.created_user_id }}</p>
          </td>
          <td>
            <p class="fw-normal mb-1">{{ date_format(user.created_at) }}</p>
          </td>
          <td v-if="type == 0">
            <router-link :to="{ name: 'UserProfile', query: { id: user.id }}" class="btn btn-outline-info" >Details</router-link>
          </td>
          <td v-if="type == 0">
            <button type="button" class="btn btn-outline-danger" @click="deleteUser(user.id)">Delete</button>
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
      users: [],
      name: "",
      type: localStorage.getItem("user_type"),
      api_header : {headers: {
        'Authorization': localStorage.getItem('token')
      }}
    }
  },

  created: function()
  {
    this.fetchUsers();
  },

  methods: {
    fetchUsers()
    {
      let uri = 'http://localhost:3000/users';
      this.axios.get(uri, this.api_header).then((response) => {
        this.users = response.data;
      });
    },
    search()
    {
      console.log(this.name);
      let uri = 'http://localhost:3000/search?name='+this.name;
      this.axios.get(uri, this.api_header).then((response) => {
        this.users = response.data;
      });
    },
    isClear(){
      if(!this.name){
        this.fetchUsers();
      }
    },
    deleteUser(id)
    {
      let uri = 'http://localhost:3000/users/'+id;
      this.axios.delete(uri, this.api_header).then(() => {
        this.fetchUsers();
      })
    }
  }
}
</script>

<style>
  .search {
    margin: 30px auto;
  }
</style>