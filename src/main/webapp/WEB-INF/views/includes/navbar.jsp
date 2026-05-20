<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/main.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/navbar.css?v=<%= System.currentTimeMillis() %>">

<!-- GLOBAL SIDEBAR -->
<aside class="global-sidebar" id="mainSidebar">
    <!-- Sidebar Collapse Button -->
    <button class="sidebar-toggle-btn" onclick="toggleGlobalSidebar()" title="Toggle Sidebar">
        <i id="sidebar-toggle-icon" class="fas fa-chevron-left"></i>
    </button>

    <div class="sidebar-top">
        <div class="sidebar-logo">
            <span class="logo-badge">LaptopHub</span>
            <span class="logo-badge short">LH</span>
            <span class="logo-subtitle">Enterprise Portal</span>
        </div>
        <nav class="sidebar-nav">
            <a href="${pageContext.request.contextPath}/home" class="nav-item">
                <i class="fas fa-home"></i> <span>Home</span>
            </a>
            <a href="${pageContext.request.contextPath}/products" class="nav-item">
                <i class="fas fa-laptop"></i> <span>Products</span>
            </a>
            <a href="${pageContext.request.contextPath}/cart" class="nav-item">
                <i class="fas fa-shopping-cart"></i> <span>My Cart</span>
            </a>
            <a href="${pageContext.request.contextPath}/contact" class="nav-item">
                <i class="fas fa-envelope"></i> <span>Contact</span>
            </a>
            <a href="${pageContext.request.contextPath}/about-us" class="nav-item">
                <i class="fa-solid fa-users"></i> <span>About-Us</span>
            </a>
            <c:choose>
                <c:when test="${not empty sessionScope.user}">
                    <a href="${pageContext.request.contextPath}/profile" class="nav-item">
                        <i class="fas fa-user"></i> <span>Profile</span>
                    </a>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/login" class="nav-item" style="color: #4ade80;">
                        <i class="fas fa-sign-in-alt"></i> <span>Login / Sign Up</span>
                    </a>
                </c:otherwise>
            </c:choose>
        </nav>
    </div>

    <div class="sidebar-bottom">
        <c:choose>
            <c:when test="${not empty sessionScope.user}">
                <div class="sidebar-user">
                    <div class="sidebar-user-avatar">
                        <c:choose>
                            <c:when test="${not empty sessionScope.user.profileImage}">
                                <img src="${pageContext.request.contextPath}/${sessionScope.user.profileImage}" alt="Profile" />
                            </c:when>
                            <c:otherwise>
                                <c:out value="${sessionScope.user.username.substring(0,1).toUpperCase()}" />
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div class="sidebar-user-info">
                        <span class="sidebar-user-name"><c:out value="${sessionScope.user.username}" /></span>
                        <span class="sidebar-user-role">
                            <c:choose>
                                <c:when test="${isAdmin}">Admin</c:when>
                                <c:otherwise>User</c:otherwise>
                            </c:choose>
                        </span>
                    </div>
                </div>
                <a href="${pageContext.request.contextPath}/logout" class="logout-link" onclick="return confirm('Are you sure you want to logout?');">
                    <i class="fas fa-sign-out-alt"></i> <span>Logout</span>
                </a>
            </c:when>
        </c:choose>
    </div>
</aside>

<script>
    function toggleGlobalSidebar() {
        const sidebar = document.getElementById('mainSidebar');
        const icon = document.getElementById('sidebar-toggle-icon');
        const body = document.body;
        
        if (!sidebar) return;
        
        sidebar.classList.toggle('collapsed');
        body.classList.toggle('sidebar-collapsed');
        
        if (sidebar.classList.contains('collapsed')) {
            if (icon) icon.className = 'fas fa-chevron-right';
            localStorage.setItem('globalSidebarCollapsed', 'true');
        } else {
            if (icon) icon.className = 'fas fa-chevron-left';
            localStorage.setItem('globalSidebarCollapsed', 'false');
        }
    }

    document.addEventListener('DOMContentLoaded', () => {
        const isCollapsed = localStorage.getItem('globalSidebarCollapsed') === 'true';
        const sidebar = document.getElementById('mainSidebar');
        const icon = document.getElementById('sidebar-toggle-icon');
        const body = document.body;
        
        if (isCollapsed && sidebar) {
            sidebar.classList.add('collapsed');
            body.classList.add('sidebar-collapsed');
            if (icon) icon.className = 'fas fa-chevron-right';
        } else {
            // Default expanded
            body.classList.add('sidebar-expanded'); 
        }
        
        // Handle active nav item highlight
        const currentPath = window.location.pathname;
        const navLinks = document.querySelectorAll('.global-sidebar .nav-item');
        navLinks.forEach(link => {
            const linkHref = link.getAttribute('href');
            if (currentPath.endsWith(linkHref) || (linkHref.includes('/home') && currentPath === '${pageContext.request.contextPath}/')) {
                link.classList.add('active');
            }
        });
    });
</script>
