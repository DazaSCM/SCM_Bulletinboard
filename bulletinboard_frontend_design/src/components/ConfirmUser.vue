<template>
  <div>
    <div class="container py-3">
      <div class="row text-center">
          <div class="col-lg-8 mx-auto">
              <h1 class="text-uppercase">Confirm User</h1>
          </div>
      </div>
    </div>

    <!-- <div class="container mw-600 text-center mb-5">
      <div class="shadow-lg p-3 mb-5 bg-body rounded">
        <img v-bind:src="user.image_url" alt="" width="100" class="img-fluid rounded-circle mb-3 img-thumbnail shadow-sm">
        <h5 class="mb-0 text-uppercase">{{ user.name }}</h5>
        <span class="small text-muted">{{ user.email }}</span>
        <div class="row">
          <ul class="col-sm mb-3 mt-3 list-unstyled text-right">
            <li>Role : </li>
            <li>Created by : </li>
            <li>Phone No. : </li>
            <li>Date of Birth : </li>
            <li>Address : </li>
          </ul>
          <ul class="social mb-3 mt-3 col-sm list-unstyled text-left">
            <li>{{ (user.user_type == 0) ? "Admin" : "User" }}</li>
            <li>{{ user.created_user_id }}</li>
            <li>{{ user.phone }}</li>
            <li>{{ date_format(user.dob) }}</li>
            <li>{{ user.address }}</li>
          </ul>
        </div>
        <div class="d-flex justify-content-between">
          <button @click="addUser" class="btn btn-outline-success">Create</button>
          <button @click="cancel" class="btn btn-outline-warning">Cancel</button>
        </div>
      </div>
    </div> -->
  </div>
</template>

<script>
  export default {
    name: "ConfirmUser"
  }
</script>

<style>

</style>