<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/403Page.css">
    <title>403 - Access Forbidden</title>
    <style>

    </style>
</head>
<body>
<%--<%@ include file="/WEB-INF/views/includes/navbar.jsp" %>--%>

    <main class="error-page" role="main" aria-labelledby="error-title">
        <div class="error-container">
            <div class="scene-wrap" tabindex="0" aria-labelledby="error-title">
                <div class="error-content">
                    <p class="error-kicker">Access Denied</p>
                    <h1 id="error-title" class="error-title">403 - FORBIDDEN</h1>
                    <p class="error-message">This area is restricted. You don't have permission to access the admin panel.</p>

                    <div class="error-buttons">
                        <a href="${pageContext.request.contextPath}/" class="btn btn-primary">Go Home</a>
                        <a href="javascript:history.back()" class="btn btn-secondary">Go Back</a>
                    </div>
                </div>
            </div>
        </div>
    </main>

<%--<%@ include file="/WEB-INF/views/includes/footer.jsp" %>--%>

</body>
</html>