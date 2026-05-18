<%--<%@ page contentType="text/html;charset=UTF-8" language="java" %>--%>
<%--<%@ taglib uri="jakarta.tags.core" prefix="c" %>--%>
<html>
<head>
    <title>Checkout - LaptopHub</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/main.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/home.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/checkout.css" />
</head>
<body>

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
<%@ include file="/WEB-INF/views/includes/navbar.jsp" %>

<!-- BREADCRUMB -->
<div class="breadcrumb">
    <a href="${pageContext.request.contextPath}/">Home</a> &rsaquo;
    <a href="${pageContext.request.contextPath}/cart">Cart</a> &rsaquo;
    Checkout
</div>

<!-- ERROR BANNER -->
<c:if test="${not empty requestScope.error}">
    <div class="error-banner">${requestScope.error}</div>
</c:if>

<!-- MAIN CONTENT -->
<div class="checkout-container">

    <!-- LEFT: DELIVERY FORM -->
    <div class="checkout-form-section">
        <h2 class="section-title">Delivery Information</h2>

        <form action="${pageContext.request.contextPath}/checkout" method="POST" id="checkoutForm">

            <div class="form-group">
                <label for="fullName">Full Name <span class="required">*</span></label>
                <input type="text" id="fullName" name="fullName"
                       placeholder="e.g. Abhisek Bagdas" required
                       value="${not empty param.fullName ? param.fullName : (not empty sessionScope.user.username ? sessionScope.user.username : '')}"/>
            </div>

            <div class="form-group">
                <label for="phone">Phone Number <span class="required">*</span></label>
                <input type="tel" id="phone" name="phone"
                       placeholder="e.g. 9800000000" required />
            </div>

            <div class="form-group">
                <label for="address">Delivery Address <span class="required">*</span></label>
                <textarea id="address" name="address" rows="3"
                          placeholder="Street, Tole, Ward No." required></textarea>
            </div>

            <div class="form-group">
                <label for="city">City <span class="required">*</span></label>
                <input type="text" id="city" name="city"
                       placeholder="e.g. Kathmandu" required />
            </div>

            <!-- PAYMENT METHOD -->
            <h2 class="section-title" style="margin-top: 36px;">Payment Method</h2>

            <div class="payment-options">

                <label class="payment-card" id="label-cod">
                    <input type="radio" name="paymentMethod" value="COD" checked />
                    <div class="payment-card-inner">
                        <span class="payment-icon">💵</span>
                        <div>
                            <div class="payment-name">Cash on Delivery</div>
                            <div class="payment-desc">Pay when your order arrives</div>
                        </div>
                    </div>
                </label>

                <label class="payment-card" id="label-esewa">
                    <input type="radio" name="paymentMethod" value="eSewa" />
                    <div class="payment-card-inner">
                        <span class="payment-icon">📱</span>
                        <div>
                            <div class="payment-name">eSewa</div>
                            <div class="payment-desc">Pay via eSewa digital wallet</div>
                        </div>
                    </div>
                </label>

                <label class="payment-card" id="label-khalti">
                    <input type="radio" name="paymentMethod" value="Khalti" />
                    <div class="payment-card-inner">
                        <span class="payment-icon">💜</span>
                        <div>
                            <div class="payment-name">Khalti</div>
                            <div class="payment-desc">Pay via Khalti digital wallet</div>
                        </div>
                    </div>
                </label>

            </div>

            <button type="submit" class="place-order-btn">
                ✔ Place Order
            </button>

        </form>
    </div>

    <!-- RIGHT: ORDER SUMMARY -->
    <div class="checkout-summary-section">
        <div class="summary-box">
            <h2>Order Summary</h2>

            <div class="summary-items">
                <c:forEach var="item" items="${requestScope.cartItems}">
                    <div class="summary-item">
                        <img src="${item.imageUrl}" alt="${item.name}" class="summary-item-img" />
                        <div class="summary-item-details">
                            <p class="summary-item-name">${item.name}</p>
                            <p class="summary-item-qty">Qty: ${item.quantity}</p>
                        </div>
                        <p class="summary-item-price">Rs ${item.totalPrice}</p>
                    </div>
                </c:forEach>
            </div>

            <hr class="summary-divider" />

            <div class="summary-line">
                <span>Subtotal</span>
                <span>Rs ${requestScope.subtotal}</span>
            </div>
            <div class="summary-line">
                <span>Shipping</span>
                <span class="free-shipping">FREE</span>
            </div>
            <div class="summary-line">
                <span>Discount</span>
                <span>Rs ${empty requestScope.discount ? '0.00' : requestScope.discount}</span>
            </div>

            <hr class="summary-divider" />

            <div class="summary-line total-line">
                <span>Total</span>
                <span>Rs ${requestScope.total}</span>
            </div>
        </div>
    </div>

</div>

<!-- FOOTER -->
<%@ include file="/WEB-INF/views/includes/footer.jsp" %>

<script>
    // Highlight selected payment card
    document.querySelectorAll('.payment-card input[type="radio"]').forEach(function(radio) {
        radio.addEventListener('change', function() {
            document.querySelectorAll('.payment-card').forEach(function(card) {
                card.classList.remove('selected');
            });
            if (this.checked) {
                this.closest('.payment-card').classList.add('selected');
            }
        });
    });
    // Set initial highlight
    document.querySelector('.payment-card input[type="radio"]:checked')
            .closest('.payment-card').classList.add('selected');
</script>

</body>
</html>
