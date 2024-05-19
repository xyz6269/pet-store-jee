<!DOCTYPE html>

<html>
<head>
    <title>Login Page</title>
    <!-- Bootstrap core CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
</head>
<body>
<script>
    // Function to get a cookie value by name
</script>

    <div class="container-fluid h-custom">
        <div class="row d-flex justify-content-center align-items-center h-100">
            <div class="col-md-9 col-lg-6 col-xl-5">
                <img src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-login-form/draw2.webp"
                     class="img-fluid" alt="Sample image">
            </div>
            <div class="col-md-8 col-lg-6 col-xl-4 offset-xl-1">
                <form action="/login" method="post">

                    <!-- Email input -->
                    <div data-mdb-input-init class="form-group mb-4">
                        <input name="email" type="email" id="form3Example3" class="form-control form-control-lg"
                               placeholder="Enter a valid email address" style="width: 300px;" />
                    </div>

                    <!-- Password input -->
                    <div data-mdb-input-init class="form-group mb-3">
                        <input name="password" type="password" id="form3Example4" class="form-control form-control-lg"
                               placeholder="Enter password" style="width: 300px;" />
                    </div>

                    <div class="text-center text-lg-start">
                        <button type="submit" data-mdb-button-init data-mdb-ripple-init class="btn btn-primary btn-lg"
                                style="padding-left: 2.5rem; padding-right: 2.5rem;">Login</button>
                        <p class="small fw-bold mt-2 pt-1 mb-0">Don't have an account? <a href="/create-acc" class="text-danger">Register</a></p>
                    </div>
                </form>
            </div>
        </div>
    </div>


</body>
</html>
