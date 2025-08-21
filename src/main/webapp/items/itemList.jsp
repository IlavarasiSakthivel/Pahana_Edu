<%@ page import="java.util.List"%>
<%@ page import="com.example.demo.model.Item" %>

<%
    List<Item> items = (List<Item>) request.getAttribute("items");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Items</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-sky-50">
<div class="p-6 flex justify-between bg-sky-700 text-white">
    <h1 class="text-xl font-bold">Items</h1>
    <div>
        <%
            // Get user role from session (assumes it's set as "role" or use loggedUser)
            String role = (String) session.getAttribute("role");
            if (role == null) {
                com.example.demo.model.User loggedUser = (com.example.demo.model.User) session.getAttribute("loggedUser");
                if (loggedUser != null) {
                    role = loggedUser.getRole();
                }
            }
            String dashboardUrl = "admin_dashboard.jsp";
            if (role != null && (role.equalsIgnoreCase("MANAGER") || role.equalsIgnoreCase("CASHIER"))) {
                dashboardUrl = "staff_dashboard.jsp";
            }
        %>
        <a href="<%=request.getContextPath()%>/<%=dashboardUrl%>" class="bg-sky-800 px-4 py-2 rounded shadow hover:bg-sky-900 transition">Dashboard</a>
        <a href="<%=request.getContextPath()%>/items?action=new" class="px-3 py-1 bg-green-600 rounded">New</a>
    </div>
</div>

<div class="p-6">
    <form class="mb-4">
        <input class="border rounded p-2" name="q" placeholder="Search item">
        <button class="bg-sky-700 text-white px-3 py-2 rounded">Search</button>
    </form>

    <table class="min-w-full bg-white border">
        <thead class="bg-sky-100">
        <tr>
            <th class="p-2 border">Name</th><th class="p-2 border">Price</th>
            <th class="p-2 border">Stock</th><th class="p-2 border">Actions</th>
        </tr>
        </thead>
        <tbody>
        <% if (items != null) {
            for (Item it : items) { %>
        <tr>
            <td class="p-2 border"><%= it.getName() %></td>
            <td class="p-2 border">Rs. <%= it.getPrice() %></td>
            <td class="p-2 border"><%= it.getStock() %></td>
            <td class="p-2 border">
                <a class="text-green-700" href="<%=request.getContextPath()%>/items?action=edit&id=<%=it.getId()%>">Edit</a> |
                <form action="<%=request.getContextPath()%>/items" method="post" style="display:inline">
                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" name="id" value="<%=it.getId()%>">
                    <button class="text-red-700" onclick="return confirm('Delete this item?')">Delete</button>
                </form>
            </td>
        </tr>
        <%   }
           } else { %>
        <tr><td colspan="4" class="p-2 border text-center text-gray-500">No items found.</td></tr>
        <% } %>
        </tbody>
    </table>
</div>
</body>
</html>
