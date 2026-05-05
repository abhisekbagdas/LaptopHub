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
    <a href="index.jsp"><div class="cat-item active">All categories</div></a>
    <a href="category.jsp?type=gaming"><div class="cat-item">Gaming laptops</div></a>
    <a href="category.jsp?type=business"><div class="cat-item">Business laptops</div></a>
    <a href="category.jsp?type=ultrabook"><div class="cat-item">Ultrabooks</div></a>
    <a href="category.jsp?type=workstation"><div class="cat-item">Workstations</div></a>
    <a href="category.jsp?type=accessories"><div class="cat-item">Accessories</div></a>
    <a href="pc-build.jsp"><div class="cat-item">PC build</div></a>
</div>

<!-- ===================================================
     HERO SECTION
     =================================================== -->
<section class="hero">

    <!-- Main hero banner (can be driven by a DB featured product) -->
    <div class="hero-main">
        <div class="hero-tag">New arrival 2024</div>
        <h1>ASUS ROG Zephyrus<br><span>16&quot; WQXGA OLED</span></h1>
        <p>RTX 4080 &middot; AMD Ryzen 9 &middot; 32GB RAM</p>
        <div class="hero-price">
            Rs. 3,49,999
            <small>
            <del>Rs. 3,99,999</del>
            </small>
        </div>
        <a href="product.jsp?id=1"><button class="btn-white">Shop now</button></a>
    </div>

    <!-- Side cards -->
    <div class="hero-side">
        <div class="hero-card card1">
            <h3>Lenovo ThinkPad X1 Carbon</h3>
            <p>Intel Core Ultra 7 &middot; 16GB &middot; 512GB SSD</p>
            <div class="hero-card-footer">
                <span class="price">Rs. 1,89,999</span>
                <a href="product.jsp?id=2" class="view-link">View &rarr;</a>
            </div>
        </div>
        <div class="hero-card card2">
            <h3>MacBook Air M3 &mdash; 15&quot;</h3>
            <p>Apple M3 chip &middot; 8GB &middot; 256GB &middot; 18hr battery</p>
            <div class="hero-card-footer">
                <span class="price"><del>Rs. 1,54,990</del></span>
                <a href="product.jsp?id=3" class="view-link">View &rarr;</a>
            </div>
        </div>
    </div>

</section>

<!-- ===================================================
     BRAND FILTER
     =================================================== -->
<div class="section">
    <div class="section-header">
        <span class="brand-tag">Popular brands</span>
    </div>
    <div class="brands">
        <a href="brand.jsp?name=apple"><div class="brand-chip">Apple</div></a>
        <a href="brand.jsp?name=asus"><div class="brand-chip">ASUS ROG</div></a>
        <a href="brand.jsp?name=lenovo"><div class="brand-chip">Lenovo</div></a>
        <a href="brand.jsp?name=dell"><div class="brand-chip">Dell XPS</div></a>
        <a href="brand.jsp?name=hp"><div class="brand-chip">HP Spectre</div></a>
        <a href="brand.jsp?name=msi"><div class="brand-chip">MSI</div></a>
        <a href="brand.jsp?name=acer"><div class="brand-chip">Acer</div></a>
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
        <a href="products.jsp?type=featured">View all &rarr;</a>
    </div>

    <div class="products-grid">

        <%-- Dynamic products from servlet/DB --%>
        <c:choose>
            <c:when test="${not empty requestScope.featuredProducts}">
                <c:forEach var="product" items="${requestScope.featuredProducts}">
                    <div class="product-card">
                        <div class="product-img">
                            <img src="${product.imageUrl}" alt="${product.name}"
                                 style="max-height:120px; object-fit:contain;" />
                        </div>
                        <c:if test="${product.discountPercent > 0}">
                            <span class="badge badge-off">${product.discountPercent}% OFF</span>
                        </c:if>
                        <c:if test="${product.isNew}">
                            <span class="badge badge-new">New</span>
                        </c:if>
                        <div class="product-name">${product.name}</div>
                        <div class="product-spec">${product.shortSpec}</div>
                        <div>
                            <span class="product-price">Rs. ${product.price}</span>
                            <c:if test="${product.originalPrice > product.price}">
                                <span class="product-old">Rs. ${product.originalPrice}</span>
                            </c:if>
                        </div>
                        <form action="cart.jsp" method="POST">
                            <input type="hidden" name="productId" value="${product.id}" />
                            <button type="submit" class="add-btn">Add to cart</button>
                        </form>
                    </div>
                </c:forEach>
            </c:when>

            <%-- Static fallback cards shown when no DB data is available --%>
            <c:otherwise>
                <div class="product-card">
                    <div class="product-img">&#128187;</div>
                    <span class="badge badge-off">17% OFF</span>
                    <div class="product-name">Lenovo LOQ 15 2024</div>
                    <div class="product-spec">Intel 13th Gen &middot; RTX 4050 &middot; 16GB RAM</div>
                    <div>
                        <span class="product-price">Rs. 1,33,999</span>
                        <span class="product-old">Rs. 1,59,900</span>
                    </div>
                    <a href="product.jsp?id=4"><button class="add-btn">Add to cart</button></a>
                </div>

                <div class="product-card">
                    <div class="product-img">&#128187;</div>
                    <span class="badge badge-new">New</span>
                    <div class="product-name">ASUS Vivobook 16X</div>
                    <div class="product-spec">AMD Ryzen 7 &middot; RX 7600S &middot; 16GB RAM</div>
                    <div>
                        <span class="product-price">Rs. 1,09,999</span>
                    </div>
                    <a href="product.jsp?id=5"><button class="add-btn">Add to cart</button></a>
                </div>

                <div class="product-card">
                    <div class="product-img">&#128187;</div>
                    <span class="badge badge-off">12% OFF</span>
                    <div class="product-name">Dell Inspiron 15 3000</div>
                    <div class="product-spec">Intel i5 13th Gen &middot; 8GB &middot; 512GB SSD</div>
                    <div>
                        <span class="product-price">Rs. 79,999</span>
                        <span class="product-old">Rs. 90,000</span>
                    </div>
                    <a href="product.jsp?id=6"><button class="add-btn">Add to cart</button></a>
                </div>

                <div class="product-card">
                    <div class="product-img">&#128187;</div>
                    <span class="badge badge-new">New</span>
                    <div class="product-name">HP Spectre x360 14</div>
                    <div class="product-spec">Intel Core Ultra 5 &middot; 16GB &middot; OLED touch</div>
                    <div>
                        <span class="product-price">Rs. 1,64,990</span>
                    </div>
                    <a href="product.jsp?id=7"><button class="add-btn">Add to cart</button></a>
                </div>
            </c:otherwise>
        </c:choose>

    </div>
