<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>${product.name} - LaptopHub</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/main.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/product-detail.css" />
</head>
<body>
    <%@ include file="/WEB-INF/views/includes/navbar.jsp" %>
    
    <div class="product-detail-container">
        
        <!-- Top Section: Image Gallery and Info -->
        <div class="product-top-section">
            <div class="product-gallery">
                <div class="main-image">
                    <img id="primaryImage" src="${product.image}" alt="${product.name}">
                </div>
                <div class="thumbnail-list">
                    <div class="thumbnail active" onclick="changeImage('${product.image}', this)">
                        <img src="${product.image}" alt="${product.name} thumbnail 1">
                    </div>
                    <!-- Placeholders for other thumbnails -->
                    <div class="thumbnail placeholder"></div>
                    <div class="thumbnail placeholder"></div>
                    <div class="thumbnail placeholder"></div>
                </div>
            </div>
            
            <div class="product-info">
                <h1 class="product-title">${product.name}</h1>
                <div class="product-rating-stars">
                    &#9733;&#9733;&#9733;&#9733;&#9734;
                </div>
                
                <div class="product-price-section">
                    <div class="price-currency">NPR</div>
                    <div class="price-amount">${product.price}</div>
                </div>
                
                <div class="product-options">
                    <div class="option-group">
                        <label>COLOR</label>
                        <div class="color-options">
                            <div class="color-swatch active" style="background-color: #E6E8EA;"></div>
                            <div class="color-swatch" style="background-color: #38393A;"></div>
                        </div>
                    </div>
                    
                    <div class="option-group">
                        <label>MEMORY (RAM)</label>
                        <div class="memory-options">
                            <div class="memory-box active">16GB</div>
                            <div class="memory-box">32GB</div>
                        </div>
                    </div>
                </div>
                
                <form action="${pageContext.request.contextPath}/cart" method="POST" class="add-to-cart-form">
                    <input type="hidden" name="action" value="add" />
                    <input type="hidden" name="productId" value="${product.id}" />
                    <button type="submit" class="add-to-cart-btn">Add to Cart</button>
                </form>
            </div>
        </div>

        <!-- Middle Section: Tabs & Specifications -->
        <div class="product-tabs-section">
            <div class="tabs-header">
                <div class="tab-item" onclick="switchTab('overview')">Overview</div>
                <div class="tab-item active" onclick="switchTab('specifications')">Specifications</div>
                <div class="tab-item" onclick="switchTab('reviews')">Reviews</div>
            </div>
            
            <div class="tab-content" id="specifications">
                <div class="specs-grid">
                    <div class="spec-row">
                        <div class="spec-label">Processor</div>
                        <div class="spec-value">UltraChip X1 Pro</div>
                    </div>
                    <div class="spec-row">
                        <div class="spec-label">Ports</div>
                        <div class="spec-value">3x Thunderbolt 4, HDMI 2.1</div>
                    </div>
                    <div class="spec-row">
                        <div class="spec-label">Core Count</div>
                        <div class="spec-value">12-Core CPU (8 Perf, 4 Eff)</div>
                    </div>
                    <div class="spec-row">
                        <div class="spec-label">Wireless</div>
                        <div class="spec-value">Wi-Fi 6E, Bluetooth 5.3</div>
                    </div>
                    <div class="spec-row">
                        <div class="spec-label">Graphics</div>
                        <div class="spec-value">16-Core Neural GPU</div>
                    </div>
                    <div class="spec-row">
                        <div class="spec-label">Battery</div>
                        <div class="spec-value">Up to 18 Hours Video Playback</div>
                    </div>
                    <div class="spec-row">
                        <div class="spec-label">Display</div>
                        <div class="spec-value">14.2" Liquid Pro HDR</div>
                    </div>
                    <div class="spec-row">
                        <div class="spec-label">Charging</div>
                        <div class="spec-value">96W USB-C Fast Charge</div>
                    </div>
                    <div class="spec-row">
                        <div class="spec-label">Resolution</div>
                        <div class="spec-value">3024 x 1964 (254 ppi)</div>
                    </div>
                    <div class="spec-row">
                        <div class="spec-label">Weight</div>
                        <div class="spec-value">3.5 lbs (1.6 kg)</div>
                    </div>
                    <div class="spec-row">
                        <div class="spec-label">Refresh Rate</div>
                        <div class="spec-value">120Hz Adaptive Sync</div>
                    </div>
                    <div class="spec-row">
                        <div class="spec-label">OS</div>
                        <div class="spec-value">TechSpec OS Professional</div>
                    </div>
                </div>
            </div>
            
            <div class="tab-content hidden" id="overview">
                <div style="padding: 40px 0;">
                    <p style="font-size: 1.1rem; line-height: 1.6; color: #555;">${product.description}</p>
                </div>
            </div>
            
            <div class="tab-content hidden" id="reviews">
                <div style="padding: 40px 0; text-align: center; color: #888;">
                    No reviews yet for this product.
                </div>
            </div>
        </div>
    </div>
    
    <!-- Related Products Section -->
    <div class="related-products-section">
        <div class="related-products-container">
            <div class="related-header">
                <h2>You may also like.</h2>
                <a href="${pageContext.request.contextPath}/products" class="view-all-link">View All</a>
            </div>
            
            <div class="related-grid">
                <c:forEach var="relatedItem" items="${relatedProducts}">
                    <div class="related-card" onclick="window.location.href='${pageContext.request.contextPath}/product?id=${relatedItem.id}'">
                        <div class="related-image-wrap">
                            <img src="${relatedItem.image}" alt="${relatedItem.name}">
                        </div>
                        <div class="related-details">
                            <h3 class="related-name">${relatedItem.name}</h3>
                            <div class="related-price">NPR ${relatedItem.price}</div>
                            <form action="${pageContext.request.contextPath}/cart" method="POST" onclick="event.stopPropagation();">
                                <input type="hidden" name="action" value="add" />
                                <input type="hidden" name="productId" value="${relatedItem.id}" />
                                <button type="submit" class="related-add-btn">Add to Cart</button>
                            </form>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>

    <%@ include file="/WEB-INF/views/includes/footer.jsp" %>
    
    <script>
        function changeImage(src, element) {
            document.getElementById('primaryImage').src = src;
            document.querySelectorAll('.thumbnail').forEach(t => t.classList.remove('active'));
            if(element) element.classList.add('active');
        }

        function switchTab(tabId) {
            document.querySelectorAll('.tab-content').forEach(t => t.classList.add('hidden'));
            document.querySelectorAll('.tab-item').forEach(t => t.classList.remove('active'));
            
            document.getElementById(tabId).classList.remove('hidden');
            event.currentTarget.classList.add('active');
        }
        
        // Simple mock interaction for options
        document.querySelectorAll('.color-swatch').forEach(swatch => {
            swatch.addEventListener('click', function() {
                document.querySelectorAll('.color-swatch').forEach(s => s.classList.remove('active'));
                this.classList.add('active');
            });
        });
        
        document.querySelectorAll('.memory-box').forEach(box => {
            box.addEventListener('click', function() {
                document.querySelectorAll('.memory-box').forEach(b => b.classList.remove('active'));
                this.classList.add('active');
            });
        });
    </script>
</body>
</html>
