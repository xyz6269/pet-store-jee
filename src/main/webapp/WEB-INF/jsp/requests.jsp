
<%@ page import="java.util.List" %>
<%@ page import="org.example.petstore.model.Request" %>
<!DOCTYPE html>
<%
    Cookie jwtToken = new Cookie("jwtToken", request.getParameter("jwtToken"));
%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>All Requests</title>
    <!-- Include Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<div class="container mt-5"> <!-- Add mt-5 (margin-top: 5) to create space at the top -->
    <div class="row justify-content-center">
        <% for (Request request1 : (List<Request>) request.getAttribute("requests")) { %>
        <div class="col-md-4 mb-4">
            <div class="card shadow-sm" style="width: 18rem;">
                <img src="data:image/jpg;base64,<%= new String(org.apache.commons.codec.binary.Base64.encodeBase64(request1.getPet().getImage())) %>" class="card-img-top" alt="<%= request1.getPet().getName() %> Image" style="height: 200px; object-fit: cover;">
                <div class="card-body">
                    <h5 class="card-title">Name: <%= request1.getClientEmail() %></h5>
                    <p class="card-text">pet to addopt: <%= request1.getPet().getName() %></p>
                </div>
                <button type="button" class="btn btn-sm btn-outline-secondary" >remove</button>
            </div>
        </div>
        <% } %>
    </div>
</div>



<!-- Include Bootstrap JS (Optional) -->
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>




