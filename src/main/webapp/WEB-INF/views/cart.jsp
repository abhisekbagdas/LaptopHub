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

<%@ include file="/WEB-INF/views/includes/navbar.jsp" %>
<!-- TOP BAR -->
<div class="topbar">
    <div class="topbar-left">
        <a href="${pageContext.request.contextPath}/about">About us</a>
        <a href="${pageContext.request.contextPath}/faqs">FAQ</a>
        <a href="${pageContext.request.contextPath}/privacy">Privacy policy</a>
    </div>
    <div class="topbar-right">
        <a href="${pageContext.request.contextPath}/warranty">Warranty</a>
        <a href="tel:+97798011000037">Customer service: +977-9801100037</a>
    </div>
</div>

<!-- NAVBAR -->
<nav class="navbar">
    <a href="${pageContext.request.contextPath}/" class="logo">laptop<span>hub</span></a>
    <div class="nav-links">
        <a href="${pageContext.request.contextPath}/">Home</a>
        <c:choose>
            <c:when test="${not empty sessionScope.user}">
                <a href="${pageContext.request.contextPath}/user">${sessionScope.user.name}</a>
                <a href="${pageContext.request.contextPath}/logout" class="logout"
                   onclick="return confirm('Are you sure you want to logout?');">Logout</a>
            </c:when>
            <c:otherwise>
                <a href="${pageContext.request.contextPath}login.jsp">My account</a>
            </c:otherwise>
        </c:choose>
        <a href="${pageContext.request.contextPath}cart">
            <button class="cart-btn">&#128722; My cart
                <c:if test="${not empty sessionScope.cartCount}">(${sessionScope.cartCount})</c:if>
            </button>
        </a>
    </div>
</nav>

<!-- BREADCRUMB -->
<div class="breadcrumb">
    <a href="${pageContext.request.contextPath}/">Home</a> &rsaquo; My cart
</div>

<!-- MAIN CONTENT -->
<div class="page-body">

    <!-- CART ITEMS -->
    <div class="cart-items">
        <div class="cart-header">
            <h2>My cart</h2>
            <span>
          <c:choose>
              <c:when test="${not empty requestScope.cartItems}">
                  ${requestScope.cartItems.size()} items
              </c:when>
              <c:otherwise>0 items</c:otherwise>
          </c:choose>
        </span>
        </div>

        <c:choose>

            <%-- Cart has items --%>
            <c:when test="${not empty requestScope.cartItems}">
                <c:forEach var="item" items="${requestScope.cartItems}">
                    <div class="cart-row">
                        <div class="item-img">
                            <img src="${item.imageUrl}" alt="${item.name}" style="max-height:60px;object-fit:contain;" />
                        </div>
                        <div class="item-info">
                            <div class="item-name">${item.name}</div>
                            <div class="item-spec">${item.shortSpec}</div>
                            <div class="qty-ctrl">
                                <form action="${pageContext.request.contextPath}/cart" method="POST" style="display:inline;">
                                    <input type="hidden" name="action" value="decrease" />
                                    <input type="hidden" name="productId" value="${item.productId}" />
                                    <button type="submit" class="qty-btn">&#8722;</button>
                                </form>
                                <span class="qty-val">${item.quantity}</span>
                                <form action="${pageContext.request.contextPath}/cart" method="POST" style="display:inline;">
                                    <input type="hidden" name="action" value="increase" />
                                    <input type="hidden" name="productId" value="${item.productId}" />
                                    <button type="submit" class="qty-btn">&#43;</button>
                                </form>
                            </div>
                        </div>
                        <div class="item-price">Rs. ${item.totalPrice}</div>
                        <form action="${pageContext.request.contextPath}/cart" method="POST" style="display:inline;">
                            <input type="hidden" name="action" value="remove" />
                            <input type="hidden" name="productId" value="${item.productId}" />
                            <button type="submit" class="remove-btn">&#10005;</button>
                        </form>
                    </div>
                </c:forEach>
            </c:when>

            <%-- Empty cart --%>
            <c:otherwise>
                <div class="empty-cart">
                    <div class="big-icon">&#128722;</div>
                    <p>Your cart is empty</p>
                    <a href="${pageContext.request.contextPath}/"><button class="shop-btn">Continue shopping</button></a>
                </div>
            </c:otherwise>

        </c:choose>
    </div>

    <!-- ORDER SUMMARY -->
    <div>
        <div class="summary-box">
            <h2>Order summary</h2>

            <div class="summary-row">
                <span>Subtotal</span>
                <span>Rs. ${requestScope.subtotal}</span>
            </div>
            <c:if test="${requestScope.discount > 0}">
                <div class="summary-row discount">
                    <span>Discount</span>
                    <span>- Rs. ${requestScope.discount}</span>
                </div>
            </c:if>
            <div class="summary-row">
                <span>Delivery</span>
                <span style="color:#15803d;">Free</span>
            </div>

            <hr class="summary-divider" />

            <div class="summary-total">
                <span>Total</span>
                <span>Rs. ${requestScope.total}</span>
            </div>

            <a href="${pageContext.request.contextPath}checkout"><button class="checkout-btn">Proceed to checkout</button></a>
            <a href="${pageContext.request.contextPath}/"><button class="continue-btn">Continue shopping</button></a>

            <!-- PROMO CODE -->
            <div class="promo-wrap">
                <label>Promo code</label>
                <form action="${pageContext.request.contextPath}cart" method="POST">
                    <input type="hidden" name="action" value="promo" />
                    <div class="promo-row">
                        <input type="text" name="promoCode" placeholder="Enter code" />
                        <button type="submit">Apply</button>
                    </div>
                </form>
                <c:if test="${not empty requestScope.promoMsg}">
                    <p style="font-size:12px;margin-top:6px;color:${requestScope.promoSuccess ? '#15803d' : '#dc2626'};">
                            ${requestScope.promoMsg}
                    </p>
                </c:if>
            </div>

            <!-- TRUST BADGES -->
            <div class="trust-row">
                <div class="trust-item"><span class="trust-icon">&#128274;</span>Secure payment</div>
                <div class="trust-item"><span class="trust-icon">&#128666;</span>Free delivery</div>
                <div class="trust-item"><span class="trust-icon">&#9989;</span>Warranty</div>
            </div>

        </div>
    </div>

</div>

<!-- FOOTER -->
<%@ include file="/WEB-INF/views/includes/footer.jsp" %>
</body>
</html>
