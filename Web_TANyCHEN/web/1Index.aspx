<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="1Index.aspx.cs" Inherits="Web_TANyCHEN.WebForm1" %>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Centro medico</title>
    <link rel="stylesheet" href="inicio.css">
</head>
<body>
    <header>
        <div class="logo">Centro medico</div>
        <nav>
            <ul>
                <li><a href="1Index.aspx">Inicio</a></li>
                <li><a href="#about">Sobre Nosotros</a></li>
                <li><a href="#services">Servicio</a></li>
                <li><a href="#contact">Contacto</a></li>
                <li><a href="2Login.aspx" class="login-btn">Login</a></li> 
            </ul>
        </nav>
    </header>

    <main>
        <section class="hero">
            <div class="hero-content">
                <h1>Bienvenido al Centro Médico</h1>
                <p>Estamos comprometidos a brindarle atención médica de calidad.</p>
                <a href="#services" class="btn">Obtenga más información</a>
            </div>
        </section>

        <section id="about">
            <h2>Sobre Nosotros</h2>
            <p>El Centro Médico es una institución dedicada a la salud y el bienestar de los pacientes.Ofrecemos una amplia variedad de 
                servicios médicos, contamos con equipos de primera calidad y un equipo profesional.</p>
        </section>

        <section id="services">
            <h2>Los servicios que ofrecemos</h2>
            <ul>
                <li>Medicina general</li>
                <li>Servicios pediátricos</li>
                <li>Cardiología</li>
                <li>Exámenes médicos y evaluaciones de salud</li>
            </ul>
        </section>

        <section id="contact">
            <h2>Contáctenos</h2>
            <p>Teléfono: 123-456-7890</p>
            <p>Correo electrónico: contact@medicalcenter.com</p>
            <p>Dirección: Calle del Centro Médico N° 100</p>
        </section>
    </main>

    <footer>
        <p>© 2024 Centro Médico - Todos los derechos reservados</p>
    </footer>
</body>
</html>
