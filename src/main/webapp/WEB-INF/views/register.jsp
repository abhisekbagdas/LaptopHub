<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>Register - LaptopHub</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/main.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/register.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>

<main>
    <div class="auth-container">
        <div class="auth-card">
            <h2>Create Account</h2>
            <div class="subtitle">Join LaptopHub today!</div>

            <form id="registerForm" action="${pageContext.request.contextPath}/register" method="post">
                    <c:if test="${not empty error}">
                        <p class="error"><c:out value="${error}" /></p>
                    </c:if>
                <div class="name-group">
                    <div class="form-group">
                        <label for="username">Username *</label>
                        <input type="text" id="username" name="username" placeholder="username"
                               value="<c:out value='${param.username}' default='' />" required />
                    </div>
                </div>

                <div class="form-group">
                    <label for="email">Email Address *</label>
                    <input type="email" id="email" name="email" placeholder="mail@example.com"
                           value="<c:out value='${param.email}' default='' />" required>
                    <div id="emailError" class="error-message"></div>
                </div>

                <div class="form-group">
                    <label for="password">Password *</label>
                    <input type="password" id=
                            "password" name="password" placeholder="Create strong password" required>
                    <div class="password-requirements" id="passwordReq">
                         Min 8 characters  At least 1 number  1 uppercase letter
                    </div>
                    <div id="passwordError" class="error-message"></div>
                </div>

                <div class="form-group">
                    <label for="confirmPassword">Confirm Password *</label>
                    <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Confirm your password" required>
                    <div id="confirmError" class="error-message"></div>
                </div>



                <div class="checkbox-group">
                    <label class="checkbox-label">
                        <input type="checkbox" id="terms" name="terms" required>
                        <span>I agree to the <a href="#">Terms & Conditions</a> and <a href="#">Privacy Policy</a></span>
                    </label>
                </div>

                <button type="submit" class="btn-register">Create Account</button>

                <div class="auth-links">
                    <p>Already have an account? <a href="${pageContext.request.contextPath}/login">Login here</a></p>
                </div>
            </form>
        </div>
    </div>
</main>

<%@ include file="/WEB-INF/views/includes/footer.jsp" %>

</body>
</html>