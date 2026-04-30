<%--
  Created by IntelliJ IDEA.
  User: Abhisek
  Date: 4/7/2026
  Time: 1:03 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Login</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/main.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/login.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>

<body>
<%@ include file="/WEB-INF/views/includes/navbar.jsp" %>

<main>
    <div class="login-container">
        <div class="login-card">
            <h2>Welcome Back!!</h2>
            <form action="${pageContext.request.contextPath}/login" method="post">
                <c:if test="${not empty error}">
                    <p class="error"><c:out value="${error}"/></p><br>
                </c:if>

                <div class="form-group">
                    <label for="username">Username: </label>
                    <input type="text" id="username" name="username" placeholder="username OR mail@example.com"
                           value="<c:out value='${param.username}' default='${cookie.username.value}' />" required />

                    <label for="password">Password: </label>
                    <input type="password" id="password" name="password" placeholder="********" required>
                </div>

                <div class="form-group checkbox-group">
                    <label class="checkbox-label">
                        <input type="checkbox" name="remember">
                        <span>Remember me</span>
                    </label>
                    <a href="#" class="forgot-link">Forgot Password?</a>
                </div>

                <button type="submit" class="btn-login">Login</button>
                <div class="auth-links">
                    <p>Don't have an account? <a href="${pageContext.request.contextPath}/register">Register Now</a></p>
                </div>
                <hr>

                <div class="social-buttons">
                    <button class="social-btn" id="google" onclick="alert('Google Login Coming Soon!')">
                        <i class="fab fa-google"></i> Google
                    </button>
                    <button class="social-btn" id="fb" onclick="alert('Facebook Login Coming Soon!')">
                        <i class="fab fa-facebook"></i> Facebook
                    </button>
                </div>
            </form>
        </div>

    </div>
</main>
<%@ include file="/WEB-INF/views/includes/footer.jsp" %>
</body>
</html>
