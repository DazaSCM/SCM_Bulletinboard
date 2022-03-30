<template>
  <div>
    <div class="container py-3">
      <div class="row text-center">
          <div class="col-lg-8 mx-auto">
              <h1 class="text-uppercase">Post Confirmation</h1>
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
          </ul>
          <ul class="social mb-3 lh-3 mt-3 col-sm list-unstyled text-left">
            <li>{{ post.description }}</li>
            <li>{{ (post.status == 1) ? "Active" : "Inactive" }}</li>
            <li>{{ user_id }}</li>
          </ul>
        </div>
        <div class="d-flex justify-content-between">
          <button @click="$emit('submitPost')" class="btn btn-outline-success">Submit</button>
          <button @click="$emit('cancelConfirm')" class="btn btn-outline-warning">Cancel</button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  export default {
    name: "ConfirmPost",
    props: {
      post: {
        type: Object,
        required: true
      },
      user_id: {
        required: true
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