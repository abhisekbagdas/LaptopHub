<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<html>
<head>
    <title>My Cart - LaptopHub</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/main.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/home.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/cart.css" />
</head>
<body>

<!-- TOP BAR -->
<%--<div class="topbar">--%>
<%--    <div class="topbar-left">--%>
<%--        <a href="${pageContext.request.contextPath}/about">About us</a>--%>
<%--&lt;%&ndash;        <a href="${pageContext.request.contextPath}/faqs">FAQ</a>&ndash;%&gt;--%>
<%--&lt;%&ndash;        <a href="${pageContext.request.contextPath}/privacy">Privacy policy</a>&ndash;%&gt;--%>
<%--    </div>--%>
<%--    <div class="topbar-right">--%>
<%--&lt;%&ndash;        <a href="${pageContext.request.contextPath}/warranty">Warranty</a>&ndash;%&gt;--%>
<%--        <a href="tel:+97798011000037">Customer service: +977-9801100037</a>--%>
<%--    </div>--%>
<%--</div>--%>
<%@ include file="/WEB-INF/views/includes/navbar.jsp" %>

<!-- BREADCRUMB -->
<div class="breadcrumb">
    <a href="${pageContext.request.contextPath}/">Home</a> &rsaquo; Cart
</div>

<!-- MAIN CONTENT -->
<div class="main-container">
    
    <!-- LEFT SIDE: CART ITEMS -->
    <div class="cart-items-section">
        
        <c:choose>
            <c:when test="${not empty requestScope.cartItems}">
                <c:forEach var="item" items="${requestScope.cartItems}">
                    <!-- A SINGLE CART ITEM -->
                    <div class="cart-box">
                        
                        <!-- Product Image -->
                        <div class="box-image">
                            <img src="${item.imageUrl}" alt="${item.name}" />
                        </div>
                        
                        <!-- Product Details -->
                        <div class="box-details">
                            <h3>${item.name}</h3>
                            <p class="price-text">
                                <span class="new-price"> RS. ${item.totalPrice}</span>
                            </p>
                            
                            <!-- Quantity Buttons -->
                            <div class="quantity-form-container">
                                <form action="${pageContext.request.contextPath}/cart" method="POST">
                                    <input type="hidden" name="action" value="decrease" />
                                    <input type="hidden" name="productId" value="${item.productId}" />
                                    <button type="submit" class="qty-btn">-</button>
                                </form>
                                
                                <div class="qty-number">${item.quantity}</div>
                                
                                <form action="${pageContext.request.contextPath}/cart" method="POST">
                                    <input type="hidden" name="action" value="increase" />
                                    <input type="hidden" name="productId" value="${item.productId}" />
                                    <button type="submit" class="qty-btn">+</button>
                                </form>
                            </div>
                        </div>
                        
                        <!-- Delete Button (Trash Can) -->
                        <div class="box-delete">
                            <form action="${pageContext.request.contextPath}/cart" method="POST">
                                <input type="hidden" name="action" value="remove" />
                                <input type="hidden" name="productId" value="${item.productId}" />
                                <button type="submit" class="delete-btn">
                                    &#128465;
                                </button>
                            </form>
                        </div>
                        
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div class="empty-message">
                    <p>Your cart is empty.</p>
                </div>
            </c:otherwise>
        </c:choose>
        
    </div>

    <!-- RIGHT SIDE: ORDER SUMMARY -->
    <div class="order-summary-section">
        <div class="summary-box">
            <h2>Order Summary</h2>
            
            <div class="summary-line">
                <span class="left-text">Subtotal</span>
                <span class="right-text">Rs ${requestScope.subtotal}</span>
            </div>
            <div class="summary-line">
                <span class="left-text">Shipping</span>
                <span class="right-text">Rs 0</span>
            </div>
            <div class="summary-line">
                <span class="left-text">Discount</span>
                <span class="right-text">Rs ${empty requestScope.discount ? 0 : requestScope.discount}</span>
            </div>
            <div class="summary-line">
                <span class="left-text">VAT</span>
                <span class="right-text">Rs 0</span>
            </div>
            <div class="summary-line total-line">
                <span class="left-text">Total</span>
                <span class="right-text">Rs ${requestScope.total}</span>
            </div>
            
            <hr>
            
            <div class="promo-section">
                <p>Promo Code</p>
                <form action="${pageContext.request.contextPath}/cart" method="POST" class="promo-form">
                    <input type="hidden" name="action" value="promo" />
                    <input type="text" name="promoCode" placeholder="Enter Code" class="promo-input" />
                    <button type="submit" class="promo-btn">Apply</button>
                </form>
            </div>
            
            <a href="${pageContext.request.contextPath}/checkout" style="text-decoration: none;">
                <button class="checkout-button">Proceed to Checkout</button>
            </a>
            
        </div>
    </div>
    
</div>

<!-- FOOTER -->
<%@ include file="/WEB-INF/views/includes/footer.jsp" %>
</body>
</html>
