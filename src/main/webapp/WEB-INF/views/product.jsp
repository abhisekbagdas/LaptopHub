<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <html>
    <!-- check -->

    <head>
        <title>Product</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/main.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/products.css" />
    </head>

    <body>
        <%@ include file="/WEB-INF/views/includes/navbar.jsp" %>
            <div class="product-page-container">
                <!-- Hero Section -->
                <div class="hero-section">
                    <div class="hero-content">
                        <h1>Engineered for<br>Excellence.</h1>
                        <p>Discover the next generation of professional hardware designed for creators and engineers.
                        </p>
                    </div>
                </div>

                <!-- Section Header -->
                <div class="section-header">
                    <div class="section-title-wrap">
                        <span class="sub-label">Premium Collection</span>
                        <h2>Featured Laptops</h2>
                    </div>
                    <form class="filter-actions" method="GET" action="${pageContext.request.contextPath}/products"
                        style="margin: 0; align-items: center;">
                        <input type="text" id="searchInput" name="search" placeholder="Search products..."
                            value="${param.search}"
                            style="padding: 8px 12px; border: 1px solid #e0e0e0; border-radius: 6px; font-size: 14px; outline: none;">
                        <div style="position: relative;">
                            <button type="button" id="filterBtn" class="filter-btn" onclick="toggleFilterMenu()">
                                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                    stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <polygon points="22 3 2 3 10 12.46 10 19 14 21 14 12.46 22 3"></polygon>
                                </svg>
                                Filter
                            </button>
                            <!-- Filter Menu Dropdown -->
                            <div id="filterMenu" class="filter-menu" style="display: none; position: absolute; top: 100%; right: 0; margin-top: 8px; background: white; border: 1px solid #e0e0e0; border-radius: 8px; box-shadow: 0 4px 12px rgba(0,0,0,0.1); padding: 16px; width: 250px; z-index: 100; text-align: left;">
                                <div style="margin-bottom: 16px;">
                                    <h4 style="font-size: 14px; margin-bottom: 8px; color: #111;">Price Range</h4>
                                    <label style="display: block; font-size: 13px; margin-bottom: 6px; color: #555; cursor: pointer;">
                                        <input type="radio" name="priceFilter" value="all" checked onchange="applyFilters()" style="margin-right: 6px;"> All Prices
                                    </label>
                                    <label style="display: block; font-size: 13px; margin-bottom: 6px; color: #555; cursor: pointer;">
                                        <input type="radio" name="priceFilter" value="under100k" onchange="applyFilters()" style="margin-right: 6px;"> Under NPR 100,000
                                    </label>
                                    <label style="display: block; font-size: 13px; margin-bottom: 6px; color: #555; cursor: pointer;">
                                        <input type="radio" name="priceFilter" value="100kTo200k" onchange="applyFilters()" style="margin-right: 6px;"> NPR 100,000 - 200,000
                                    </label>
                                    <label style="display: block; font-size: 13px; margin-bottom: 6px; color: #555; cursor: pointer;">
                                        <input type="radio" name="priceFilter" value="over200k" onchange="applyFilters()" style="margin-right: 6px;"> Over NPR 200,000
                                    </label>
                                </div>
                                <div>
                                    <h4 style="font-size: 14px; margin-bottom: 8px; color: #111;">Brand</h4>
                                    <select id="brandFilter" style="width: 100%; padding: 8px; border-radius: 6px; border: 1px solid #e0e0e0; outline: none; font-size: 13px; color: #333;" onchange="applyFilters()">
                                        <option value="all">All Brands</option>
                                        <option value="apple">Apple</option>
                                        <option value="dell">Dell</option>
                                        <option value="hp">HP</option>
                                        <option value="lenovo">Lenovo</option>
                                        <option value="asus">Asus</option>
                                        <option value="acer">Acer</option>
                                        <option value="msi">MSI</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <select name="sort" class="filter-btn" onchange="this.form.submit()"
                            style="appearance: none; cursor: pointer;">
                            <option value="">Sort By</option>
                            <option value="price_asc" ${param.sort=='price_asc' ? 'selected' : '' }>Price: Low to High
                            </option>
                            <option value="price_desc" ${param.sort=='price_desc' ? 'selected' : '' }>Price: High to Low
                            </option>
                        </select>
                    </form>
                </div>

                <script>
                    function applyFilters() {
                        var searchInput = document.getElementById('searchInput').value.toLowerCase();
                        var priceFilter = document.querySelector('input[name="priceFilter"]:checked').value;
                        var brandFilter = document.getElementById('brandFilter').value.toLowerCase();
                        
                        var products = document.getElementsByClassName('product-card');

                        for (var i = 0; i < products.length; i++) {
                            var productName = products[i].getElementsByClassName('product-name')[0].innerText.toLowerCase();
                            var priceText = products[i].getElementsByClassName('product-price')[0].innerText;
                            var priceValue = parseFloat(priceText.replace(/[^0-9.-]+/g,""));
                            
                            var matchesSearch = productName.includes(searchInput);
                            
                            var matchesPrice = true;
                            if (priceFilter === 'under100k') {
                                matchesPrice = priceValue < 100000;
                            } else if (priceFilter === '100kTo200k') {
                                matchesPrice = priceValue >= 100000 && priceValue <= 200000;
                            } else if (priceFilter === 'over200k') {
                                matchesPrice = priceValue > 200000;
                            }
                            
                            var matchesBrand = true;
                            if (brandFilter !== 'all') {
                                matchesBrand = productName.includes(brandFilter);
                            }
                            
                            if (matchesSearch && matchesPrice && matchesBrand) {
                                products[i].style.display = "";
                            } else {
                                products[i].style.display = "none";
                            }
                        }
                    }

                    function toggleFilterMenu() {
                        var menu = document.getElementById('filterMenu');
                        if (menu.style.display === 'none' || menu.style.display === '') {
                            menu.style.display = 'block';
                        } else {
                            menu.style.display = 'none';
                        }
                    }

                    // Close menu when clicking outside
                    document.addEventListener('click', function(event) {
                        var menu = document.getElementById('filterMenu');
                        if (menu && menu.style.display === 'block') {
                            if (!event.target.closest('#filterBtn') && !event.target.closest('#filterMenu')) {
                                menu.style.display = 'none';
                            }
                        }
                    });

                    // Real-time filtering on search input
                    document.getElementById('searchInput').addEventListener('input', applyFilters);

                    // Prevent form submission on enter since we do client-side filtering
                    document.getElementById('searchInput').addEventListener('keypress', function (e) {
                        if (e.key === 'Enter') {
                            e.preventDefault();
                        }
                    });
                </script>

                <c:choose>
                    <c:when test="${empty products}">
                        <div class="empty-state">
                            <p>No products found</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="product-grid">
                            <c:forEach var="productItem" items="${products}">
                                <div class="product-card" onclick="window.location.href='${pageContext.request.contextPath}/product?id=${productItem.id}'" style="cursor: pointer;">
                                    <div class="image-container">
                                        <img src="${productItem.image}" alt="${productItem.name}">
                                    </div>
                                    <div class="product-details">
                                        <h3 class="product-name">${productItem.name}</h3>
                                        <div class="product-price-wrap">
                                            <span class="product-price">NPR ${productItem.price}</span>
                                        </div>
                                        <div class="product-rating"
                                            style="color: #f5c518; font-size: 16px; margin-bottom: 16px; letter-spacing: 2px;">
                                            &#9733;&#9733;&#9733;&#9733;&#9733; <span
                                                style="color: #888; font-size: 12px; letter-spacing: 0;">(5.0)</span>
                                        </div>
                                        <div class="product-actions">
                                            <form action="${pageContext.request.contextPath}/cart" method="POST"
                                                style="width: 100%;" onclick="event.stopPropagation();">
                                                <input type="hidden" name="action" value="add" />
                                                <input type="hidden" name="productId" value="${productItem.id}" />
                                                <button type="submit" class="btn btn-primary" style="width: 100%;">Add
                                                    to cart</button>
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