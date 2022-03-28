<template>
  <section class="vh-100">
    <div class="container py-5 h-100">
      <div class="row justify-content-center align-items-center h-100">
        <div class="col-12 col-lg-9 col-xl-7">
          <div class="shadow p-3 mb-5 bg-white rounded card-registration">
            <div class="card-body p-4 p-md-2">
              <h3 class="text-center pb-md-0 mb-md-4">Update Profile</h3>
              <hr class="mb-md-4">
              <form enctype="multipart/form-data" v-on:submit.prevent="updateUser">

                <div class="row">
                  <div class="col-md-6 mb-4">

                    <div class="form-outline">
                      <input type="text" id="name" class="form-control form-control-lg" placeholder="Enter Name" v-model="user.name" />
                    </div>

                  </div>
                  <div class="col-md-6 mb-4">

                    <div class="form-outline">
                      <input type="text" id="email" class="form-control form-control-lg" placeholder="Enter Email" v-model="user.email" />
                    </div>

                  </div>
                </div>

                <div class="row">
                  <div class="col-md-6 mb-4 d-flex align-items-center">

                    <div class="form-outline datepicker w-100">
                      <input type="text" placeholder="Enter Birthday" onfocus="(this.type='date')" class="form-control form-control-lg" v-model="user.dob" />
                    </div>

                  </div>
                  <div class="col-md-6 mb-4">

                    <h6 class="mb-2 pb-1">User Type: </h6>

                    <div class="form-check form-check-inline">
                      <input
                        class="form-check-input"
                        type="radio"
                        name="inlineRadioOptions"
                        id="user"
                        value="1"
                        v-model="user.user_type"
                      />
                      <label class="form-check-label" for="user">User</label>
                    </div>

                    <div class="form-check form-check-inline">
                      <input
                        class="form-check-input"
                        type="radio"
                        name="inlineRadioOptions"
                        id="admin"
                        value="0"
                        v-model="user.user_type"
                      />
                      <label class="form-check-label" for="admin">Admin</label>
                    </div>

                  </div>
                </div>

                <div class="row">
                  <div class="col-md-6 mb-4 pb-2">

                    <div class="form-outline">
                      <input type="text" id="address" class="form-control form-control-lg" placeholder="Enter Address" v-model="user.address" />
                    </div>

                  </div>
                  <div class="col-md-6 mb-4 pb-2">

                    <div class="form-outline">
                      <input type="tel" id="phoneNumber" class="form-control form-control-lg" placeholder="Enter Phone Number" v-model="user.phone" />
                    </div>

                  </div>
                </div>

                <div class="row">
                  <div class="col-12">
                    <label class="form-label" for="customFile">Choose Profile Photo</label>
                    <input type="file" class="form-control" id="customFile" @change="setImage" />
                  </div>
                </div>

                <div class="mt-4 pt-2 d-flex justify-content-around align-items-center">
                  <input class="btn btn-outline-primary btn-lg" type="submit" value="Submit" />
                  <router-link :to="{ name: 'UserProfile', query: { id: user.id }}" class="btn btn-outline-primary" >Cancel</router-link>
                </div>

              </form>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<script>
export default {
  data() {
    return {
      user: {},
      api_header : {headers: {
        'Authorization': localStorage.getItem('token')
      }}
    }
  },
  created: function() {
    this.getUser();
  },
  methods: {
    setImage(e) {
      e.preventDefault();
      this.user.profile = e.target.files[0];
      console.log("e photo is --",e, "this user --",this.user.profile);
    },
    getUser()
    {
      let uri = 'http://localhost:3000/users/'+ this.$route.query.id;
      this.axios.get(uri, this.api_header).then((response) => {
        this.user = response.data;
        this.user.dob = this.date_format(this.user.dob);
        console.log(response);
        return response
      });
    },

    updateUser()
    {
      let uri = 'http://localhost:3000/users/' + this.$route.query.id;

      let formData = new FormData();
      formData.append("name", this.user.name);
      formData.append("email", this.user.email);
      formData.append("dob", this.user.dob);
      formData.append("user_type", this.user.user_type);
      formData.append("address", this.user.address);
      formData.append("phone", this.user.phone);
      formData.append("profile", this.user.profile);
      formData.append("updated_user_id", localStorage.getItem("id"));

      this.axios.put(uri, formData, this.api_header).then((response) => {
        this.$router.push({name: 'UserProfile', query: { id: this.user.id }});
        return response
      });
    }
  }
}
</script>

<style>
  .gradient-custom {
  /* fallback for old browsers */
  background: #f093fb;

  /* Chrome 10-25, Safari 5.1-6 */
  background: -webkit-linear-gradient(to bottom right, rgba(240, 147, 251, 1), rgba(245, 87, 108, 1));

  /* W3C, IE 10+/ Edge, Firefox 16+, Chrome 26+, Opera 12+, Safari 7+ */
  background: linear-gradient(to bottom right, rgba(240, 147, 251, 1), rgba(245, 87, 108, 1))
  }

  .card-registration .select-input.form-control[readonly]:not([disabled]) {
    line-height: 2.15;
    padding-left: .75em;
    padding-right: .75em;
  }
  .card-registration .select-arrow {
    top: 13px;
  }
  input{
    font-family: 'Times New Roman', Times, serif;
    font-size: 17px !important;
  }
</style>