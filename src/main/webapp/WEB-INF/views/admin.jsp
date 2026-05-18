<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="true" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <title>LaptopHub - Admin Dashboard</title>
        <!-- Premium Font -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap"
            rel="stylesheet">
        <!-- Chart.js -->
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

        <link rel="stylesheet"
            href="<%= request.getContextPath() %>/static/css/admin.css?v=<%= System.currentTimeMillis() %>" />
    </head>

    <body>
        <div id="notification"></div>

        <div class="admin-container">
            <!-- Sidebar -->
            <aside class="sidebar">
                <div class="sidebar-header">
                    <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                        stroke-linecap="round" stroke-linejoin="round" class="feather feather-monitor">
                        <rect x="2" y="3" width="20" height="14" rx="2" ry="2"></rect>
                        <line x1="8" y1="21" x2="16" y2="21"></line>
                        <line x1="12" y1="17" x2="12" y2="21"></line>
                    </svg>
                    LaptopHub Admin
                </div>
                <nav class="sidebar-nav">
                    <a href="#" class="nav-item active" onclick="switchView('dashboard', this)">
                        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                            stroke-width="2" style="margin-right: 12px;">
                            <rect x="3" y="3" width="7" height="7"></rect>
                            <rect x="14" y="3" width="7" height="7"></rect>
                            <rect x="14" y="14" width="7" height="7"></rect>
                            <rect x="3" y="14" width="7" height="7"></rect>
                        </svg>
                        Overview
                    </a>
                    <a href="#" class="nav-item" onclick="switchView('products', this)">
                        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                            stroke-width="2" style="margin-right: 12px;">
                            <path
                                d="M21 16V8a2 2 0 0 0-1-1.73l-7-4a2 2 0 0 0-2 0l-7 4A2 2 0 0 0 3 8v8a2 2 0 0 0 1 1.73l7 4a2 2 0 0 0 2 0l7-4A2 2 0 0 0 21 16z">
                            </path>
                            <polyline points="3.27 6.96 12 12.01 20.73 6.96"></polyline>
                            <line x1="12" y1="22.08" x2="12" y2="12"></line>
                        </svg>
                        Products
                    </a>
                    <a href="#" class="nav-item" onclick="switchView('users', this)">
                        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                            stroke-width="2" style="margin-right: 12px;">
                            <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path>
                            <circle cx="9" cy="7" r="4"></circle>
                            <path d="M23 21v-2a4 4 0 0 0-3-3.87"></path>
                            <path d="M16 3.13a4 4 0 0 1 0 7.75"></path>
                        </svg>
                        Customers
                    </a>
                    <a href="<%= request.getContextPath() %>/logout" class="nav-item"
                        style="margin-top: 20px; color: var(--danger);">
                        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                            stroke-width="2" style="margin-right: 12px;">
                            <path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"></path>
                            <polyline points="16 17 21 12 16 7"></polyline>
                            <line x1="21" y1="12" x2="9" y2="12"></line>
                        </svg>
                        Logout
                    </a>
                </nav>
            </aside>

            <!-- Main Content Area -->
            <main class="main-content">
                <!-- DASHBOARD VIEW -->
                <section id="view-dashboard" class="view-section active">
                    <div class="page-header">
                        <h1 class="page-title">Dashboard</h1>
                        <p class="page-subtitle">Your store's performance at a glance.</p>
                    </div>

                    <div class="kpi-grid">
                        <div class="kpi-card">
                            <div class="kpi-label">Gross Revenue</div>
                            <div class="kpi-value" id="kpi-revenue">Rs. 0</div>
                        </div>
                        <div class="kpi-card">
                            <div class="kpi-label">Gross Profit</div>
                            <div class="kpi-value" id="kpi-profit">Rs. 0</div>
                        </div>
                        <div class="kpi-card">
                            <div class="kpi-label">Total Orders</div>
                            <div class="kpi-value" id="kpi-orders">0</div>
                        </div>
                        <div class="kpi-card">
                            <div class="kpi-label">Total Customers</div>
                            <div class="kpi-value" id="kpi-users">0</div>
                        </div>
                    </div>

                    <div class="charts-grid">
                        <div class="chart-card">
                            <div
                                style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 16px;">
                                <h3 id="chart-title"
                                    style="margin: 0; font-size: 16px; font-weight: 600; color: var(--text-main);">
                                    Monthly Sales</h3>
                                <button id="back-to-monthly-btn"
                                    style="display: none; padding: 6px 14px; font-size: 12px; border-radius: 6px; border: 1px solid var(--border); background: var(--secondary); color: var(--text-main); cursor: pointer; font-weight: 500; transition: all 0.2s ease;">&larr;
                                    Back to Monthly View</button>
                            </div>
                            <canvas id="salesChart" height="100"></canvas>
                        </div>
                        <div class="card">
                            <div class="card-header">
                                <h3>Recent Transactions</h3>
                            </div>
                            <div class="table-responsive">
                                <table>
                                    <thead>
                                        <tr>
                                            <th>Order</th>
                                            <th>Customer</th>
                                            <th>Amount</th>
                                            <th>Status</th>
                                        </tr>
                                    </thead>
                                    <tbody id="recentTxBody">
                                        <!-- Populated dynamically -->
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>

                    <!-- Heatmap -->
                    <div class="heatmap-container">
                        <h3 style="margin: 0 0 16px 0; font-size: 16px;">Order Activity (Last 365 Days)</h3>
                        <div id="activity-heatmap" class="heatmap-grid"></div>
                    </div>
                </section>

                <!-- PRODUCTS VIEW -->
                <section id="view-products" class="view-section">
                    <div class="page-header"
                        style="display: flex; justify-content: space-between; align-items: center;">
                        <div>
                            <h1 class="page-title">Products</h1>
                            <p class="page-subtitle">Manage your inventory and laptops.</p>
                        </div>
                        <div style="display: flex; gap: 12px; align-items: center;">
                            <select id="productSort" class="form-control" style="width: auto; padding: 8px 12px;" onchange="sortProducts()">
                                <option value="idDesc">ID (Descending)</option>
                                <option value="idAsc">ID (Ascending)</option>
                                <option value="priceDesc">Highest Price</option>
                                <option value="priceAsc">Lowest Price</option>
                                <option value="stockDesc">Highest Stocks</option>
                                <option value="stockAsc">Lowest Stocks</option>
                            </select>
                            <button class="btn btn-primary" onclick="openModal('productModal')">Add Product</button>
                        </div>
                    </div>

                    <div class="card">
                        <div class="table-responsive">
                            <table>
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Image</th>
                                        <th>Product Name</th>
                                        <th>Price</th>
                                        <th>Stock</th>
                                        <th>Status</th>
                                        <th style="text-align: right;">Action</th>
                                    </tr>
                                </thead>
                                <tbody id="productTableBody">
                                    <!-- Populated dynamically -->
                                </tbody>
                            </table>
                        </div>
                    </div>
                </section>

                <!-- USERS VIEW -->
                <section id="view-users" class="view-section">
                    <div class="page-header">
                        <h1 class="page-title">Customers</h1>
                        <p class="page-subtitle">View and manage registered users.</p>
                    </div>

                    <div class="card">
                        <div class="table-responsive">
                            <table>
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Username</th>
                                        <th>Email</th>
                                        <th>Role</th>
                                        <th>Registered</th>
                                        <th style="text-align: right;">Action</th>
                                    </tr>
                                </thead>
                                <tbody id="userTableBody">
                                    <!-- Populated dynamically -->
                                </tbody>
                            </table>
                        </div>
                    </div>
                </section>
            </main>
        </div>

        <!-- Modals -->
        <div id="productModal" class="modal-overlay">
            <div class="modal">
                <div class="modal-header">
                    <h3 id="modalTitle">Add New Product</h3>
                    <button class="close-modal" onclick="closeModal('productModal')">&times;</button>
                </div>
                <!-- enctype multipart to allow file upload -->
                <form id="addProductForm" enctype="multipart/form-data">
                    <input type="hidden" id="prodId">
                    <div class="form-group">
                        <label>Brand Name</label>
                        <input type="text" id="prodBrand" name="brand" class="form-control" placeholder="e.g., Dell, HP" required>
                    </div>
                    <div class="form-group">
                        <label>Model Name</label>
                        <input type="text" id="prodName" name="name" class="form-control" placeholder="e.g., XPS 15" required>
                    </div>
                    <div class="form-group">
                        <label>Description</label>
                        <textarea id="prodDesc" name="description" class="form-control" placeholder="Product details..." rows="3"></textarea>
                    </div>
                    <div class="form-group" style="display: flex; gap: 16px;">
                        <div style="flex: 1;">
                            <label>Price (Rs.)</label>
                            <input type="number" id="prodPrice" name="price" class="form-control" step="0.01" placeholder="0.00" required>
                        </div>
                        <div style="flex: 1;">
                            <label>Initial Stock</label>
                            <input type="number" id="prodStock" name="stock" class="form-control" placeholder="10" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <label>Product Image</label>
                        <input type="file" id="prodImage" name="image" class="form-control" accept="image/*">
                        <small id="imgHelp" style="color: var(--text-muted); display: none;">Leave empty to keep current image.</small>
                    </div>
                    <div style="display: flex; justify-content: flex-end; gap: 12px; margin-top: 24px;">
                        <button type="button" class="btn" onclick="closeModal('productModal')">Cancel</button>
                        <button type="submit" class="btn btn-primary" id="saveProdBtn">Save Product</button>
                    </div>
                </form>
            </div>
        </div>

        <script>
            const contextPath = '<%= request.getContextPath() %>';
            let allProducts = [];

            // UI Helpers
            function showNotification(message, isError = false) {
                const notif = document.getElementById('notification');
                notif.textContent = message;
                if (isError) notif.classList.add('error');
                else notif.classList.remove('error');
                notif.style.display = 'block';
                setTimeout(() => notif.style.display = 'none', 3000);
            }

            function switchView(viewName, el) {
                document.querySelectorAll('.view-section').forEach(sec => sec.classList.remove('active'));
                document.querySelectorAll('.nav-item').forEach(nav => nav.classList.remove('active'));
                document.getElementById('view-' + viewName).classList.add('active');
                if (el) el.classList.add('active');

                if (viewName === 'products') loadProducts();
                if (viewName === 'users') loadUsers();
                if (viewName === 'dashboard') loadDashboard();
            }

            function openModal(id, isEdit = false, product = null) { 
                const modal = document.getElementById(id);
                const form = document.getElementById('addProductForm');
                
                if (isEdit && product) {
                    document.getElementById('modalTitle').innerText = 'Edit Product';
                    document.getElementById('prodId').value = product.id;
                    document.getElementById('prodName').value = product.name;
                    document.getElementById('prodBrand').value = ''; // Brand combined with name
                    document.getElementById('prodDesc').value = product.description || '';
                    document.getElementById('prodPrice').value = product.price;
                    document.getElementById('prodStock').value = product.stock;
                    document.getElementById('imgHelp').style.display = 'block';
                    document.getElementById('prodImage').removeAttribute('required');
                    
                    form.dataset.mode = 'edit';
                } else {
                    document.getElementById('modalTitle').innerText = 'Add New Product';
                    form.reset();
                    document.getElementById('prodId').value = '';
                    document.getElementById('imgHelp').style.display = 'none';
                    document.getElementById('prodImage').setAttribute('required', 'true');
                    form.dataset.mode = 'add';
                }
                
                modal.classList.add('active'); 
            }
            function closeModal(id) { document.getElementById(id).classList.remove('active'); }

            // Dashboard Analytics
            let salesChartInstance = null;
            let currentView = 'monthly';
            let monthlyData = [];

            function loadDailySalesForMonth(monthLabel) {
                const monthMap = { 'Jan': 1, 'Feb': 2, 'Mar': 3, 'Apr': 4, 'May': 5, 'Jun': 6, 'Jul': 7, 'Aug': 8, 'Sep': 9, 'Oct': 10, 'Nov': 11, 'Dec': 12 };
                const monthVal = monthMap[monthLabel] || 5;

                fetch(contextPath + '/admin/api/dailySales?month=' + monthVal)
                    .then(res => res.json())
                    .then(dailySales => {
                        currentView = 'daily';
                        document.getElementById('chart-title').innerText = 'Daily Sales - ' + monthLabel;
                        document.getElementById('back-to-monthly-btn').style.display = 'inline-block';

                        const dailyLabels = dailySales.map(item => item.date);
                        const dailySalesData = dailySales.map(item => item.sales);

                        salesChartInstance.data.labels = dailyLabels;
                        salesChartInstance.data.datasets[0].label = 'Daily Revenue (Rs.)';
                        salesChartInstance.data.datasets[0].data = dailySalesData;
                        salesChartInstance.data.datasets[0].pointRadius = 4;
                        salesChartInstance.data.datasets[0].pointHoverRadius = 6;
                        salesChartInstance.update();
                    });
            }

            document.getElementById('back-to-monthly-btn').addEventListener('click', () => {
                currentView = 'monthly';
                document.getElementById('chart-title').innerText = 'Monthly Sales';
                document.getElementById('back-to-monthly-btn').style.display = 'none';

                const labels = monthlyData.map(item => item.month);
                const sales = monthlyData.map(item => item.sales);

                salesChartInstance.data.labels = labels;
                salesChartInstance.data.datasets[0].label = 'Monthly Revenue (Rs.)';
                salesChartInstance.data.datasets[0].data = sales;
                salesChartInstance.data.datasets[0].pointRadius = 6;
                salesChartInstance.data.datasets[0].pointHoverRadius = 8;
                salesChartInstance.update();
            });

            function loadDashboard() {
                fetch(contextPath + '/admin/api/analytics')
                    .then(res => res.json())
                    .then(data => {
                        // KPIs
                        document.getElementById('kpi-revenue').innerText = 'Rs. ' + (data.metrics.revenue || 0).toLocaleString(undefined, { minimumFractionDigits: 2 });
                        document.getElementById('kpi-profit').innerText = 'Rs. ' + (data.metrics.grossProfit || 0).toLocaleString(undefined, { minimumFractionDigits: 2 });
                        document.getElementById('kpi-orders').innerText = data.metrics.totalOrders || 0;
                        document.getElementById('kpi-users').innerText = data.metrics.totalUsers || 0;

                        // Chart
                        monthlyData = data.monthlySales || [];
                        const labels = monthlyData.map(item => item.month);
                        const sales = monthlyData.map(item => item.sales);

                        currentView = 'monthly';
                        document.getElementById('chart-title').innerText = 'Monthly Sales';
                        document.getElementById('back-to-monthly-btn').style.display = 'none';

                        if (salesChartInstance) salesChartInstance.destroy();
                        const ctx = document.getElementById('salesChart').getContext('2d');
                        salesChartInstance = new Chart(ctx, {
                            type: 'line',
                            data: {
                                labels: labels,
                                datasets: [{
                                    label: 'Monthly Revenue (Rs.)',
                                    data: sales,
                                    borderColor: '#4f46e5',
                                    backgroundColor: 'rgba(79, 70, 229, 0.1)',
                                    borderWidth: 3,
                                    fill: true,
                                    tension: 0.4,
                                    pointBackgroundColor: '#4f46e5',
                                    pointBorderColor: '#ffffff',
                                    pointBorderWidth: 2,
                                    pointRadius: 6,
                                    pointHoverRadius: 8
                                }]
                            },
                            options: {
                                responsive: true,
                                onClick: (event, elements) => {
                                    if (elements.length > 0 && currentView === 'monthly') {
                                        const index = elements[0].index;
                                        const clickedMonth = labels[index];
                                        loadDailySalesForMonth(clickedMonth);
                                    }
                                },
                                plugins: {
                                    legend: { display: false },
                                    tooltip: {
                                        backgroundColor: '#1f2937',
                                        titleColor: '#f3f4f6',
                                        bodyColor: '#f3f4f6',
                                        padding: 12,
                                        borderColor: '#374151',
                                        borderWidth: 1,
                                        callbacks: {
                                            label: function (context) {
                                                return ' Revenue: Rs. ' + context.raw.toLocaleString();
                                            }
                                        }
                                    }
                                },
                                scales: {
                                    y: {
                                        beginAtZero: true,
                                        grid: { borderDash: [4, 4], color: 'rgba(229, 231, 235, 0.5)' },
                                        ticks: {
                                            callback: function (value) {
                                                if (value >= 1000) {
                                                    return 'Rs. ' + (value / 1000) + 'k';
                                                }
                                                return 'Rs. ' + value;
                                            }
                                        }
                                    },
                                    x: { grid: { display: false } }
                                }
                            }
                        });

                        // Recent Tx
                        const tbody = document.getElementById('recentTxBody');
                        tbody.innerHTML = '';
                        data.recentTransactions.forEach(tx => {
                            let badgeClass = tx.status === 'Delivered' ? 'success' : (tx.status === 'Shipped' ? 'info' : 'warning');
                            tbody.innerHTML += "<tr>" +
                                "<td>#" + tx.orderId + "</td>" +
                                "<td>" + tx.username + "</td>" +
                                "<td>Rs. " + tx.amount.toLocaleString() + "</td>" +
                                "<td><span class=\"badge " + badgeClass + "\">" + tx.status + "</span></td>" +
                                "</tr>";
                        });

                        // Heatmap (Last 365 Days)
                        renderHeatmap(data.heatmapData || []);
                    });
            }

            function renderHeatmap(data) {
                const grid = document.getElementById('activity-heatmap');
                grid.innerHTML = '';

                // Create a map for quick date lookup
                const dateMap = {};
                data.forEach(d => { dateMap[d.date] = d.count; });

                // Generate 365 cells (approx 52 weeks x 7 days)
                const today = new Date();
                for (let i = 364; i >= 0; i--) {
                    const date = new Date(today);
                    date.setDate(date.getDate() - i);
                    const dateStr = date.toISOString().split('T')[0];

                    const count = dateMap[dateStr] || 0;
                    let level = 0;
                    if (count > 0) level = 1;
                    if (count > 2) level = 2;
                    if (count > 5) level = 3;
                    if (count > 10) level = 4;

                    const cell = document.createElement('div');
                    cell.className = 'heatmap-cell';
                    cell.dataset.level = level;
                    cell.title = dateStr + ": " + count + " orders";
                    grid.appendChild(cell);
                }
            }

            // Products
            function loadProducts() {
                fetch(contextPath + '/admin/api/products')
                    .then(res => res.json())
                    .then(data => {
                        allProducts = data;
                        sortProducts(); // renders products sorted by selected option
                    });
            }

            function sortProducts() {
                const sortOpt = document.getElementById('productSort').value;
                let sorted = [...allProducts];
                
                if (sortOpt === 'idDesc') sorted.sort((a,b) => b.id - a.id);
                else if (sortOpt === 'idAsc') sorted.sort((a,b) => a.id - b.id);
                else if (sortOpt === 'priceDesc') sorted.sort((a,b) => b.price - a.price);
                else if (sortOpt === 'priceAsc') sorted.sort((a,b) => a.price - b.price);
                else if (sortOpt === 'stockDesc') sorted.sort((a,b) => b.stock - a.stock);
                else if (sortOpt === 'stockAsc') sorted.sort((a,b) => a.stock - b.stock);

                renderProducts(sorted);
            }

            function renderProducts(data) {
                const tbody = document.getElementById('productTableBody');
                tbody.innerHTML = '';
                data.forEach(p => {
                    let stockBadge = p.stock > 10 ? '<span class="badge success">In Stock</span>' :
                        (p.stock > 0 ? '<span class="badge warning">Low Stock</span>' : '<span class="badge danger">Out of Stock</span>');
                    
                    let imgSrc = p.image ? contextPath + '/' + p.image : contextPath + '/static/images/default.png';

                    tbody.innerHTML += "<tr>" +
                        "<td style=\"color: var(--text-muted);\">#" + p.id + "</td>" +
                        "<td><img src=\"" + imgSrc + "\" style=\"width:40px; height:40px; border-radius:6px; object-fit:cover;\"></td>" +
                        "<td style=\"font-weight: 500;\">" + p.name + "</td>" +
                        "<td>Rs. " + p.price.toLocaleString(undefined, { minimumFractionDigits: 2 }) + "</td>" +
                        "<td>" + p.stock + "</td>" +
                        "<td>" + stockBadge + "</td>" +
                        "<td style=\"text-align: right; white-space: nowrap;\">" +
                        "<button class=\"btn btn-secondary\" style=\"margin-right: 8px;\" onclick='editProduct(" + JSON.stringify(p) + ")'>Edit</button>" +
                        "<button class=\"btn btn-danger\" onclick=\"deleteProduct(" + p.id + ")\">Delete</button>" +
                        "</td>" +
                        "</tr>";
                });
            }

            document.getElementById('addProductForm').addEventListener('submit', function (e) {
                e.preventDefault();
                
                const formData = new FormData(this);
                const mode = this.dataset.mode || 'add';
                const endpoint = mode === 'edit' ? '/admin/api/editProduct' : '/admin/api/addProduct';
                
                // Add id if editing
                if (mode === 'edit') formData.append('id', document.getElementById('prodId').value);

                fetch(contextPath + endpoint, {
                    method: 'POST',
                    body: formData // Note: fetch sets correct multipart boundaries automatically
                }).then(res => res.json()).then(data => {
                    showNotification(data.message, !data.success);
                    if (data.success) {
                        closeModal('productModal');
                        this.reset();
                        loadProducts();
                    }
                });
            });
            
            function editProduct(p) {
                openModal('productModal', true, p);
            }

            function deleteProduct(id) {
                if (!confirm('Delete this product permanently?')) return;
                const fd = new URLSearchParams(); fd.append('id', id);
                fetch(contextPath + '/admin/api/deleteProduct', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                    body: fd
                }).then(res => res.json()).then(data => {
                    showNotification(data.message, !data.success);
                    if (data.success) loadProducts();
                });
            }

            // Users
            function loadUsers() {
                fetch(contextPath + '/admin/api/users')
                    .then(res => res.json())
                    .then(data => {
                        const tbody = document.getElementById('userTableBody');
                        tbody.innerHTML = '';
                        data.forEach(u => {
                            let roleBadge = u.role === 'admin' ? '<span class="badge info">Admin</span>' : '<span class="badge secondary">Customer</span>';
                            if (u.isBanned) roleBadge = '<span class="badge danger">Banned</span>';
                            
                            var actionBtns = "";
                            if (u.role !== 'admin') {
                                if (!u.isBanned) {
                                    actionBtns += "<button class=\"btn btn-warning\" style=\"margin-right: 8px;\" onclick=\"banUser(" + u.id + ")\">Ban</button>";
                                }
                                actionBtns += "<button class=\"btn btn-danger\" onclick=\"deleteUser(" + u.id + ")\">Delete</button>";
                            }
                            
                            var regDate = u.registered || 'N/A';
                            tbody.innerHTML += "<tr>" +
                                "<td style=\"color: var(--text-muted);\">#" + u.id + "</td>" +
                                "<td style=\"font-weight: 500;\">" + u.name + "</td>" +
                                "<td>" + u.email + "</td>" +
                                "<td>" + roleBadge + "</td>" +
                                "<td style=\"color: var(--text-muted);\">" + regDate + "</td>" +
                                "<td style=\"text-align: right; white-space: nowrap;\">" + actionBtns + "</td>" +
                                "</tr>";
                        });
                    });
            }

            function banUser(id) {
                if (!confirm('Ban this user? They will not be able to log in.')) return;
                const fd = new URLSearchParams(); fd.append('id', id);
                fetch(contextPath + '/admin/api/banUser', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                    body: fd
                }).then(res => res.json()).then(data => {
                    showNotification(data.message, !data.success);
                    if (data.success) loadUsers();
                });
            }

            function deleteUser(id) {
                if (!confirm('Delete this user permanently?')) return;
                const fd = new URLSearchParams(); fd.append('id', id);
                fetch(contextPath + '/admin/api/deleteUser', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                    body: fd
                }).then(res => res.json()).then(data => {
                    showNotification(data.message, !data.success);
                    if (data.success) loadUsers();
                });
            }

            // Init
            document.addEventListener('DOMContentLoaded', () => {
                loadDashboard();
            });
        </script>
    </body>

    </html>