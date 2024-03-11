#!/bin/bash

# Update package repositories and install Apache
sudo yum update -y
sudo yum install httpd -y

# Start Apache and enable it to start on boot
sudo systemctl start httpd
sudo systemctl enable httpd

# Write HTML content to index.html file
sudo bash -c 'cat <<EOF > /var/www/html/index.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Public IP Address</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f0f0f0;
            color: #333;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            margin-top: 20px;
        }
        h1 {
            text-align: center;
            margin-bottom: 20px;
            color: #555;
        }
        p {
            line-height: 1.6;
        }
        footer {
            text-align: center;
            margin-top: 20px;
            padding-top: 10px;
            border-top: 1px solid #ccc;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Public IP Address</h1>
        <p>Your public IP address is: <span id="public-ip">Fetching...</span></p>
        <footer>
            &copy; 2024 Your Website. All rights reserved.
        </footer>
    </div>

    <script>
        // Fetch public IP address using an external service
        fetch('https://api.ipify.org?format=json')
            .then(response => response.json())
            .then(data => {
                document.getElementById('public-ip').textContent = data.ip;
            })
            .catch(error => {
                console.error('Error fetching public IP:', error);
                document.getElementById('public-ip').textContent = 'Error fetching IP';
            });
    </script>
</body>
</html>

EOF
'
