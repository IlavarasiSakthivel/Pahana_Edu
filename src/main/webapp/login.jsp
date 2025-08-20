<html>
<head><title>Login</title></head>
<body>
<h2>Login</h2>
<form action="login" method="post">
    Email: <input type="email" name="email" required><br/>
    Password: <input type="password" name="password" required><br/>
    <button type="submit">Login</button>
</form>
<% if (request.getParameter("error") != null) { %>
<p style="color:red;">Invalid email or password</p>
<% } %>
</body>
</html>
