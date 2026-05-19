<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>404 - Page Not Found</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, Helvetica, sans-serif;
            background-color: #f5f7fa;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        .nav-links a {
            text-decoration: none;
            color: #1f2d3a;
            font-weight: 600;
            transition: color 0.3s;
        }

        .nav-links a:hover {
            color: #f18930;
        }

        .error-container {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 40px 20px;
        }

        .error-content {
            text-align: center;
            max-width: 600px;
        }

        .error-code {
            font-size: 120px;
            font-weight: bold;
            color: #f18930;
            line-height: 1;
            margin-bottom: 20px;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.1);
        }

        .error-title {
            font-size: 36px;
            color: #1f2d3a;
            margin-bottom: 15px;
            font-weight: 600;
        }

        .error-message {
            font-size: 18px;
            color: #555;
            margin-bottom: 30px;
            line-height: 1.6;
        }

        .error-buttons {
            display: flex;
            gap: 15px;
            justify-content: center;
            flex-wrap: wrap;
        }

        .btn {
            padding: 12px 30px;
            font-size: 16px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            transition: all 0.3s;
            font-weight: 600;
        }

        .btn-primary {
            background-color: #f18930;
            color: white;
        }

        .btn-primary:hover {
            background-color: #e07800;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(241, 137, 48, 0.3);
        }

        .btn-secondary {
            background-color: #eef2f6;
            color: #1f2d3a;
            border: 2px solid #d4dde6;
        }

        .btn-secondary:hover {
            background-color: #e3eaf1;
            border-color: #c0cad5;
        }

    </style>
</head>
<body>
<%@ include file="/WEB-INF/views/includes/navbar.jsp" %>

    <div class="error-container">
        <div class="error-content">
            <div class="error-code">404</div>
            <h1 class="error-title">Page Not Found</h1>
            <p class="error-message">
                Sorry, the page you're looking for doesn't exist. It might have been moved or deleted.
            </p>
            <div class="error-buttons">
                <a href="${pageContext.request.contextPath}/" class="btn btn-primary">Go Home</a>
                <a href="${pageContext.request.contextPath} /products" class="btn btn-secondary">Browse Products</a>
            </div>
        </div>
    </div>

    <%@ include file="/WEB-INF/views/includes/footer.jsp" %>
</body>
</html>
