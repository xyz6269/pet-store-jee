<%@ page import="org.example.petstore.model.Pet" %>
<%@ page import="java.util.List" %>
<% String email = (String) request.getAttribute("userEmail"); %>
<!DOCTYPE html>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>All Pets</title>
    <!-- Include Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .custom-container {
            margin-top: 15vh; /* Adjust this value to move the cards further down */
        }
        .btn-edit {
            background-color: #dc3545;
            color: white;
        }
        .btn-edit:hover {
            background-color: #c82333;
            color: white;
        }
        .card {
            height: 400px; /* Set the height of the cards */
        }
        .card-img-top {
            height: 200px; /* Set the height of the images */
            object-fit: cover; /* Ensure the images cover the entire space */
        }
        .col {
            margin-bottom: 20px; /* Add margin between columns */
        }
    </style>
</head>
<body>
<nav class="navbar custom-navbar-dark bg-primary">
    <!-- Navbar content -->
    <a class="navbar-brand">Pet-Store</a>
    <a class="navbar-brand" href="/home">home</a>
    <a class="navbar-brand" href="/user-request">my requests</a>
    <a class="navbar-brand" href="/">Logout</a>
</nav>
<div class="container custom-container">
    <div class="row row-cols-1 row-cols-md-3">
        <% for (Pet pet : (List<Pet>) request.getAttribute("pets")) { %>
        <div class="col mb-4">
            <div class="card" style="border-radius: 15px;">
                <img src="data:image/jpg;base64,<%= new String(org.apache.commons.codec.binary.Base64.encodeBase64(pet.getImage())) %> " class="card-img-top" alt="Pet">
                <div class="card-body">
                    <p class="card-text"> pet's name : <%= pet.getName() %> </p>
                    <p class="card-text"> pet's age : <%= pet.getAge() %> </p>
                    <p class="card-text"> pet's category : <%= pet.getCategory() %> </p>
                </div>
                <div class="card-footer d-flex justify-content-between">
                    <button type="button" class="btn btn-sm btn-primary" onclick="createRequest('<%= pet.getId() %>', '<%=email%>')">request</button>
                </div>
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
                    throw new Error('Problem occurred while requesting pet');
                } else {
                    alert("Pet added to request successfully");
                }
            })
            .catch(error => {
                alert('Error: ' + error.message);
            });

    }
</script>

<!-- Include Bootstrap JS (Optional) -->
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
