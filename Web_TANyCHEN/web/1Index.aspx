<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="1Index.aspx.cs" Inherits="Web_TANyCHEN.WebForm1" %>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Medical center</title>
    <link rel="stylesheet" href="inicio.css">
</head>
<body>
    <header>
        <div class="logo">Medical centero</div>
        <nav>
            <ul>
                <li><a href="1Index.aspx">Home</a></li>
                <li><a href="#about">About Us</a></li>
                <li><a href="#services">Services</a></li>
                <li><a href="#contact">Contact</a></li>
                <li><a href="2Login.aspx" class="login-btn">Login</a></li> 
            </ul>
        </nav>
    </header>

    <main>
        <section class="hero">
            <div class="hero-content">
                <h1>Welcome to the Medical Center</h1>
                <p>We are committed to providing you with quality medical care.</p>
                <a href="#services" class="btn">Learn More</a>
            </div>
        </section>

        <section id="about">
            <h2>About Us</h2>
            <p>The Medical Center is an institution dedicated to the health and well-being of patients. We offer a wide range of 
                medical services, with top-quality equipment and a professional team.</p>
            </section>

        <section id="services">
            <h2>The Services We Offer</h2>
            <ul>
                <li>General Medicine</li>
                <li>Pediatric Services</li>
                <li>Cardiology</li>
                <li>Medical Exams and Health Assessments</li>
            </ul>
        </section>

        <section id="contact">
            <<h2>Contact Us</h2>
            <p>Phone: 123-456-7890</p>
            <p>Email: contact@medicalcenter.com</p>
            <p>Address: Medical Center Street No. 100</p>
        </section>
    </main>

    <footer>
        <p>© 2024 Medical Center - All Rights Reserved</p>
    </footer>
</body>
</html>
