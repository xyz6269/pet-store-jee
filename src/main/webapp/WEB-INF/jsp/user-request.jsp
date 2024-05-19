<%@ page import="org.example.petstore.model.Request" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Request</title>
    <!-- Include Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <!-- Include Font Awesome for icons (Optional) -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">

</head>
<body>
<nav class="navbar custom-navbar-dark bg-primary">
    <!-- Navbar content -->
    <a class="navbar-brand" >Pet-Store</a>
    <a class="navbar-brand" href="/home">home</a>
    <a class="navbar-brand" href="/user-request">my requests</a>
    <a class="navbar-brand" href="/">Logout</a>

</nav>
<section class="h-100 gradient-custom">
    <div class="container mt-5 py-5"> <!-- Add mt-5 to create space at the top -->
        <div class="row d-flex justify-content-center my-4">
            <div class="col-md-8">
                <div class="card mb-4">
                    <div class="card-header py-3">
                        <h5 class="mb-0">My Request</h5>
                    </div>
                    <div class="card-body">
                        <!-- Single item -->
                        <div class="row">
                            <div class="col-lg-3 col-md-12 mb-4 mb-lg-0">
                                <% Request request1 = (Request) request.getAttribute("request"); %>
                                <div class="bg-image hover-overlay hover-zoom ripple rounded" data-mdb-ripple-color="light">
                                    <img src="data:image/jpg;base64,<%= new String(org.apache.commons.codec.binary.Base64.encodeBase64(request1.getPet().getImage())) %>"
                                         class="w-100" alt="<%= request1.getPet().getName() %> Image" style="height: 200px; object-fit: cover;">
                                    <a href="#!">
                                        <div class="mask" style="background-color: rgba(251, 251, 251, 0.2)"></div>
                                    </a>
                                </div>
                                <!-- Image -->
                            </div>

                            <div class="col-lg-5 col-md-6 mb-4 mb-lg-0">
                                <% System.out.println(request1.getClientEmail()); %>
                                <p><strong>Pet Name: <%= request1.getPet().getName() %> </strong></p>
                                <p>Pet Category: <%= request1.getPet().getCategory() %></p>
                                <p>Client Email: <%= request1.getClientEmail() %></p>
                                <button type="button" data-mdb-button-init data-mdb-ripple-init class="btn btn-primary btn-sm me-1 mb-2" data-mdb-tooltip-init
                                        title="Remove item">
                                    <i class="fas fa-trash"></i>
                                </button>
                                <button type="button" data-mdb-button-init data-mdb-ripple-init class="btn btn-danger btn-sm mb-2" data-mdb-tooltip-init
                                        title="Move to the wish list">
                                    <i class="fas fa-heart"></i>
                                </button>
                                <!-- Data -->
                            </div>

                        </div>
                        <!-- Single item -->

                        <hr class="my-4" />

                    </div>
                </div>

            </div>

        </div>
    </div>
</section>

<!-- Include Bootstrap JS (Optional) -->
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
<
