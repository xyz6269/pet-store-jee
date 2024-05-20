<%@ page import="org.example.petstore.model.Pet" %>
<%@ page import="java.util.List" %>
<%@ page import="org.example.petstore.model.Request" %>

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
    <a class="navbar-brand" href="/admin-home">home</a>
    <a class="navbar-brand" href="/all-request">all requests</a>
    <a class="navbar-brand" href="/add-pet">new pets</a>
    <a class="navbar-brand" href="/">Logout</a>
</nav>
<div class="container custom-container">
    <div class="row row-cols-1 row-cols-md-3">
        <% for (Request request1 : (List<Request>) request.getAttribute("requests")){ %>
        <div class="col mb-4">
            <div class="card" style="border-radius: 15px;">
                <img src="data:image/jpg;base64,<%= new String(org.apache.commons.codec.binary.Base64.encodeBase64(request1.getPet().getImage())) %> " class="card-img-top" alt="Pet">
                <div class="card-body">
                    <p class="card-text"> client email : <%= request1.getClientEmail() %> </p>
                    <p class="card-text"> pet's name : <%= request1.getPet().getName() %> </p>
                </div>
                <div class="card-footer d-flex justify-content-between">
                    <button type="button" class="btn btn-sm btn-edit" onclick="rejectRequest('<%= request1.getId() %>')">Reject</button>
                    <button type="button" class="btn btn-sm btn-primary" onclick="grantRequest('<%= request1.getId() %>')">Grant</button>

                </div>
            </div>
        </div>
        <script>
            async function grantRequest(id) {
                console.log(id)
                const url = 'http://localhost:8080/api/delete-request/' + id;
                console.log(url)
                const formData = new FormData();
                const options = {
                    method: 'DELETE',
                    headers: {
                        'Content-Type': 'application/json'
                    }
                };
                fetch(url, options)
                    .then(response => {
                        if (!response.ok) {
                            throw new Error('Problem occurred while deleting pet');
                        } else {
                            alert("Pet deleted successfully");
                        }
                    })
                    .catch(error => {
                        alert('Error: ' + error.message);
                    });

                const mail = {
                    subject: "pet adoption request granted",
                    body: "your request has been validated by the pet store you may come pick your new pet", // Ensure category stays in full caps
                    to: '<%=request1.getClientEmail()%>'
                };

                const mailBlob = new Blob([JSON.stringify(mail)], {
                    type: 'application/json'
                });
                formData.append('mail', mailBlob)

                const response = await fetch('http://localhost:8080/api/send-mail', {
                    method: 'POST',
                    body: formData,
                });

                try {
                    if (response.ok) {
                        alert('mail sent successfully!');
                    } else {
                        throw new Error('problem accrued while mailing message');
                    }
                } catch (error) {
                    alert('Error: ' + error.message);
                }
                const data = await response.json();
                console.log('Success:', data);
            }

            async function rejectRequest(id) {
                console.log(id)
                const formData = new FormData();
                const url = 'http://localhost:8080/api/delete-request/' + id;
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
                            throw new Error('Problem occurred while deleting pet');
                        } else {
                            alert("Pet deleted successfully");
                        }
                    })
                    .catch(error => {
                        alert('Error: ' + error.message);
                    });

                const mail = {
                    subject: "pet adoption request rejected",
                    body: "unfortunately we found out you're incompatible with adopting this pet, we appreciate your engagement", // Ensure category stays in full caps
                    to: '<%=request1.getClientEmail()%>'
                };

                const mailBlob = new Blob([JSON.stringify(mail)], {
                    type: 'application/json'
                });
                formData.append('mail', mailBlob)
                console.log(formData)
                const response = await fetch('http://localhost:8080/api/send-mail', {
                    method: 'POST',
                    body: formData,
                });

                try {
                    if (response.ok) {
                        alert('mail sent successfully!');
                    } else {
                        throw new Error('problem accrued while mailing message');
                    }
                } catch (error) {
                    alert('Error: ' + error.message);
                }
                const data = await response.json();
                console.log('Success:', data);

            }
        </script>
        <% } %>
    </div>
</div>



<!-- Include Bootstrap JS (Optional) -->
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>


























