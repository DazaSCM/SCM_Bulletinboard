<template>
  <section class="vh-100">
    <div class="container container-fluid h-custom">
      <div class="row d-flex justify-content-center align-items-center h-100">
        <div class="col-md-9 col-lg-6 col-xl-5">
          <img src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-login-form/draw2.webp" class="img-fluid"
            alt="Sample image">
        </div>
        <div class="col-md-8 col-lg-6 col-xl-4 offset-xl-1">
          <p v-if="message" class="text-center text-success">{{ message }}</p>
          <form v-on:submit.prevent="signIn">
            <div class="text-center">
              <p class="lead fw-bold sign-in mb-0 me-3">Sign in to your account</p>
            </div>

            <div class="divider d-flex align-items-center my-4"></div>

            <p class="err text-center">{{ errors.invalid_err }}</p>

            <div class="form-outline mb-4">
              <input type="email" id="form3Example3" class="form-control form-control-lg" v-model="user.email" placeholder="Email address" />
              <span class="err">{{ errors.email }}</span>
            </div>

            <div class="form-outline mb-3">
              <input type="password" id="form3Example4" class="form-control form-control-lg" v-model="user.password" placeholder="Enter password" />
              <span class="err">{{ errors.password }}</span>
            </div>

            <div class="d-flex justify-content-between align-items-center">
              <div class="form-check mb-0">
                <input class="form-check-input me-2" type="checkbox" value="" id="form2Example3" />
                <label class="form-check-label" for="form2Example3">
                  Remember me
                </label>
              </div>
              <router-link :to="{ name: 'ResetPassword'}" >Forgot Password?</router-link>
            </div>

            <div class="text-center text-lg-start mt-4 pt-2">
              <input type="submit" class="btn btn-primary btn-lg"
                style="padding-left: 2.5rem; padding-right: 2.5rem;" value="Login" />
            </div>

          </form>
        </div>
      </div>
    </div>

  </section>
</template>

<script>
  export default {
    Components: {
      name: 'SignIn'
    },
    
    data() {
      return {
        user: {},
        errors: {},
        message: this.$route.params.message
      }
    },
    methods: {
      isValidate() {
        this.errors = {};
        var isChecked = true;
        if(this.user.email == null) {
          this.errors.email = 'Email is required!';
          isChecked = false;
        }
        if(this.user.password == null) {
          this.errors.password = 'Password is required!'
          isChecked = false;
        }
        return isChecked
      },
      signIn () {
        this.isValidate();
        let uri = 'http://localhost:3000/login';
        if(this.isValidate() == true)
        this.axios.post(uri, this.user).then((response) => {
          localStorage.setItem("token", response.data.token);
          localStorage.setItem("username", response.data.username);
          localStorage.setItem("id", response.data.id);
          localStorage.setItem("user_type", response.data.user_type);
          this.$router.push({name: 'UserListsAdmin'});
          window.dispatchEvent(new CustomEvent('localstorage-changed'));
        }).catch(e => {
          console.log(e);
          this.isValidate();
          this.errors.invalid_err = "Incorrect email or password!"
        });
      }
    }
  }
</script>

<style>
  .divider:after,
  .divider:before {
    content: "";
    flex: 1;
    height: 1px;
    background: #eee;
  }

  .h-custom {
    height: calc(100% - 73px);
  }

  .sign-in {
    font-size: 22px;
  }

  a {
    text-decoration: none;
  }

  .err {
    color: red;
    margin-bottom: 10px;
  }

  @media (max-width: 450px) {
    .h-custom {
      height: 100%;
    }
  }
</style>