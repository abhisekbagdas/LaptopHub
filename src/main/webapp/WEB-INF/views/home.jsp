<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--<%@ taglib uri="jakarta.tags.core" prefix="c" %>--%>
<html>
<head>
<%--    <meta charset="UTF-8" />--%>
<%--    <meta name="viewport" content="width=device-width, initial-scale=1.0" />--%>
    <title>LaptopHub — Best Laptops in Nepal</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/main.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/home.css" />
</head>
<body>

<!-- ===================================================
     TOP BAR
     =================================================== -->
<%--<div class="topbar">--%>
<%--    <div class="topbar-left">--%>
<%--        <a href="about.jsp">About us</a>--%>
<%--        <a href="faq.jsp">FAQ</a>--%>
<%--        <a href="privacy.jsp">Privacy policy</a>--%>
<%--    </div>--%>
<%--    <div class="topbar-right">--%>
<%--        <a href="warranty.jsp">Warranty</a>--%>
<%--        <a href="pickup.jsp">Pickup location</a>--%>
<%--        <a href="tel:+97798011000037">Customer service: +977-9801100037</a>--%>
<%--    </div>--%>
<%--</div>--%>

<!-- ===================================================
     NAVBAR
     =================================================== -->
<%@ include file="/WEB-INF/views/includes/navbar.jsp" %>
<%--<nav class="navbar">--%>
<%--    <a href="index.jsp" class="logo">laptop<span>hub</span></a>--%>

<%--    <form class="search-bar" action="search.jsp" method="GET">--%>
<%--        <input type="text" name="q" placeholder="Search for laptops, brands, accessories..." />--%>
<%--        <button type="submit">Search</button>--%>
<%--    </form>--%>

<%--    <div class="nav-links">--%>
<%--        <c:choose>--%>
<%--            <c:when test="${not empty sessionScope.user}">--%>
<%--&lt;%&ndash;                <a href="account.jsp">My account (${sessionScope.user.name})</a>&ndash;%&gt;--%>
<%--                <a href="logout.jsp">Logout</a>--%>
<%--            </c:when>--%>
<%--            <c:otherwise>--%>
<%--                <a href="login.jsp">My account</a>--%>
<%--            </c:otherwise>--%>
<%--        </c:choose>--%>
<%--        <a href="${pageContext.request.contextPath}/cart">--%>
<%--            <button class="cart-btn">&#128722; My cart--%>

<%--                <c:if test="${not empty sessionScope.cartCount}">--%>
<%--                    (${sessionScope.cartCount})--%>
<%--                </c:if>--%>
<%--            </button>--%>
<%--        </a>--%>
<%--    </div>--%>
<%--</nav>--%>

<!-- ===================================================
     CATEGORY NAV
     =================================================== -->
<div class="categories">
    <a href="${pageContext.request.contextPath}/index.jsp"><div class="cat-item active">All categories</div></a>
    <a href="${pageContext.request.contextPath}/category.jsp?type=gaming"><div class="cat-item">Gaming laptops</div></a>
    <a href="${pageContext.request.contextPath}/category.jsp?type=business"><div class="cat-item">Business laptops</div></a>
    <a href="${pageContext.request.contextPath}/category.jsp?type=ultrabook"><div class="cat-item">Ultrabooks</div></a>
    <a href="${pageContext.request.contextPath}/category.jsp?type=workstation"><div class="cat-item">Workstations</div></a>
    <a href="${pageContext.request.contextPath}/category.jsp?type=accessories"><div class="cat-item">Accessories</div></a>
    <a href="${pageContext.request.contextPath}/pc-build.jsp"><div class="cat-item">PC build</div></a>
</div>

<style>
/* Scoped styles for the hero slider to ensure it overrides defaults */
.hero-slider {
    position: relative;
    width: 100%;
    margin: 24px 0;
    overflow: hidden;
    border-radius: 12px;
    background-color: #0d1b4b; /* Placeholder background */
    min-height: 400px;
    display: flex;
    align-items: center;
}

.slides {
    display: flex;
    transition: transform 0.5s ease-in-out;
    width: 100%;
    height: 100%;
}

.slide {
    min-width: 100%;
    flex-shrink: 0;
    box-sizing: border-box;
    display: flex;
    justify-content: center;
    align-items: center;
    padding: 20px;
}

