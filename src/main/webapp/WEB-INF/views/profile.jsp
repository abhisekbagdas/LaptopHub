<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>Profile Settings — LaptopHub</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/profile.css"/>
</head>
<body>

<div class="profile-layout">

    <!-- ===== LEFT SIDEBAR ===== -->
    <%@ include file="/WEB-INF/views/includes/navbar.jsp" %>

    <!-- ===== MAIN CONTENT ===== -->
    <div class="main-wrapper">

        <!-- ===== TOP BAR ===== -->
        <header class="topbar">
            <div class="topbar-search">
                <i class="fas fa-search"></i>
                <input type="text" placeholder="Search settings..." disabled/>
            </div>
            <div class="topbar-actions">
                <button class="topbar-icon-btn"><i class="fas fa-bell"></i></button>
                <button class="topbar-icon-btn"><i class="fas fa-question-circle"></i></button>
                <div class="topbar-user">
                    <div class="topbar-user-avatar">
                        <c:choose>
                            <c:when test="${not empty profileUser.profileImage}">
                                <img src="${pageContext.request.contextPath}/${profileUser.profileImage}" alt="Profile" style="width: 100%; height: 100%; object-fit: cover; border-radius: 50%;"/>
                            </c:when>
                            <c:otherwise>
                                <c:out value="${profileUser.username.substring(0,1).toUpperCase()}"/>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <span class="topbar-user-name"><c:out value="${profileUser.username}"/></span>
                </div>
            </div>
        </header>

        <!-- ===== CONTENT AREA ===== -->
        <main class="content">

            <!-- ===== Alert Messages ===== -->
            <c:if test="${not empty success}">
                <div class="alert alert-success">
                    <i class="fas fa-check-circle"></i> <c:out value="${success}"/>
                </div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="alert alert-error">
                    <i class="fas fa-exclamation-circle"></i> <c:out value="${error}"/>
                </div>
            </c:if>

            <!-- ===== PROFILE HEADER ===== -->
            <div class="profile-header">
                <div class="profile-header-left">
                    <div class="profile-avatar-wrap">
                        <div class="profile-avatar-lg">
                            <c:choose>
                                <c:when test="${not empty profileUser.profileImage}">
                                    <img src="${pageContext.request.contextPath}/${profileUser.profileImage}" alt="Profile" style="width: 100%; height: 100%; object-fit: cover; border-radius: 50%;"/>
                                </c:when>
                                <c:otherwise>
                                    <c:out value="${profileUser.username.substring(0,1).toUpperCase()}"/>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <button class="avatar-edit-btn" type="button" onclick="document.getElementById('photoInput').click()"><i class="fas fa-pencil-alt"></i></button>
                        <!-- Hidden photo upload form -->
                        <form id="photoUploadForm" action="${pageContext.request.contextPath}/profile" method="post" enctype="multipart/form-data" style="display:none;">
                            <input type="hidden" name="action" value="uploadPhoto"/>
                            <input type="file" id="photoInput" name="profilePhoto" accept="image/*" onchange="document.getElementById('photoUploadForm').submit();"/>
                        </form>
                    </div>
                    <div class="profile-header-info">
                        <h1 class="profile-name"><c:out value="${profileUser.username}"/></h1>
                        <p class="profile-email-display"><c:out value="${profileUser.email}"/></p>
                        <div class="profile-badges">
                            <span class="badge badge-verified"><i class="fas fa-check-circle"></i> Verified Account</span>
                            <c:choose>
                                <c:when test="${isAdmin}">
                                    <span class="badge badge-role-admin">Admin</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge badge-role">Member</span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
                <div class="profile-header-actions">
                    <button type="submit" form="updateProfileForm" class="btn-save">Save Changes</button>
                    <a href="${pageContext.request.contextPath}/profile" class="btn-discard">Discard</a>
                </div>
            </div>

            <!-- ===== CARDS ROW ===== -->
            <div class="cards-row">

                <!-- Personal Information Card -->
                <div class="card card-personal">
                    <div class="card-title">
                        <i class="fas fa-user"></i> Personal Information
                    </div>
                    <form id="updateProfileForm" action="${pageContext.request.contextPath}/profile" method="post">
                        <input type="hidden" name="action" value="updateProfile"/>
                        <div class="form-row">
                            <div class="form-group">
                                <label>USERNAME</label>
                                <input type="text" name="username"
                                       value="<c:out value='${profileUser.username}'/>" required/>
                            </div>
                            <div class="form-group">
                                <label>EMAIL ADDRESS</label>
                                <input type="email" name="email"
                                       value="<c:out value='${profileUser.email}'/>" required/>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-group">
                                <label>MEMBER SINCE</label>
                                <input type="text" disabled
                                       value="<fmt:formatDate value='${profileUser.createdAt}' pattern='MMMM dd, yyyy'/>"/>
                            </div>
                            <div class="form-group">
                                <label>USER ID</label>
                                <input type="text" disabled
                                       value="#${profileUser.id}"/>
                            </div>
                        </div>
                    </form>
                </div>

                <!-- Security Card -->
                <div class="card card-security">
                    <div class="card-title">
                        <i class="fas fa-shield-alt"></i> Security
                    </div>

                    <div class="security-item">
                        <div class="security-item-info">
                            <strong>Password</strong>
                            <span class="security-meta">Last changed
                                <fmt:formatDate value="${profileUser.updatedAt}" pattern="MMM dd, yyyy"/>
                            </span>
                        </div>
                        <button type="button" class="btn-update-link" onclick="document.getElementById('passwordModal').classList.add('active')">UPDATE</button>
                    </div>

                    <div class="security-item">
                        <div class="security-item-info">
                            <strong>Two-Factor Auth</strong>
                            <span class="security-meta security-enabled">ENABLED</span>
                        </div>
                        <label class="toggle-switch">
                            <input type="checkbox" checked disabled/>
                            <span class="toggle-slider"></span>
                        </label>
                    </div>

                    <button type="button" class="btn-deactivate"
                            onclick="alert('Account deactivation is not available.')">
                        Deactivate Account
                    </button>
                </div>

            </div>

            <!-- ===== RECENT ORDERS (Cart Items) ===== -->
            <div class="card card-orders">
                <div class="card-title-row">
                    <div class="card-title">
                        <i class="fas fa-shopping-bag"></i> Recent Orders
                    </div>
                    <a href="${pageContext.request.contextPath}/cart" class="view-all-link">VIEW ALL ORDERS <i class="fas fa-arrow-right"></i></a>
                </div>

                <table class="orders-table">
                    <thead>
                        <tr>
                            <th>PRODUCT</th>
                            <th>ORDER ID</th>
                            <th>DATE</th>
                            <th>STATUS</th>
                            <th>AMOUNT</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty cartItems}">
                                <c:forEach var="item" items="${cartItems}" varStatus="loop">
                                    <tr>
                                        <td class="product-cell">
                                            <div class="product-icon"><i class="fas fa-laptop"></i></div>
                                            <div class="product-details">
                                                <strong><c:out value="${item.name}"/></strong>
                                                <span>Qty: <c:out value="${item.quantity}"/></span>
                                            </div>
                                        </td>
                                        <td class="order-id-cell">#ORD-<c:out value="${profileUser.id}"/>0<c:out value="${item.cartId}"/></td>
                                        <td><fmt:formatDate value="${profileUser.createdAt}" pattern="MMM dd, yyyy"/></td>
                                        <td><span class="status-badge status-delivered">In Cart</span></td>
                                        <td class="amount-cell">$<fmt:formatNumber value="${item.totalPrice}" pattern="#,##0.00"/></td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="5" class="empty-orders">
                                        <i class="fas fa-inbox"></i> No orders yet. Start shopping!
                                    </td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>

        </main>
    </div>
