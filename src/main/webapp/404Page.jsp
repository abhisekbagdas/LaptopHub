<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/404Page.css">
    <title>404 - Page Not Found</title>
</head>
<body>
<%@ include file="/WEB-INF/views/includes/navbar.jsp" %>

    <div class="error-container">
        <div class="scene-wrap" tabindex="0" aria-labelledby="error-title">

            <div class="error-content">
                <h1 id="error-title" class="error-title">404</h1>
                <h1 id="error-title" class="error-title">PAGE NOT FOUND</h1>
                <div class="error-buttons">
                    <a href="${pageContext.request.contextPath}/" class="btn btn-primary">Go Home</a>
                    <a href="javascript:history.back()" class="btn btn-secondary">Go Back</a>
                </div>
            </div>
        </div>
    </div>

<%--    <%@ include file="/WEB-INF/views/includes/footer.jsp" %>--%>
</body>
</html>