.slide img {
    width: 100%;
    height: 100%;
    object-fit: contain;
    max-height: 400px;
    border-radius: 8px;
}

.slider-controls {
    position: absolute;
    bottom: 15px;
    left: 50%;
    transform: translateX(-50%);
    display: flex;
    gap: 8px;
}

.dot {
    height: 10px;
    width: 10px;
    margin: 0;
    background-color: rgba(255, 255, 255, 0.5);
    border-radius: 50%;
    display: inline-block;
    cursor: pointer;
    transition: background-color 0.3s ease;
}

.dot.active, .dot:hover {
    background-color: #fff;
}
</style>

<section class="hero-slider">
    <div class="slides" id="hero-slides">
        <div class="slide">
            <img src="${pageContext.request.contextPath}/static/images/hero1.jpeg" alt="Hero 1">
        </div>
        <div class="slide">
            <img src="${pageContext.request.contextPath}/static/images/hero2.jpeg" alt="Hero 2">
        </div>
        <div class="slide">
            <img src="${pageContext.request.contextPath}/static/images/hero3.jpeg" alt="Hero 3">
        </div>
        <div class="slide">
            <img src="${pageContext.request.contextPath}/static/images/hero4.jpeg" alt="Hero 4">
        </div>
        <div class="slide">
            <img src="${pageContext.request.contextPath}/static/images/hero5.jpeg" alt="Hero 5">
        </div>
    </div>
    
    <div class="slider-controls" id="slider-dots">
        <span class="dot active" onclick="currentSlide(0)"></span>
        <span class="dot" onclick="currentSlide(1)"></span>
        <span class="dot" onclick="currentSlide(2)"></span>
        <span class="dot" onclick="currentSlide(3)"></span>
        <span class="dot" onclick="currentSlide(4)"></span>
    </div>
</section>

<script>
    let slideIndex = 0;
    const slides = document.getElementById('hero-slides');
    const dots = document.getElementById('slider-dots').getElementsByClassName('dot');
    let slideInterval;

    function showSlide(index) {
        if (index >= dots.length) { slideIndex = 0; }
        if (index < 0) { slideIndex = dots.length - 1; }
        
        // Avoid ES6 template literals here because JSP parses the dollar sign and curly braces as EL on the server
        slides.style.transform = 'translateX(-' + (slideIndex * 100) + '%)';
        
        for (let i = 0; i < dots.length; i++) {
            dots[i].className = dots[i].className.replace(" active", "");
        }
        if (dots[slideIndex]) {
            dots[slideIndex].className += " active";
        }
    }

    function currentSlide(index) {
        slideIndex = index;
        showSlide(slideIndex);
        resetInterval();
    }

    function autoSlide() {
        slideIndex++;
        showSlide(slideIndex);
    }

    function resetInterval() {
        clearInterval(slideInterval);
        slideInterval = setInterval(autoSlide, 5000);
    }

    // Start auto slide
    slideInterval = setInterval(autoSlide, 5000);
</script>

<!-- ===================================================
     BRAND FILTER
     =================================================== -->
<div class="section">
    <div class="section-header">
        <span class="brand-tag">Popular brands</span>
    </div>
    <div class="brands">
        <a href="${pageContext.request.contextPath}/brand?name=apple"><div class="brand-chip">Apple</div></a>
        <a href="${pageContext.request.contextPath}/brand?name=asus"><div class="brand-chip">ASUS ROG</div></a>
        <a href="${pageContext.request.contextPath}/brand?name=lenovo"><div class="brand-chip">Lenovo</div></a>
        <a href="${pageContext.request.contextPath}/brand?name=dell"><div class="brand-chip">Dell XPS</div></a>
        <a href="${pageContext.request.contextPath}/brand?name=hp"><div class="brand-chip">HP Spectre</div></a>
        <a href="${pageContext.request.contextPath}/brand?name=msi"><div class="brand-chip">MSI</div></a>
        <a href="${pageContext.request.contextPath}/brand?name=acer"><div class="brand-chip">Acer</div></a>
    </div>
</div>

<!-- ===================================================
     FEATURED LAPTOPS
     Driven by a List<Product> set in request scope by
     HomeServlet: request.setAttribute("featuredProducts", list)
     =================================================== -->
