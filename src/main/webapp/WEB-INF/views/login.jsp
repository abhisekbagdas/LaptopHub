<%--
  Created by IntelliJ IDEA.
  User: Abhisek
  Date: 4/7/2026
  Time: 1:03 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/main.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .login-container{
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 80vh;
            padding: 20px;
        }

        .login-card{
            background: white;
            border-radius: 35px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.1);
            padding: 40px;
            width: 100%;
            max-width: 450px;
            transition: transform 0.3s ease;
        }
        .login-card:hover{
            transform: translateY(-5px);
        }
        .login-card h2{ /*for the login text*/
            text-align: center;
            margin-bottom: 30px;
            color: #333;
            font-size: 28px;
        }

        .form-group{
            margin-bottom: 20px; /*Increases the margin from button on everything inside form-group*/
        }
        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            color: #555;
        }
        .form-group input {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 16px;
        }
        .form-group input:focus {
            border-color: #ff9800;
        }
        .btn-login{
            width: 100%;
            padding: 12px;
            background-color: #ff9800;
            border-radius: 20px;
            color: white;
            border: none;
            cursor: pointer;
            font-size: 15px;
        }
        .btn-login:hover{
            transform: translateY(-6px);
            transition: transform 0.3s ease-out;
            background-color:  #f57c00;
            color: #061E29;
            box-shadow: 0 10px 40px rgba(0,0,0,0.1);
        }
        .checkbox-group {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin: 20px 0;
            cursor: pointer;
        }



        .checkbox-label input {
            width: auto;
            margin: 0;
            cursor: pointer;
        }

        .forgot-link {
            color: #ff9800;
            text-decoration: none;
        }
        .auth-links {
            text-align: center;
            margin-top: 20px;
            padding: 10px;
        }

        .auth-links a {
            color: #ff9800;
            text-decoration: none;
        }

        .auth-links a:hover {
            text-decoration: underline;
        }

        .checkbox-group {
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        .social-login{
            margin: 30px;
            text-align: center;
        }

        .social-buttons{
            display: flex;
            justify-content: center;
            gap: 35px;
        }
        .social-btn {
            padding: 10px 20px;
            border: 1px solid #ddd;
            border-radius: 8px;
            background: white;
            cursor: pointer;
            transition: all 0.3s ease;
            font-size: 14px;
        }
        #fb:hover{
            background-color: #2b64e3;
            color: white;
        }
        #google:hover{
            background-color: #F8F9FA;
        }
    </style>
</head>

<body>
<%@ include file="/WEB-INF/views/includes/navbar.jsp" %>

<main>
    <div class="login-container">
        <div class="login-card">
            <h2>Welcome Back!!</h2>
            <form action="${pageContext.request.contextPath}/login" method="post">
                    <div class="form-group">
                    <label for="email">Email: </label>
                    <input type="email" id="email" name="email" placeholder="RahulGandu@gmail.com" required>
                </div>

                <div class="form-group">
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
    </div>
</main>
<%@ include file="/WEB-INF/views/includes/footer.jsp" %>
</body>
</html>
