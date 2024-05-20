<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Add Pet Form</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/simple-line-icons/2.4.1/css/simple-line-icons.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.2/css/all.css" integrity="sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr" crossorigin="anonymous">
    <style>
        body {
            background-color: #dee9ff;
        }

        .registration-form {
            padding: 50px 0;
        }

        .registration-form form {
            background-color: #fff;
            max-width: 600px;
            margin: auto;
            padding: 50px 70px;
            border-top-left-radius: 30px;
            border-top-right-radius: 30px;
            box-shadow: 0px 2px 10px rgba(0, 0, 0, 0.075);
        }

        .registration-form .form-icon {
            text-align: center;
            background-color: #5891ff;
            border-radius: 50%;
            font-size: 40px;
            color: white;
            width: 100px;
            height: 100px;
            margin: auto;
            margin-bottom: 50px;
            line-height: 100px;
        }

        .registration-form .item {
            border-radius: 20px;
            margin-bottom: 25px;
            padding: 10px 20px;
        }

        .registration-form .create-account {
            border-radius: 30px;
            padding: 10px 20px;
            font-size: 18px;
            font-weight: bold;
            background-color: #5791ff;
            border: none;
            color: white;
            margin-top: 20px;
        }

        @media (max-width: 576px) {
            .registration-form form {
                padding: 50px 20px;
            }

            .registration-form .form-icon {
                width: 70px;
                height: 70px;
                font-size: 30px;
                line-height: 70px;
            }
        }
    </style>
</head>
<body>
<div class="registration-form">
    <form id="addPetForm" enctype="multipart/form-data">
        <div class="form-icon">
            <span><i class="fas fa-cat"></i></span>
        </div>
        <div class="form-group">
            <input type="text" class="form-control item" id="name" name="name" placeholder="Name" required>
        </div>
        <div class="form-group">
            <select name="category" id="category" class="form-control item" required>
                <option value="">Select a category</option>
                <option value="cat">CAT</option>
                <option value="dog">DOG</option>
                <option value="bird">BIRD</option>
                <option value="rodent">RODENT</option>
                <option value="other">OTHER</option>
            </select>
        </div>
        <div class="form-group">
            <input type="number" class="form-control item" id="age" name="age" placeholder="Age" required>
        </div>
        <div class="form-group">
            <input type="file" class="form-control item" id="file" name="file" placeholder="Image" required>
        </div>
        <div class="form-group">
            <button type="button" class="btn btn-block create-account" onclick="submitForm()">Add</button>
        </div>
    </form>
</div>
<script>
    async function submitForm() {
        const form = document.getElementById('addPetForm');
        const formData = new FormData();

        // Create a DTO object
        const petDto = {
            name: form.name.value,
            category: form.category.value.toUpperCase(), // Ensure category stays in full caps
            age: form.age.value
        };

        console.log(petDto.category);

        // Convert the DTO to a JSON blob
        const petDtoBlob = new Blob([JSON.stringify(petDto)], {
            type: 'application/json'
        });

        // Append the DTO and file to FormData
        formData.append('data', petDtoBlob);
        formData.append('image', form.file.files[0]);

            const response = await fetch('http://localhost:8080/api/addpet', {
                method: 'POST',
                body: formData,
            });

            try {
                if (response.ok) {
                    alert('Pet added successfully!');
                }else {
                    throw new Error('problem accrued while adding pet');
                }
            }catch(error) {
                alert('Error: ' + error.message);
            }
            const data = await response.json();
            console.log('Success:', data);

    }
</script>
</body>
</html>