<div class="section">
    <div class="section-header">
        <h2>Featured laptops</h2>
        <a href="${pageContext.request.contextPath}/products.jsp?type=featured">View all &rarr;</a>
    </div>

<%--    <div class="products-grid">--%>

<%--        &lt;%&ndash; Dynamic products from servlet/DB &ndash;%&gt;--%>
<%--        <c:choose>--%>
<%--            <c:when test="${not empty requestScope.featuredProducts}">--%>
<%--                <c:forEach var="product" items="${requestScope.featuredProducts}">--%>
<%--                    <div class="product-card">--%>
<%--                        <div class="product-img">--%>
<%--                            <img src="${product.imageUrl}" alt="${product.name}"--%>
<%--                                 style="max-height:120px; object-fit:contain;" />--%>
<%--                        </div>--%>
<%--                        <c:if test="${product.discountPercent > 0}">--%>
<%--                            <span class="badge badge-off">${product.discountPercent}% OFF</span>--%>
<%--                        </c:if>--%>
<%--                        <c:if test="${product.isNew}">--%>
<%--                            <span class="badge badge-new">New</span>--%>
<%--                        </c:if>--%>
<%--                        <div class="product-name">${product.name}</div>--%>
<%--                        <div class="product-spec">${product.shortSpec}</div>--%>
<%--                        <div>--%>
<%--                            <span class="product-price">Rs. ${product.price}</span>--%>
<%--                            <c:if test="${product.originalPrice > product.price}">--%>
<%--                                <span class="product-old">Rs. ${product.originalPrice}</span>--%>
<%--                            </c:if>--%>
<%--                        </div>--%>
<%--                        <form action="${pageContext.request.contextPath}/cart" method="POST">--%>
<%--                            <input type="hidden" name="productId" value="${product.id}" />--%>
<%--                            <button type="submit" class="add-btn">Add to cart</button>--%>
<%--                        </form>--%>
<%--                    </div>--%>
<%--                </c:forEach>--%>
<%--            </c:when>--%>


<%--        </c:choose>--%>

<%--    </div>--%>

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
</div>

<!-- ===================================================
     GAMING LAPTOPS
     =================================================== -->
<div class="section">
    <div class="section-header">
        <h2>Gaming laptops</h2>
        <a href="${pageContext.request.contextPath}/category.jsp?type=gaming">View all &rarr;</a>
    </div>

    <div class="products-grid">

<%--        <c:choose>--%>
<%--            <c:when test="${not empty requestScope.gamingProducts}">--%>
<%--                <c:forEach var="product" items="${requestScope.gamingProducts}">--%>
<%--                    <div class="product-card">--%>
<%--                        <div class="product-img">--%>
<%--                            <img src="${product.imageUrl}" alt="${product.name}"--%>
<%--                                 style="max-height:120px; object-fit:contain;" />--%>
<%--                        </div>--%>
<%--                        <c:if test="${product.discountPercent > 0}">--%>
<%--                            <span class="badge badge-off">${product.discountPercent}% OFF</span>--%>
<%--                        </c:if>--%>
<%--                        <c:if test="${product.isNew}">--%>
<%--                            <span class="badge badge-new">New</span>--%>
<%--                        </c:if>--%>
<%--                        <div class="product-name">${product.name}</div>--%>
<%--                        <div class="product-spec">${product.shortSpec}</div>--%>
<%--                        <div>--%>
<%--                            <span class="product-price">Rs. ${product.price}</span>--%>
<%--                            <c:if test="${product.originalPrice > product.price}">--%>
<%--                                <span class="product-old">Rs. ${product.originalPrice}</span>--%>
<%--                            </c:if>--%>
<%--                        </div>--%>
<%--                        <form action="${pageContext.request.contextPath}/cart" method="POST">--%>
<%--                            <input type="hidden" name="productId" value="${product.id}" />--%>
<%--                            <button type="submit" class="add-btn">Add to cart</button>--%>
<%--                        </form>--%>
<%--                    </div>--%>
<%--                </c:forEach>--%>
<%--            </c:when>--%>


<%--        </c:choose>--%>


    </div>
</div>

<!-- ===================================================
     FOOTER
     =================================================== -->

<%@ include file="/WEB-INF/views/includes/footer.jsp" %>
</body>
</html>
