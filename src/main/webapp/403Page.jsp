<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>403 - Access Forbidden</title>
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

        header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            height: 4.5rem;
            padding: 4px 40px;
            background-color: #eef2f6;
            color: #1f2d3a;
            border-bottom: 1px solid #d4dde6;
            box-shadow: 0 2px 10px rgba(16, 26, 36, 0.08);
        }

        .logo {
            font-size: 1.5rem;
            font-weight: bold;
            color: #f18930;
            text-decoration: none;
        }

        .nav-links {
            display: flex;
            gap: 40px;
            list-style: none;
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
            background: linear-gradient(135deg, #d32f2f, #f18930);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            line-height: 1;
            margin-bottom: 20px;
            text-shadow: none;
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

        .error-details {
            background-color: #fff3cd;
            /*border-left: 4px solid #ffc107;*/
            padding: 15px;
            margin: 20px 0;
            border-radius: 4px;
            text-align: left;
            color: #856404;
            font-size: 14px;
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

        footer {
            background: #343434;
            padding: 50px 20px 20px;
            text-align: center;
            color: white;
            margin-top: auto;
        }

        .footer-bottom {
            background: #f18930;
            color: #343434;
            padding: 10px 0;
            margin-top: 30px;
        }
    </style>
</head>
<body>
<%@ include file="/WEB-INF/views/includes/navbar.jsp" %>

    <div class="error-container">
        <div class="error-content">
            <div class="error-code">403</div>
            <h1 class="error-title">Access Forbidden</h1>
            <p class="error-message">
                You don't have permission to access this resource.
            </p>
            <div class="error-details">
                <strong>⚠ Why am I seeing this?</strong><br>
                This could happen if:
                <ul style="margin-top: 8px; margin-left: 20px;">
                    <li>You're not logged in with the required permissions</li>
                    <li>Your account doesn't have access to this area</li>
                    <li>The resource has been restricted</li>
                </ul>
            </div>
            <div class="error-buttons">
                <a href="${pageContext.request.contextPath}/" class="btn btn-primary">Go Home</a>
                <a href="javascript:history.back()" class="btn btn-secondary">Go Back</a>
            </div>
        </div>
    </div>

    <%@ include file="/WEB-INF/views/includes/footer.jsp" %>
</body>
</html>
