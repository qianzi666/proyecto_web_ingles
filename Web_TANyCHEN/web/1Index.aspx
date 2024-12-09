<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="1Index.aspx.cs" Inherits="Web_TANyCHEN.WebForm1" %>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>医疗中心</title>
    <link rel="stylesheet" href="inicio.css">
</head>
<body>
    <header>
        <div class="logo">医疗中心</div>
        <nav>
            <ul>
                <li><a href="1Index.aspx">主页</a></li>
                <li><a href="#about">关于我们</a></li>
                <li><a href="#services">服务</a></li>
                <li><a href="#contact">联系我们</a></li>
                <li><a href="2Login.aspx" class="login-btn">登录</a></li> 
            </ul>
        </nav>
    </header>

    <main>
        <section class="hero">
            <div class="hero-content">
                <h1>欢迎来到医疗中心</h1>
                <p>我们致力于为您提供优质的医疗服务。</p>
                <a href="#services" class="btn">了解更多</a>
            </div>
        </section>

        <section id="about">
            <h2>关于我们</h2>
            <p>医疗中心是一家致力于病人健康与幸福的机构。我们提供多种医疗服务，拥有一流的设备和专业的团队。</p>
        </section>

        <section id="services">
            <h2>我们的服务</h2>
            <ul>
                <li>全科医疗</li>
                <li>儿科服务</li>
                <li>心脏病学</li>
                <li>体检与健康评估</li>
            </ul>
        </section>

        <section id="contact">
            <h2>联系我们</h2>
            <p>电话: 123-456-7890</p>
            <p>邮箱: contact@medicalcenter.com</p>
            <p>地址: 医疗中心街道 100 号</p>
        </section>
    </main>

    <footer>
        <p>© 2024 医疗中心 - 保留所有权利</p>
    </footer>
</body>
</html>
