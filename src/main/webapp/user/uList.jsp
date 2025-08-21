<%@ page import="java.util.List" %>
<%@ page import="com.example.demo.model.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%-- The servlet/controller should set request.setAttribute("users", users); --%>
<!DOCTYPE html>
<html>
<head>
    <title>User List</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-sky-50">
<div class="p-6 flex justify-between bg-sky-700 text-white">
    <h1 class="text-xl font-bold">User List</h1>
    <a href="<%=request.getContextPath()%>/register.jsp" class="px-3 py-1 bg-sky-800 rounded">Add User</a>
</div>
<div class="p-6 max-w-4xl mx-auto">
    <!-- Remove this warning after your servlet/controller sets the users attribute correctly -->
    <div class="bg-white rounded-lg shadow p-6">
        <div class="overflow-x-auto">
            <table class="min-w-full bg-white border">
                <thead class="bg-sky-100">
                <tr>
                    <th class="p-2 border">ID</th>
                    <th class="p-2 border">Username</th>
                    <th class="p-2 border">Email</th>
                    <th class="p-2 border">Role</th>
                    <th class="p-2 border">Actions</th>
                </tr>
                </thead>
                <tbody>
                <% if (users != null && !users.isEmpty()) {
                       for (User user : users) {
                %>
                <tr>
                    <td class="p-2 border"><%= user.getId() %></td>
                    <td class="p-2 border"><%= user.getUsername() %></td>
                    <td class="p-2 border"><%= user.getEmail() %></td>
                    <td class="p-2 border"><%= user.getRole() %></td>
                    <td class="p-2 border">
                        <a class="text-green-700" href="<%=request.getContextPath()%>/user?action=edit&id=<%=user.getId()%>">Edit</a> |
                        <form action="<%=request.getContextPath()%>/user" method="post" style="display:inline">
                            <input type="hidden" name="action" value="delete">
                            <input type="hidden" name="id" value="<%=user.getId()%>">
                            <button class="text-red-700" onclick="return confirm('Delete this user?')">Delete</button>
                        </form>
                    </td>
                </tr>
                <%
                       }
                   } else if (users != null) {
                %>
                <tr>
                    <td colspan="5" class="p-2 border text-center text-gray-500">No users found.</td>
                </tr>
                <% } %>
            </table>
        </div>
    </div>
</div>
</body>
</html>
