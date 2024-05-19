<%@ page import="org.example.petstore.model.Pet" %>
<%@ page import="java.util.List" %>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>All Pets</title>
    <!-- Include Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5"> <!-- Add mt-5 (margin-top: 5) to create space at the top -->
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
                <script>
                    function deletePet(id) {
                        console.log(id)
                        const url = 'http://localhost:8080/api/delete-pet/' +id;
                        console.log(url)
                        const options = {
                            method: 'DELETE',
                            headers: {
                                'Content-Type': 'application/json'
                            }
                        };
                        fetch(url, options)
                            .then(response => {
                                if (!response.ok) {
                                    throw new Error('Network response was not ok');
                                }
                                return response.json();
                            })
                            .then(data => {
                                console.log('Success:', data); // Handle the response data
                                alert('Pet deleted successfully!');
                            })

                    }
                </script>
                <button type="button" class="btn btn-sm btn-outline-secondary" onclick="deletePet('<%= pet.getId() %>')">delete</button>
            </div>
        </div>
        <% } %>
    </div>
</div>





<!-- Include Bootstrap JS (Optional) -->
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
