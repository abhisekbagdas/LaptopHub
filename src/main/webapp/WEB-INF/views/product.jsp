<%-- Created by IntelliJ IDEA. User: Abhisek Date: 4/7/2026 Time: 1:00 PM To change this template use File | Settings |
  File Templates. --%>
  <%@ page contentType="text/html;charset=UTF-8" language="java" %>

    <html>

    <head>
      <title>Product</title>
      <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/main.css" />
      <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/products.css" />
    </head>

    <div id="nav">
      <%@ include file="/WEB-INF/views/includes/navbar.jsp" %>
    </div>

    <body>
      <div class="main-container">
        <div class="header-box">Our Products</div>

        <div class="product-section">
          <h2 class="section-title">Office Laptops</h2>
          <div class="product-grid">
            <div class="product-card">
              <div class="image-placeholder"></div>
              <div class="product-details">
                <h3>Name</h3>
                <p class="product-price">NPR 60,000</p>
                <div class="product-rating">&#9733;&#9733;&#9733;&#9733;&#9733;</div>
                <button class="add-to-cart-btn">Add to Cart</button>
              </div>
            </div>
            <div class="product-card">
              <div class="image-placeholder"></div>
              <div class="product-details">
                <h3>Name</h3>
                <p class="product-price">NPR 60,000</p>
                <div class="product-rating">&#9733;&#9733;&#9733;&#9733;&#9733;</div>
                <button class="add-to-cart-btn">Add to Cart</button>
              </div>
            </div>
            <div class="product-card">
              <div class="image-placeholder"></div>
              <div class="product-details">
                <h3>Name</h3>
                <p class="product-price">NPR 60,000</p>
                <div class="product-rating">&#9733;&#9733;&#9733;&#9733;&#9733;</div>
                <button class="add-to-cart-btn">Add to Cart</button>
              </div>
            </div>
            <div class="product-card">
              <div class="image-placeholder"></div>
              <div class="product-details">
                <h3>Name</h3>
                <p class="product-price">NPR 60,000</p>
                <div class="product-rating">&#9733;&#9733;&#9733;&#9733;&#9733;</div>
                <button class="add-to-cart-btn">Add to Cart</button>
              </div>
            </div>
            <div class="product-card">
              <div class="image-placeholder"></div>
              <div class="product-details">
                <h3>Name</h3>
                <p class="product-price">NPR 60,000</p>
                <div class="product-rating">&#9733;&#9733;&#9733;&#9733;&#9733;</div>
                <button class="add-to-cart-btn">Add to Cart</button>
              </div>
            </div>
          </div>
        </div>

        <div class="product-section">
          <h2 class="section-title">Gaming Laptops</h2>
          <div class="product-grid">
            <div class="product-card">
              <div class="image-placeholder"></div>
              <div class="product-details">
                <h3>Name</h3>
                <p class="product-price">NPR 60,000</p>
                <div class="product-rating">&#9733;&#9733;&#9733;&#9733;&#9733;</div><button class="add-to-cart-btn">Add
                  to Cart</button>
              </div>
            </div>
            <div class="product-card">
              <div class="image-placeholder"></div>
              <div class="product-details">
                <h3>Name</h3>
                <p class="product-price">NPR 60,000</p>
                <div class="product-rating">&#9733;&#9733;&#9733;&#9733;&#9733;</div><button class="add-to-cart-btn">Add
                  to Cart</button>
              </div>
            </div>
            <div class="product-card">
              <div class="image-placeholder"></div>
              <div class="product-details">
                <h3>Name</h3>
                <p class="product-price">NPR 60,000</p>
                <div class="product-rating">&#9733;&#9733;&#9733;&#9733;&#9733;</div><button class="add-to-cart-btn">Add
                  to Cart</button>
              </div>
            </div>
            <div class="product-card">
              <div class="image-placeholder"></div>
              <div class="product-details">
                <h3>Name</h3>
                <p class="product-price">NPR 60,000</p>
                <div class="product-rating">&#9733;&#9733;&#9733;&#9733;&#9733;</div><button class="add-to-cart-btn">Add
                  to Cart</button>
              </div>
            </div>
            <div class="product-card">
              <div class="image-placeholder"></div>
              <div class="product-details">
                <h3>Name</h3>
                <p class="product-price">NPR 60,000</p>
                <div class="product-rating">&#9733;&#9733;&#9733;&#9733;&#9733;</div><button class="add-to-cart-btn">Add
                  to Cart</button>
              </div>
            </div>
          </div>
        </div>

      </div>
      <%@ include file="/WEB-INF/views/includes/footer.jsp" %>
    </body>

    </html>