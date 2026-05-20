<%--<%@ page contentType="text/html;charset=UTF-8" language="java" %>--%>
<%--<%@ taglib uri="jakarta.tags.core" prefix="c" %>--%>
<html>
<head>
    <title>Order Confirmed - LaptopHub</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/main.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/home.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/order-confirmation.css" />
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
    <a href="${pageContext.request.contextPath}/">Home</a> &rsaquo; Order Confirmation
</div>

<!-- CONFIRMATION WRAPPER -->
<div class="confirmation-wrapper">

    <!-- SUCCESS BANNER -->
    <div class="success-banner">
        <div class="success-icon"><i class="fa-solid fa-circle-check"></i></div>
        <div class="success-text">
            <h1>Order Placed Successfully!</h1>
            <p>Thank you, <strong>${sessionScope.user.username}</strong>.
               Your order <strong>#${order.orderId}</strong> has been received.</p>
        </div>
    </div>

    <!-- TWO-COLUMN LAYOUT -->
    <div class="confirmation-grid">

        <!-- LEFT: ORDER ITEMS -->
        <div class="conf-items-section">
            <h2 class="conf-section-title">Items Ordered</h2>

            <c:forEach var="item" items="${order.items}">
                <div class="conf-item-row">
                    <img src="${item.image}" alt="${item.productName}" class="conf-item-img" />
                    <div class="conf-item-details">
                        <p class="conf-item-name">${item.productName}</p>
                        <p class="conf-item-meta">Qty: ${item.quantity} &nbsp;|&nbsp; Unit Price: Rs ${item.unitPrice}</p>
                    </div>
                    <p class="conf-item-total">Rs ${item.totalPrice}</p>
                </div>
            </c:forEach>

            <!-- TOTALS -->
            <div class="conf-totals">
                <div class="conf-total-line">
                    <span>Subtotal</span>
                    <span>Rs ${order.subtotal}</span>
                </div>
                <div class="conf-total-line">
                    <span>Shipping</span>
                    <span class="free-tag">FREE</span>
                </div>
                <div class="conf-total-line">
                    <span>Discount</span>
                    <span>Rs ${order.discount}</span>
                </div>
                <div class="conf-total-line grand-total">
                    <span>Total Paid</span>
                    <span>Rs ${order.total}</span>
                </div>
            </div>
        </div>

        <!-- RIGHT: DELIVERY + PAYMENT DETAILS -->
        <div class="conf-details-section">
            <h2 class="conf-section-title">Delivery Details</h2>
            <div class="detail-card">
                <div class="detail-row">
                    <span class="detail-label">Name</span>
                    <span class="detail-value">${order.fullName}</span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Phone</span>
                    <span class="detail-value">${order.phone}</span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Address</span>
                    <span class="detail-value">${order.address}</span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">City</span>
                    <span class="detail-value">${order.city}</span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Payment</span>
                    <span class="detail-value payment-badge">${order.paymentMethod}</span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Status</span>
                    <span class="detail-value status-badge">${order.status}</span>
                </div>
            </div>

            <a href="${pageContext.request.contextPath}/" class="continue-btn">
                &#8592; Continue Shopping
            </a>
        </div>

    </div>
</div>

<!-- FOOTER -->
<%@ include file="/WEB-INF/views/includes/footer.jsp" %>

</body>
</html>
