<!DOCTYPE html>
<html>
<head>
    <style>
        .empty-cart-cls {
            width: 60%; /* Adjust the width to your preference */
            margin: auto; /* Center the div horizontally */
            text-align: center; /* Center the text content */
            margin-top: 150px; /* Adjust the margin-top to move the div lower */
        }

        .empty-cart-cls img {
            width: 130px; /* Adjust the image width */
            height: 130px; /* Adjust the image height */
            margin-bottom: 20px; /* Adjust the margin-bottom to space out the elements */
        }

        .empty-cart-cls h3 {
            margin-bottom: 20px; /* Adjust the margin-bottom to space out the elements */
        }

        .btn-home {
            display: inline-block;
            padding: 10px 20px;
            background-color: #4466f2;
            color: #fff;
            text-decoration: none;
            border: none;
            border-radius: 20px; /* Adjust the border-radius to make the button more rounded */
            transition: background-color 0.3s ease;
        }

        .btn-home:hover {
            background-color: #3454ca;
        }
    </style>
</head>
<body>
<div class="container-fluid mt-100">
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-body cart">
                    <div class="col-sm-12 empty-cart-cls text-center">
                        <img src="https://i.imgur.com/dCdflKN.png" width="130" height="130" class="img-fluid mb-4 mr-3">
                        <h3><strong>You have no submitted requests</strong></h3>
                        <a href="/home" class="btn-home cart-btn-transform m-3" data-abc="true">home</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
