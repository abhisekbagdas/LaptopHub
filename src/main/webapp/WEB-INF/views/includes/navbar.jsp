<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/main.css">
<header>

    <nav class="navbar">
        <div class="Logo">
            <h1>LaptopHub</h1>
        </div>
        <ul>
            <li><a href="${pageContext.request.contextPath}/home">Home</a></li>
            <li><a href="${pageContext.request.contextPath}/products">Product</a></li>
            <li><a href="${pageContext.request.contextPath}/cart">Cart</a></li>
            <li><a href="${pageContext.request.contextPath}/contact">Contact</a></li>
            <li class="login-icon">
                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <a href="${pageContext.request.contextPath}/profile">
                            <i class="fas fa-user-circle"></i> Profile
                        </a>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/login">
                            <i class="fas fa-user-circle"></i> Login
                        </a>
                    </c:otherwise>
                </c:choose>
            </li>
            <li>
                <div class="usersession">
                    <h3>
                        <c:if test="${not empty sessionScope.user}">

                        </c:if>
                        <c:out value="${sessionScope.user.username}" /></h3>
                    <c:if test="${not empty sessionScope.user}">
                        <a href="${pageContext.request.contextPath}/logout" class="logout"
                           onclick="return confirm('Are you sure you want to logout?');">Logout</a>
                    </c:if>
                </div>
            </li>
        </ul>
    </nav>
</header>