</div>

<!-- ===================================================
     GAMING LAPTOPS
     =================================================== -->
<div class="section">
    <div class="section-header">
        <h2>Gaming laptops</h2>
        <a href="category.jsp?type=gaming">View all &rarr;</a>
    </div>

    <div class="products-grid">

        <c:choose>
            <c:when test="${not empty requestScope.gamingProducts}">
                <c:forEach var="product" items="${requestScope.gamingProducts}">
                    <div class="product-card">
                        <div class="product-img">
                            <img src="${product.imageUrl}" alt="${product.name}"
                                 style="max-height:120px; object-fit:contain;" />
                        </div>
                        <c:if test="${product.discountPercent > 0}">
                            <span class="badge badge-off">${product.discountPercent}% OFF</span>
                        </c:if>
                        <c:if test="${product.isNew}">
                            <span class="badge badge-new">New</span>
                        </c:if>
                        <div class="product-name">${product.name}</div>
                        <div class="product-spec">${product.shortSpec}</div>
                        <div>
                            <span class="product-price">Rs. ${product.price}</span>
                            <c:if test="${product.originalPrice > product.price}">
                                <span class="product-old">Rs. ${product.originalPrice}</span>
                            </c:if>
                        </div>
                        <form action="cart.jsp" method="POST">
                            <input type="hidden" name="productId" value="${product.id}" />
                            <button type="submit" class="add-btn">Add to cart</button>
                        </form>
                    </div>
                </c:forEach>
            </c:when>

            <c:otherwise>
                <div class="product-card">
                    <div class="product-img">&#127918;</div>
                    <span class="badge badge-new">New</span>
                    <div class="product-name">MSI Titan GT77 HX</div>
                    <div class="product-spec">Intel i9 &middot; RTX 4090 &middot; 64GB &middot; 4K 144Hz</div>
                    <div><span class="product-price">Rs. 5,49,999</span></div>
                    <a href="product.jsp?id=8"><button class="add-btn">Add to cart</button></a>
                </div>

                <div class="product-card">
                    <div class="product-img">&#127918;</div>
                    <span class="badge badge-off">10% OFF</span>
                    <div class="product-name">ASUS TUF Gaming A15</div>
                    <div class="product-spec">Ryzen 7 &middot; RTX 4060 &middot; 16GB &middot; 144Hz</div>
                    <div>
                        <span class="product-price">Rs. 99,999</span>
                        <span class="product-old">Rs. 1,09,999</span>
                    </div>
                    <a href="product.jsp?id=9"><button class="add-btn">Add to cart</button></a>
                </div>

                <div class="product-card">
                    <div class="product-img">&#127918;</div>
                    <span class="badge badge-new">New</span>
                    <div class="product-name">Acer Predator Helios 16</div>
                    <div class="product-spec">Intel i7 &middot; RTX 4070 &middot; 16GB &middot; 240Hz</div>
                    <div><span class="product-price">Rs. 1,79,999</span></div>
                    <a href="product.jsp?id=10"><button class="add-btn">Add to cart</button></a>
                </div>

                <div class="product-card">
                    <div class="product-img">&#127918;</div>
                    <span class="badge badge-off">8% OFF</span>
                    <div class="product-name">Lenovo Legion 5 Pro</div>
                    <div class="product-spec">Ryzen 7 7745HX &middot; RTX 4070 &middot; 32GB</div>
                    <div>
                        <span class="product-price">Rs. 1,55,000</span>
                        <span class="product-old">Rs. 1,69,000</span>
                    </div>
                    <a href="product.jsp?id=11"><button class="add-btn">Add to cart</button></a>
                </div>
            </c:otherwise>
        </c:choose>

    </div>
</div>

<!-- ===================================================
     FOOTER
     =================================================== -->

<%@ include file="/WEB-INF/views/includes/footer.jsp" %>
</body>
</html>
