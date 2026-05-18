<%--<%@ page contentType="text/html;charset=UTF-8" language="java" %>--%>
<%--<%@ taglib prefix="c" uri="jakarta.tags.core" %>--%>
<html>
<!-- check -->
<head>
    <title>Product</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/main.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/products.css"/>
</head>

<body>
<%--<div class="custom-header">--%>
<%--    <div class="logo">TECHSPEC</div>--%>
<%--    <div class="nav-links">--%>
<%--        <a href="#" class="active">Laptops</a>--%>
<%--        <a href="#">Workstations</a>--%>
<%--        <a href="#">Accessories</a>--%>
<%--        <a href="#">Support</a>--%>
<%--    </div>--%>
<%--    <div class="nav-icons">--%>
<%--        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>--%>
<%--        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="9" cy="21" r="1"></circle><circle cx="20" cy="21" r="1"></circle><path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"></path></svg>--%>
<%--    </div>--%>
<%--</div>--%>

<%@ include file="/WEB-INF/views/includes/navbar.jsp" %>
<div class="product-page-container">
    <!-- Hero Section -->
    <div class="hero-section">
        <div class="hero-content">
            <h1>Engineered for<br>Excellence.</h1>
            <p>Discover the next generation of professional hardware designed for creators and engineers.</p>
        </div>
    </div>

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
                                <span class="product-price">RS. ${productItem.price}</span>
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
<%--<footer class="custom-footer">--%>
<%--    <div class="footer-grid">--%>
<%--        <div class="footer-brand">--%>
<%--            <h3>TECHSPEC</h3>--%>
<%--            <p>Precision engineered hardware for the modern professional. Performance without compromise.</p>--%>
<%--        </div>--%>
<%--        <div class="footer-links">--%>
<%--            <h4>Product</h4>--%>
<%--            <a href="#">Laptops</a>--%>
<%--            <a href="#">Workstations</a>--%>
<%--            <a href="#">Accessories</a>--%>
<%--        </div>--%>
<%--        <div class="footer-links">--%>
<%--            <h4>Support</h4>--%>
<%--            <a href="#">Support</a>--%>
<%--            <a href="#">Warranty</a>--%>
<%--            <a href="#">Contact</a>--%>
<%--        </div>--%>
<%--        <div class="footer-links">--%>
<%--            <h4>Legal</h4>--%>
<%--            <a href="#">Privacy Policy</a>--%>
<%--            <a href="#">Terms of Service</a>--%>
<%--        </div>--%>
<%--    </div>--%>
<%--    <div class="footer-bottom">--%>
<%--        <p>&copy; 2024 TECHSPEC Engineering. All rights reserved.</p>--%>
<%--        <div class="social-icons">--%>
<%--            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"></circle><path d="M8 14s1.5 2 4 2 4-2 4-2"></path><line x1="9" y1="9" x2="9.01" y2="9"></line><line x1="15" y1="9" x2="15.01" y2="9"></line></svg>--%>
<%--            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M18 2h-3a5 5 0 0 0-5 5v3H7v4h3v8h4v-8h3l1-4h-4V7a1 1 0 0 1 1-1h3z"></path></svg>--%>
<%--            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M23 3a10.9 10.9 0 0 1-3.14 1.53 4.48 4.48 0 0 0-7.86 3v1A10.66 10.66 0 0 1 3 4s-4 9 5 13a11.64 11.64 0 0 1-7 2c9 5 20 0 20-11.5a4.5 4.5 0 0 0-.08-.83A7.72 7.72 0 0 0 23 3z"></path></svg>--%>
<%--        </div>--%>
<%--    </div>--%>
<%--</footer>--%>
<%@ include file="/WEB-INF/views/includes/footer.jsp" %>
</body>

</html>
