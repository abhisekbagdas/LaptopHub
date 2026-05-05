<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>

<head>
    <title>Product</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/main.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/products.css"/>
</head>

<body>
<div id="productNav">
    <%@ include file="/WEB-INF/views/includes/navbar.jsp" %>
</div>
<div class="main-container">
    <div class="productHeading">Our Products</div>
    <c:choose>
        <c:when test="${empty products}">
            <p>No products found</p>
        </c:when>
        <c:otherwise>
            <div class="product-section">
                <h2 class="section-title">Office Laptops</h2>
                <div class="product-grid">
                    <c:forEach var="productItem" items="${products}">
                        <div class="product-card">
                            <div class="image-placeholder"></div>
                            <div class="product-details">
                                <h3>${productItem.name}</h3>
                                <p class="product-price">${productItem.price}</p>
                                <div class="product-rating">&#9733;&#9733;&#9733;&#9733;&#9733;</div>
                                    <%-- Start --%>
                                <button class="add-to-cart-btn">Add to Cart</button>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </c:otherwise>
    </c:choose>
</div>
<%@ include file="/WEB-INF/views/includes/footer.jsp" %>
</body>

</html>