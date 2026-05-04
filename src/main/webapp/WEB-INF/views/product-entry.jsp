<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<html>
<head>
    <title>Product Entry</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/main.css"/>
</head>
<body>
<%@ include file="/WEB-INF/views/includes/navbar.jsp" %>

<h1>Add Product</h1>

<c:if test="${not empty error}">
    <p class="error">${error}</p>
</c:if>

<form method="post" action="${pageContext.request.contextPath}/products?action=create">
    <div>
        <label for="name">Name</label>
        <input type="text" id="name" name="name" required />
    </div>
    <div>
        <label for="description">Description</label>
        <textarea id="description" name="description" rows="4" required></textarea>
    </div>
    <div>
        <label for="price">Price</label>
        <input type="number" id="price" name="price" step="0.01" min="0.01" required />
    </div>
    <div>
        <label for="image">Image URL</label>
        <input type="text" id="image" name="image" />
    </div>
    <button type="submit">Create Product</button>
</form>

<%@ include file="/WEB-INF/views/includes/footer.jsp" %>
</body>
</html>

