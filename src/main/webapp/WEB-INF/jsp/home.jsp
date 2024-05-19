<%@ page import="org.example.petstore.model.Pet" %>
<%@ page import="java.util.List" %>
<% String email = (String) request.getAttribute("userEmail"); %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>All Pets</title>
    <!-- Include Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <!-- Include Axios via CDN -->
    <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
    <style>

        .navbar-custom .navbar-brand {
            color: white;
        }
        .custom-container {
            margin-top: 15vh; /* Adjust this value to move the cards further down */
        }
    </style>
</head>
<body>
<nav class="navbar custom-navbar-dark bg-primary">
    <!-- Navbar content -->
    <a class="navbar-brand" >Pet-Store</a>
    <a class="navbar-brand" href="/home">home</a>
    <a class="navbar-brand" href="/user-request">my requests</a>
    <a class="navbar-brand" href="/">Logout</a>

</nav>
<div class="container custom-container"> <!-- Add mt-5 (margin-top: 5) to create space at the top -->
    <div class="row justify-content-center">
        <% for (Pet pet : (List<Pet>) request.getAttribute("pets")) { %>
        <div class="col-md-4 mb-4">
            <div class="card shadow-sm" style="width: 18rem;">
                <img src="data:image/jpg;base64,<%= new String(org.apache.commons.codec.binary.Base64.encodeBase64(pet.getImage())) %>" class="card-img-top" alt="<%= pet.getName() %> Image" style="height: 200px; object-fit: cover;">
                <div class="card-body">
                    <h5 class="card-title">Name: <%= pet.getName() %></h5>
                    <p class="card-text">Age: <%= pet.getAge() %></p>
                    <p class="card-text">Category: <%= pet.getCategory() %></p>
                </div>
                <button type="button" class="btn btn-sm btn-outline-secondary" onclick="createRequest('<%= pet.getId() %>', '<%= email %>')">request</button>
            </div>
        </div>
        <% } %>
    </div>
</div>

<script>
    function createRequest(petId, userEmail) {
        const petRequest = {
            petId: petId,
            userEmail: userEmail
        };

        const options = {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(petRequest)
        };

        const url = 'http://localhost:8080/api/request-pet';

        fetch(url, options)
            .then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                return response.json();
            })
            .then(data => {
                console.log('Success:', data); // Handle the response data
                alert('Request submitted successfully!');
            })
            .catch(error => {
                console.error('Error:', error); // Handle any errors
                alert('An error occurred while submitting the request.');
            });
    }
</script>

<!-- Include Bootstrap JS (Optional) -->
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
