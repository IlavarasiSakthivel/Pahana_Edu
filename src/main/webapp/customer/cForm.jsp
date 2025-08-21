<%@ page import="com.example.demo.model.Customer" %>
<%
    Customer c = (Customer) request.getAttribute("customer");
    boolean editing = c != null && c.getId() > 0;
%>
<!DOCTYPE html>
<html>
<head>
    <title><%= editing ? "Edit" : "New" %> Customer</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-sky-50">
<div class="p-6 bg-sky-700 text-white">
    <h1 class="text-xl font-bold"><%= editing ? "Edit" : "New" %> Customer</h1>
</div>

<form action="<%=request.getContextPath()%>/customers" method="post" class="p-6 grid gap-4 max-w-xl">
    <input type="hidden" name="action" value="save">
    <% if (editing) { %><input type="hidden" name="id" value="<%= c.getId() %>"><% } %>

    <label class="block">
        <span class="text-gray-700">Account Number</span>
        <input name="accountNumber" required value="<%= editing ? c.getAccountNumber() : "" %>"
               class="mt-1 w-full border p-2 rounded focus:ring-sky-500 focus:border-sky-500"/>
    </label>

    <label class="block">
        <span class="text-gray-700">Name</span>
        <input name="name" required value="<%= editing ? c.getName() : "" %>"
               class="mt-1 w-full border p-2 rounded"/>
    </label>

    <label class="block">
        <span class="text-gray-700">Address</span>
        <input name="address" value="<%= editing ? c.getAddress() : "" %>"
               class="mt-1 w-full border p-2 rounded"/>
    </label>

    <label class="block">
        <span class="text-gray-700">Telephone</span>
        <input name="telephone" value="<%= editing ? c.getTelephone() : "" %>"
               class="mt-1 w-full border p-2 rounded"/>
    </label>

    <label class="block">
        <span class="text-gray-700">Units Consumed</span>
        <input type="number" name="unitsConsumed" min="0" value="<%= editing ? c.getUnitsConsumed() : 0 %>"
               class="mt-1 w-full border p-2 rounded"/>
    </label>

    <div class="flex gap-3">
        <button class="bg-sky-700 text-white px-4 py-2 rounded">Save</button>
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
        <a href="<%=request.getContextPath()%>/<%=dashboardUrl%>" class="bg-sky-800 text-white px-4 py-2 rounded shadow hover:bg-sky-900 transition">Cancel</a>
    </div>
</form>
</body>
</html>
