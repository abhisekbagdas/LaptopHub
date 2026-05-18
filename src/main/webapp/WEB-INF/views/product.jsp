<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--<%@ taglib prefix="c" uri="jakarta.tags.core" %>--%>
<html>
<!-- check -->
<head>
    <title>Product</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/main.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/products.css"/>
</head>

<body>
<%@ include file="/WEB-INF/views/includes/navbar.jsp" %>
<div class="product-page-container">

    <!-- Section Header -->
    <div class="section-header">
        <div class="section-title-wrap">
            <span class="sub-label">Premium Collection</span>
            <h2>Featured Laptops</h2>
        </div>
        <form class="filter-actions" method="GET" action="${pageContext.request.contextPath}/products" style="margin: 0; align-items: center;">
            <input type="text" name="search" placeholder="Search products..." value="${param.search}" style="padding: 8px 12px; border: 1px solid #e0e0e0; border-radius: 6px; font-size: 14px; outline: none;">
            <button type="submit" class="filter-btn">
                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polygon points="22 3 2 3 10 12.46 10 19 14 21 14 12.46 22 3"></polygon></svg>
                Filter
            </button>
            <select name="sort" class="filter-btn" onchange="this.form.submit()" style="appearance: none; cursor: pointer;">
                <option value="">Sort By</option>
                <option value="price_asc" ${param.sort == 'price_asc' ? 'selected' : ''}>Price: Low to High</option>
                <option value="price_desc" ${param.sort == 'price_desc' ? 'selected' : ''}>Price: High to Low</option>
            </select>
        </form>
    </div>

    <c:choose>
        <c:when test="${empty products}">
            <div class="empty-state">
                <p>No products found</p>
            </div>
        </c:when>
        <c:otherwise>
            <div class="product-grid">
                <c:forEach var="productItem" items="${products}">
                    <div class="product-card">
                        <div class="image-container">
                            <img src="${productItem.image}" alt="${productItem.name}">
                        </div>
                        <div class="product-details">
                            <h3 class="product-name">${productItem.name}</h3>
                            <div class="product-price-wrap">
                                <span class="product-price">$${productItem.price}</span>
                            </div>
                            <div class="product-rating" style="color: #f5c518; font-size: 16px; margin-bottom: 16px; letter-spacing: 2px;">
                                &#9733;&#9733;&#9733;&#9733;&#9733; <span style="color: #888; font-size: 12px; letter-spacing: 0;">(5.0)</span>
                            </div>
                            <div class="product-actions">
                                <form action="${pageContext.request.contextPath}/cart" method="POST" style="width: 100%;">
                                    <input type="hidden" name="action" value="add" />
                                    <input type="hidden" name="productId" value="${productItem.id}" />
                                    <button type="submit" class="btn btn-primary" style="width: 100%;">Add to cart</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>

    <!-- Newsletter Section Removed -->
</div>
<%@ include file="/WEB-INF/views/includes/footer.jsp" %>
</body>

</html>
