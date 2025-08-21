<%@ page import="java.util.List"%>
<%@ page import="com.example.demo.model.Customer" %>
<%
    List<Customer> customers = (List<Customer>) request.getAttribute("customers");
%>
<%!
    // Declare the method in a JSP declaration block, not a scriptlet
    public double computeBill(int units) {
        if (units <= 50) return units * 5;
        if (units <= 100) return 50 * 5 + (units - 50) * 7;
        return 50 * 5 + 50 * 7 + (units - 100) * 10;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Customers</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-sky-50">
<div class="p-6 flex justify-between bg-sky-700 text-white">
    <h1 class="text-xl font-bold">Customers</h1>
    <div>
        <a href="<%=request.getContextPath()%>/dashboards/admin-dashboard.jsp" class="px-3 py-1 bg-sky-800 rounded">Dashboard</a>
        <a href="<%=request.getContextPath()%>/customers?action=new" class="px-3 py-1 bg-green-600 rounded">New</a>
    </div>
</div>

<div class="p-6">
    <form class="mb-4">
        <input class="border rounded p-2" name="q" placeholder="Search name/account">
        <button class="bg-sky-700 text-white px-3 py-2 rounded">Search</button>
    </form>

    <table class="min-w-full bg-white border">
        <thead class="bg-sky-100">
        <tr>
            <th class="p-2 border">Account</th>
            <th class="p-2 border">Name</th>
            <th class="p-2 border">Phone</th>
            <th class="p-2 border">Units</th>
            <th class="p-2 border">Bill Amount</th>
            <th class="p-2 border">Actions</th>
        </tr>
        </thead>
        <tbody>
        <% for (Customer c : customers) { %>
        <tr>
            <td class="p-2 border"><%= c.getAccountNumber() %></td>
            <td class="p-2 border"><%= c.getName() %></td>
            <td class="p-2 border"><%= c.getTelephone() %></td>
            <td class="p-2 border"><%= c.getUnitsConsumed() %></td>
            <td class="p-2 border">Rs. <%= String.format("%.2f", computeBill(c.getUnitsConsumed())) %></td>
            <td class="p-2 border">
                <a class="text-sky-700" href="<%=request.getContextPath()%>/customers?action=view&id=<%=c.getId()%>">View</a> |
                <a class="text-green-700" href="<%=request.getContextPath()%>/customers?action=edit&id=<%=c.getId()%>">Edit</a> |
                <form action="<%=request.getContextPath()%>/customers" method="post" style="display:inline">
                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" name="id" value="<%=c.getId()%>">
                    <button class="text-red-700" onclick="return confirm('Delete this customer?')">Delete</button>
                </form>
            </td>
        </tr>
        <% } %>
        </tbody>
    </table>
</div>
</body>
</html>
