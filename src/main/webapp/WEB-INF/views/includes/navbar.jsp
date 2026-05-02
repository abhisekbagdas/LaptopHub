<%--
  Created by IntelliJ IDEA.
  User: SOBIM SHRESTHA
  Date: 4/8/2026
  Time: 9:02 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<header>
    <div class="Logo">
        <h1>LaptopHub</h1>
    </div>
    <nav class="navbar">
        <ul>
            <li><a href="${pageContext.request.contextPath}/home">Home</a></li>
            <li><a href="${pageContext.request.contextPath}/products">Product</a></li>
            <li><a href="${pageContext.request.contextPath}/cart">Cart</a></li>
            <li><a href="${pageContext.request.contextPath}/contact">Contact</a></li>
            <li class="login-icon">
                <a href="${pageContext.request.contextPath}/login">
                    <i class="fas fa-user-circle"></i> Login
                </a>
            </li>
            <li>
                <div class="usersession">
                    <h3>
                        <c:if test="${not empty sessionScope.user}">
                             Welcome,
                        </c:if>
                        <c:out value="${sessionScope.user.username}" /></h3>
                    <a href="${pageContext.request.contextPath}/logout" class="logout"
                       onclick="return confirm('Are you sure you want to logout?');">Logout</a>
                </div>
            </li>
        </ul>
    </nav>
</header>
