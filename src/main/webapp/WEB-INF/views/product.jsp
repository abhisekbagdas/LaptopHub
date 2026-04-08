<%--
  Created by IntelliJ IDEA.
  User: Abhisek
  Date: 4/7/2026
  Time: 1:00 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Product</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/main.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/header.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/footer.css" />
</head>
<body>
<header>
    <div class="Logo">
        <h1>LaptopHub</h1>
    </div>
    <nav class="navbar">
        <ul>
            <li><a href="${pageContext.request.contextPath}/home">Home</a></li>
            <li><a href="${pageContext.request.contextPath}/products">Product</a></li>
            <li><a href="${pageContext.request.contextPath}/login">Login</a></li>
            <li><a href="${pageContext.request.contextPath}/register">Register</a></li>
        </ul>
    </nav>
</header>
<div class="hero">
    <h1>Product</h1>
</div>
<%--FOOTER SECTION--%>
<footer>
    <div class="footer-container">
        <div class="footer-content">
            <h3>Contact Us</h3>
            <p>Email:Info@laptophub.com</p> <%--Dummy mail--%>
            <p>Phone:+977 9876543210</p> <%--Dummy Number--%>
            <p>Address: Pokhara-12, Matepani</p>
        </div>
        <div class="footer-content">
            <h3>Quick Links</h3>
            <ul class="quick-link-list">
                <li><a href="${pageContext.request.contextPath}/home">Home</a></li>
                <li><a href="${pageContext.request.contextPath}/products">Products</a></li>
                <li><a href="${pageContext.request.contextPath}/cart">Cart</a></li>
                <li><a href="${pageContext.request.contextPath}/faqs">FAQs</a></li>
                <li><a href="${pageContext.request.contextPath}/contact">Contact</a></li>
                <li><a href="${pageContext.request.contextPath}/About">About</a></li>
            </ul>
        </div>
        <div class="footer-content">
            <h3>Follow Us</h3>
            <ul class="social-handles">
                <li><a href="youtube.com">YouTube</a></li>
                <li><a href="facebook.com">Facebook</a></li>
                <li><a href="instagram.com">Instagram</a></li>
                <li><a href="tiktok.com">Tiktok</a></li>
            </ul>
        </div>
    </div>
    <div class="bottom-bar">
        <p>&copy; 2023 LaptopHub . All rights reserved</p>
    </div>
</footer>
</body>
</html>
