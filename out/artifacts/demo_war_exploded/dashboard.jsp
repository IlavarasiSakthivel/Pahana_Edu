<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f4f4f4; margin: 0; }
        .dashboard { max-width: 700px; margin: 40px auto; background: #fff; padding: 30px; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.1); }
        h1 { color: #333; }
        .section { margin-bottom: 20px; }
        .btn { display: inline-block; padding: 10px 20px; background: #007bff; color: #fff; border: none; border-radius: 4px; text-decoration: none; margin-right: 10px; }
        ul { padding-left: 20px; }
    </style>
</head>
<body>
    <div class="dashboard">
        <h1>Admin Dashboard</h1>
        <div class="section">
            <p>Welcome, Admin!</p>
        </div>
        <div class="section">
            <h2>Quick Actions</h2>
            <a class="btn" href="#">Manage Users</a>
            <a class="btn" href="#">View Reports</a>
            <a class="btn" href="#">Settings</a>
        </div>
        <div class="section">
            <h2>Statistics</h2>
            <ul>
                <li>Total Users: 120</li>
                <li>Active Sessions: 5</li>
                <li>Pending Requests: 3</li>
            </ul>
        </div>
    </div>
</body>
</html>