</div>

<!-- ===== PASSWORD CHANGE MODAL ===== -->
<div id="passwordModal" class="modal-overlay">
    <div class="modal-content">
        <div class="modal-header">
            <h2><i class="fas fa-lock"></i> Change Password</h2>
            <button type="button" class="modal-close" onclick="document.getElementById('passwordModal').classList.remove('active')">&times;</button>
        </div>
        <form action="${pageContext.request.contextPath}/profile" method="post">
            <input type="hidden" name="action" value="changePassword"/>
            <div class="form-group">
                <label>CURRENT PASSWORD</label>
                <input type="password" name="currentPassword" placeholder="Enter current password" required/>
            </div>
            <div class="form-group">
                <label>NEW PASSWORD</label>
                <input type="password" name="newPassword" placeholder="Min. 6 characters" required minlength="6"/>
            </div>
            <div class="form-group">
                <label>CONFIRM NEW PASSWORD</label>
                <input type="password" name="confirmPassword" placeholder="Re-enter new password" required minlength="6"/>
            </div>
            <div class="modal-actions">
                <button type="submit" class="btn-save">Update Password</button>
                <button type="button" class="btn-discard" onclick="document.getElementById('passwordModal').classList.remove('active')">Cancel</button>
            </div>
        </form>
    </div>
</div>

<%@ include file="/WEB-INF/views/includes/footer.jsp" %>

</body>
</html>
