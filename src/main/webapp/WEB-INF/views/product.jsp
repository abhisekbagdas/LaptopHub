<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<!-- check -->
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
                            <div class="image-placeholder"><img src="${productItem.image}"></div>
                            <div class="product-details">
                                <h3>${productItem.name}</h3>
                                <p class="product-price">${productItem.price}</p>
                                <div class="product-rating">&#9733;&#9733;&#9733;&#9733;&#9733;</div>
                                <form action="${pageContext.request.contextPath}/cart" method="POST" style="margin-top: 10px;">
                                    <input type="hidden" name="action" value="add" />
                                    <input type="hidden" name="productId" value="${productItem.id}" />
                                    <button type="submit" class="add-to-cart-btn" style="width: 100%;">Add to Cart</button>
                                </form>
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