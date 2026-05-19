<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>LaptopHub — Best Laptops in Nepal</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/main.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/home.css?v=<%= System.currentTimeMillis() %>" />
</head>
<body>

<!-- ===================================================
     NAVBAR
     =================================================== -->
<%@ include file="/WEB-INF/views/includes/navbar.jsp" %>

<!-- ===================================================
     CATEGORY NAV
     =================================================== -->
<%--<div class="categories">--%>
<%--    <a href="${pageContext.request.contextPath}/home"><div class="cat-item active">All categories</div></a>--%>
<%--    <a href="${pageContext.request.contextPath}/category.jsp?type=gaming"><div class="cat-item">Gaming laptops</div></a>--%>
<%--    <a href="${pageContext.request.contextPath}/category.jsp?type=business"><div class="cat-item">Business laptops</div></a>--%>
<%--    <a href="${pageContext.request.contextPath}/category.jsp?type=ultrabook"><div class="cat-item">Ultrabooks</div></a>--%>
<%--    <a href="${pageContext.request.contextPath}/category.jsp?type=workstation"><div class="cat-item">Workstations</div></a>--%>
<%--    <a href="${pageContext.request.contextPath}/category.jsp?type=accessories"><div class="cat-item">Accessories</div></a>--%>
<%--    <a href="${pageContext.request.contextPath}/pc-build.jsp"><div class="cat-item">PC build</div></a>--%>
<%--</div>--%>

<!-- ===================================================
     HERO SLIDER
     =================================================== -->
<section class="hero-slider" style="display: block; position: relative; overflow: hidden; min-height: 300px; margin: 24px 32px; border-radius: 12px; background: #1e1e2e;">
    <div class="slides" id="hero-slides" style="display: flex; transition: transform 0.5s ease-in-out; width: 100%;">
        <div class="slide" style="min-width: 100%; flex-shrink: 0;">
            <img src="${pageContext.request.contextPath}/static/images/hero1.jpeg" alt="Hero 1" style="width: 100%; height: 340px; object-fit: cover; display: block;">
        </div>
        <div class="slide" style="min-width: 100%; flex-shrink: 0;">
            <img src="${pageContext.request.contextPath}/static/images/hero2.jpeg" alt="Hero 2" style="width: 100%; height: 340px; object-fit: cover; display: block;">
        </div>
        <div class="slide" style="min-width: 100%; flex-shrink: 0;">
            <img src="${pageContext.request.contextPath}/static/images/hero3.jpeg" alt="Hero 3" style="width: 100%; height: 340px; object-fit: cover; display: block;">
        </div>
        <div class="slide" style="min-width: 100%; flex-shrink: 0;">
            <img src="${pageContext.request.contextPath}/static/images/hero4.jpeg" alt="Hero 4" style="width: 100%; height: 340px; object-fit: cover; display: block;">
        </div>
        <div class="slide" style="min-width: 100%; flex-shrink: 0;">
            <img src="${pageContext.request.contextPath}/static/images/hero5.jpeg" alt="Hero 5" style="width: 100%; height: 340px; object-fit: cover; display: block;">
        </div>
    </div>

    <!-- Prev / Next arrows -->
    <button class="slider-arrow slider-prev" onclick="changeSlide(-1)" aria-label="Previous slide">&#10094;</button>
    <button class="slider-arrow slider-next" onclick="changeSlide(1)" aria-label="Next slide">&#10095;</button>

    <div class="slider-controls" id="slider-dots">
        <span class="dot active" onclick="currentSlide(0)"></span>
        <span class="dot" onclick="currentSlide(1)"></span>
        <span class="dot" onclick="currentSlide(2)"></span>
        <span class="dot" onclick="currentSlide(3)"></span>
        <span class="dot" onclick="currentSlide(4)"></span>
    </div>
</section>

<script>
    (function() {
        var slideIndex = 0;
        var slidesEl = document.getElementById('hero-slides');
        var dotsContainer = document.getElementById('slider-dots');
        var dots = dotsContainer ? dotsContainer.getElementsByClassName('dot') : [];
        var totalSlides = dots.length;
        var slideInterval;

        function showSlide(index) {
            if (index >= totalSlides) { slideIndex = 0; }
            else if (index < 0) { slideIndex = totalSlides - 1; }
            else { slideIndex = index; }

            if (slidesEl) {
                slidesEl.style.transform = 'translateX(-' + (slideIndex * 100) + '%)';
            }

            for (var i = 0; i < dots.length; i++) {
                dots[i].className = dots[i].className.replace(' active', '');
            }
            if (dots[slideIndex]) {
                dots[slideIndex].className += ' active';
            }
        }

        function resetInterval() {
            clearInterval(slideInterval);
            slideInterval = setInterval(function() {
                showSlide(slideIndex + 1);
            }, 5000);
        }

        // Expose to onclick handlers
        window.currentSlide = function(index) {
            showSlide(index);
            resetInterval();
        };

        window.changeSlide = function(direction) {
            showSlide(slideIndex + direction);
            resetInterval();
        };

        // Start auto-slide
        resetInterval();
    })();
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
     HomeServlet: request.setAttribute("products", list)
     =================================================== -->
<div class="section">
    <div class="section-header">
        <h2>Featured laptops</h2>
        <a href="${pageContext.request.contextPath}/products">View all &rarr;</a>
    </div>

    <c:choose>
        <c:when test="${empty products}">
            <div class="empty-state">
                <p>No products found</p>
            </div>
        </c:when>
        <c:otherwise>
            <div class="products-grid">
                <c:forEach var="productItem" items="${products}" begin="0" end="11">
                    <div class="product-card">
                        <div class="image-container">
                            <img src="${productItem.image}" alt="${productItem.name}">
                        </div>
                        <div class="product-details">
                            <h3 class="product-name">${productItem.name}</h3>
                            <div class="product-price-wrap">
                                <span class="product-price">RS. ${productItem.price}</span>
                            </div>
                            <div class="product-actions">
                                <form action="${pageContext.request.contextPath}/cart" method="POST">
                                    <input type="hidden" name="action" value="add" />
                                    <input type="hidden" name="productId" value="${productItem.id}" />
                                    <button type="submit" class="add-btn">Add to cart</button>
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
     FOOTER
     =================================================== -->

<%@ include file="/WEB-INF/views/includes/footer.jsp" %>
</body>
</html>
