<template>
  <div class="container">
    <div class="input-group rounded search">
      <input type="search" class="form-control rounded" placeholder="Search by Title" aria-label="Search" aria-describedby="search-addon" />
      <span class="input-group-text border-0 rounded" id="search-addon">
        <i class="fas fa-search"></i>
      </span>
      <span><router-link :to="{ name: 'CreateUser' }" class="btn btn-outline-success" >Add User</router-link></span>
    </div>
    <table class="table align-middle mt-5 mb-5 shadow-lg p-3 mb-5 bg-body rounded">
      <thead class="bg-light">
        <tr>
          <th>Name</th>
          <th>Email</th>
          <th>Created By</th>
          <th>Created Date</th>
          <th colspan="2">Actions</th>
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
          <td>
            <router-link :to="{ name: 'UserProfile', query: { id: user.id }}" class="btn btn-outline-info" >Details</router-link>
          </td>
          <td>
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
  span {
    margin-right: 20px;
  }
  .search {
    max-width: 400px;
    margin-top: 30px;
  }
</style>