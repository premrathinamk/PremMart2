<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.rashik.premmart.util.HtmlUtil" %>
<%
    String roleParam = request.getParameter("role");
    String prefillEmail = "";
    String prefillPwd = "";
    if ("BUYER".equalsIgnoreCase(roleParam)) {
        prefillEmail = "buyer@premmart.com";
        prefillPwd = "buyer123";
    } else if ("SELLER".equalsIgnoreCase(roleParam)) {
        prefillEmail = "seller@premmart.com";
        prefillPwd = "seller123";
    } else if ("ADMIN".equalsIgnoreCase(roleParam)) {
        prefillEmail = "admin@premmart.com";
        prefillPwd = "admin123";
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - PremMart</title>
    <link rel="icon" href="data:,">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=20261009_1">
</head>
<body>

    <header class="navbar">
        <a href="${pageContext.request.contextPath}/" class="brand">PremMart</a>
        <nav>
            <ul class="nav-links">
                <li><a href="${pageContext.request.contextPath}/login.jsp" class="nav-link active">Login</a></li>
                <li><a href="${pageContext.request.contextPath}/register.jsp" class="nav-link">Register</a></li>
            </ul>
        </nav>
    </header>

    <main class="page">
        <div class="auth-card">
            <div class="auth-header">
                <span class="eyebrow">Welcome Back</span>
                <h2>Account Login</h2>
            </div>

            <%
                String error = request.getParameter("error");
                String success = request.getParameter("success");
                if (error != null) {
                    String safeError = HtmlUtil.escape(error);
            %>
                <div class="message error"><%= safeError %></div>
            <% } %>

            <%
                if (success != null) {
                    String safeSuccess = HtmlUtil.escape(success);
            %>
                <div class="message success"><%= safeSuccess %></div>
            <% } %>

            <!-- Quick Demo 1-Click Login -->
            <div style="margin-bottom: 1.25rem; padding: 0.75rem; background: #f8fafc; border: 1.5px solid #000; box-shadow: 2px 2px 0px #000;">
                <div style="font-size: 0.75rem; text-transform: uppercase; font-weight: 700; color: #1e293b; margin-bottom: 0.5rem; letter-spacing: 0.5px;">⚡ One-Click Demo Login:</div>
                <div style="display: flex; gap: 0.5rem; flex-wrap: wrap;">
                    <button type="button" onclick="fillAndSubmit('buyer@premmart.com', 'buyer123')" style="flex: 1; min-width: 80px; padding: 0.45rem 0.5rem; font-size: 0.8rem; cursor: pointer; border: 1.5px solid #000; background: #fff; font-weight: 700; text-transform: uppercase; transition: background 0.15s;" onmouseover="this.style.background='#000';this.style.color='#fff';" onmouseout="this.style.background='#fff';this.style.color='#000';">Buyer</button>
                    <button type="button" onclick="fillAndSubmit('seller@premmart.com', 'seller123')" style="flex: 1; min-width: 80px; padding: 0.45rem 0.5rem; font-size: 0.8rem; cursor: pointer; border: 1.5px solid #000; background: #fff; font-weight: 700; text-transform: uppercase; transition: background 0.15s;" onmouseover="this.style.background='#000';this.style.color='#fff';" onmouseout="this.style.background='#fff';this.style.color='#000';">Seller</button>
                    <button type="button" onclick="fillAndSubmit('admin@premmart.com', 'admin123')" style="flex: 1; min-width: 80px; padding: 0.45rem 0.5rem; font-size: 0.8rem; cursor: pointer; border: 1.5px solid #000; background: #fff; font-weight: 700; text-transform: uppercase; transition: background 0.15s;" onmouseover="this.style.background='#000';this.style.color='#fff';" onmouseout="this.style.background='#fff';this.style.color='#000';">Admin</button>
                </div>
            </div>

            <form id="loginForm" action="${pageContext.request.contextPath}/login" method="post">
                <div class="form-group">
                    <label for="email">Email or Username</label>
                    <input type="text" id="email" name="email" value="<%= prefillEmail %>" placeholder="buyer, seller, or email" required autocomplete="username">
                </div>

                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" value="<%= prefillPwd %>" placeholder="enter your password" required autocomplete="current-password">
                </div>

                <button type="submit" class="primary-button">Log In</button>
            </form>

            <div class="auth-footer">
                <p>Don't have an account? <a href="${pageContext.request.contextPath}/register.jsp">Register here</a></p>
            </div>
        </div>
    </main>

    <script>
        function fillAndSubmit(email, password) {
            document.getElementById('email').value = email;
            document.getElementById('password').value = password;
            document.getElementById('loginForm').submit();
        }
    </script>
</body>
</html>