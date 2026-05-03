<%-- Created by IntelliJ IDEA. User: Abhisek Date: 4/7/2026 Time: 1:01 PM To change this template use File | Settings |
  File Templates. --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>

<head>
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/main.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/header.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/admin.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/footer.css" />
    <style>
        #notification {
            display: none;
            position: fixed;
            top: 20px;
            right: 20px;
            padding: 15px;
            background: #4caf50;
            color: white;
            border-radius: 5px;
            z-index: 1000;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        #notification.error {
            background: #f44336;
        }
    </style>
</head>

<body>
<%@ include file="/WEB-INF/views/includes/navbar.jsp" %>

<div id="notification"></div>

<div class="hero">
    <h1>Admin Dashboard</h1>
</div>

<div id="Welcome">
    <p>
    <h1>Welcome to the Admin Dashboard!</h1>
    </p>
</div>

<div class="Products">
    <h2>Products</h2>
    <p style="margin-left: 20px">Manage your products here.</p>
    <div class="Product-Card">
        <form class="Form" id="addProductForm" aria-label="Add product">
            <label>Product name
                <input type="text" id="prodName" name="name" placeholder="e.g., Widget" required>
            </label>
            <label>Price
                <input type="number" id="prodPrice" name="price" step="0.01" placeholder="Rs.0.00" required>
            </label>
            <label>Stock
                <input type="number" id="prodStock" name="stock" placeholder="0" required>
            </label>
            <div class="Product-Actions">
                <button type="submit" class="add-product">Add Product</button>
            </div>
        </form>
    </div>
    <table class="product-list">
        <thead>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Price</th>
            <th>Stock</th>
            <th>Action</th>
        </tr>
        </thead>
        <tbody id="productTableBody">
        <!-- Products will be loaded here dynamically -->
        </tbody>
    </table>
</div>

<div class="user">
    <h2>Users</h2>
    <p style="margin-left: 20px">Manage your users here.</p>
    <div class="user-Card">
        <form class="Form" id="addUserForm" aria-label="Add user">
            <label>Name
                <input type="text" id="userName" name="name" placeholder="e.g., Abishek" required>
            </label>
            <label>Email
                <input type="email" id="userEmail" name="email" placeholder="e.g., example@example.com" required>
            </label>
            <label>Role
                <input type="text" id="userRole" name="role" placeholder="e.g., User" required>
            </label>
            <div class="User-Actions">
                <button type="submit" class="add-user">Add User</button>
            </div>
        </form>
    </div>
    <table class="product-list">
        <thead>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Email</th>
            <th>Role</th>
            <th>Action</th>
        </tr>
        </thead>
        <tbody id="userTableBody">
        <!-- Users will be loaded here dynamically -->
        </tbody>
    </table>
</div>

<%--FOOTER SECTION--%>
<%@ include file="/WEB-INF/views/includes/footer.jsp" %>

<script>
    const contextPath = '${pageContext.request.contextPath}';

    function showNotification(message, isError = false) {
        const notif = document.getElementById('notification');
        notif.textContent = message;
        if (isError) {
            notif.classList.add('error');
        } else {
            notif.classList.remove('error');
        }
        notif.style.display = 'block';
        setTimeout(() => {
            notif.style.display = 'none';
        }, 3000);
    }

    function loadProducts() {
        fetch(contextPath + '/admin/products')
            .then(res => res.json())
            .then(data => {
                const tbody = document.getElementById('productTableBody');
                tbody.innerHTML = '';
                data.forEach(p => {
                    const tr = document.createElement('tr');
                    tr.innerHTML =
                        '<td>' + p.id + '</td>' +
                        '<td>' + p.name + '</td>' +
                        '<td>Rs. ' + p.price.toFixed(2) + '</td>' +
                        '<td>' + p.stock + '</td>' +
                        '<td><button class="remove-product" onclick="removeProduct(' + p.id + ')">Remove</button></td>';
                    tbody.appendChild(tr);
                });
            })
            .catch(err => console.error(err));
    }

    document.getElementById('addProductForm').addEventListener('submit', function (e) {
        e.preventDefault();
        const name = document.getElementById('prodName').value.trim();
        const price = document.getElementById('prodPrice').value.trim();
        const stock = document.getElementById('prodStock').value.trim();

        if (!name || !price || !stock) {
            showNotification('Please fill all product fields', true);
            return;
        }

        const formData = new URLSearchParams();
        formData.append('name', name);
        formData.append('price', price);
        formData.append('stock', stock);

        fetch(contextPath + '/admin/addProduct', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: formData.toString()
        })
            .then(res => res.json())
            .then(data => {
                if (data.success) {
                    showNotification(data.message);
                    loadProducts();
                    document.getElementById('addProductForm').reset();
                } else {
                    showNotification(data.message, true);
                }
            })
            .catch(err => showNotification('Error adding product', true));
    });

    function removeProduct(id) {
        if (!confirm('Are you sure you want to remove this product?')) return;

        const formData = new URLSearchParams();
        formData.append('id', id);

        fetch(contextPath + '/admin/removeProduct', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: formData.toString()
        })
            .then(res => res.json())
            .then(data => {
                if (data.success) {
                    showNotification(data.message);
                    loadProducts();
                } else {
                    showNotification(data.message, true);
                }
            })
            .catch(err => showNotification('Error removing product', true));
    }

    function loadUsers() {
        fetch(contextPath + '/admin/users')
            .then(res => res.json())
            .then(data => {
                const tbody = document.getElementById('userTableBody');
                tbody.innerHTML = '';
                data.forEach(u => {
                    const tr = document.createElement('tr');
                    tr.innerHTML =
                        '<td>' + u.id + '</td>' +
                        '<td>' + u.name + '</td>' +
                        '<td>' + u.email + '</td>' +
                        '<td><span class="muted">' + u.role + '</span></td>' +
                        '<td><button class="remove-user" onclick="removeUser(' + u.id + ')">Remove</button></td>';
                    tbody.appendChild(tr);
                });
            })
            .catch(err => console.error(err));
    }

    document.getElementById('addUserForm').addEventListener('submit', function (e) {
        e.preventDefault();
        const name = document.getElementById('userName').value.trim();
        const email = document.getElementById('userEmail').value.trim();
        const role = document.getElementById('userRole').value.trim();

        if (!name || !email || !role) {
            showNotification('Please fill all user fields', true);
            return;
        }

        const formData = new URLSearchParams();
        formData.append('name', name);
        formData.append('email', email);
        formData.append('role', role);

        fetch(contextPath + '/admin/addUser', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: formData.toString()
        })
            .then(res => res.json())
            .then(data => {
                if (data.success) {
                    showNotification(data.message);
                    loadUsers();
                    document.getElementById('addUserForm').reset();
                } else {
                    showNotification(data.message, true);
                }
            })
            .catch(err => showNotification('Error adding user', true));
    });

    function removeUser(id) {
        if (!confirm('Are you sure you want to remove this user?')) return;

        const formData = new URLSearchParams();
        formData.append('id', id);

        fetch(contextPath + '/admin/removeUser', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: formData.toString()
        })
            .then(res => res.json())
            .then(data => {
                if (data.success) {
                    showNotification(data.message);
                    loadUsers();
                } else {
                    showNotification(data.message, true);
                }
            })
            .catch(err => showNotification('Error removing user', true));
    }

    document.addEventListener('DOMContentLoaded', () => {
        loadProducts();
        loadUsers();
    });
</script>
</body>

</html>