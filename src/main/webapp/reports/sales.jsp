<%@ page import="java.math.BigDecimal"%>
<%
    String date = (String) request.getAttribute("date");
    BigDecimal total = (BigDecimal) request.getAttribute("total");
    java.util.List<com.example.demo.model.Bill> bills = (java.util.List<com.example.demo.model.Bill>) request.getAttribute("bills");
    // Calculate billCount from the bills list if not set
    Integer billCount = (Integer) request.getAttribute("billCount");
    if (billCount == null && bills != null) {
        billCount = bills.size();
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Sales Report</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-sky-50 min-h-screen">
<div class="p-6 bg-sky-700 text-white flex justify-between items-center shadow">
    <div>
        <h1 class="text-2xl font-bold tracking-wide">Daily Sales Report</h1>
        <p class="text-sky-100 text-sm mt-1">Overview of sales for a selected day</p>
    </div>
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
</div>

<div class="p-6 max-w-4xl mx-auto">
    <form method="get" class="mb-6 flex flex-wrap gap-3 items-end bg-white p-4 rounded shadow">
        <div>
            <label class="block text-gray-700 font-medium mb-1">Select Date</label>
            <input type="date" name="date" value="<%= date %>" class="border p-2 rounded w-48">
        </div>
        <button class="bg-sky-700 text-white px-6 py-2 rounded shadow hover:bg-sky-800 transition" formaction="<%=request.getContextPath()%>/reports/sales">View</button>
    </form>

    <div class="bg-white p-6 rounded shadow mb-8 flex flex-wrap gap-8 justify-between items-center">
        <div>
            <p class="text-gray-500">Date</p>
            <p class="text-xl font-semibold text-sky-700"><%= date != null ? date : "-" %></p>
        </div>
        <div>
            <p class="text-gray-500">Total Sales</p>
            <p class="text-2xl font-bold text-green-700">Rs. <%= total != null ? total : "0.00" %></p>
        </div>
        <div>
            <p class="text-gray-500">Number of Bills</p>
            <p class="text-xl font-semibold text-sky-700"><%= billCount != null ? billCount : 0 %></p>
        </div>
    </div>

    <div class="bg-white rounded shadow p-6">
        <h2 class="text-lg font-bold text-sky-700 mb-4">Bill Details</h2>
        <div class="overflow-x-auto">
            <table class="min-w-full border bg-white">
                <thead class="bg-sky-100">
                <tr>
                    <th class="p-2 border">Bill ID</th>
                    <th class="p-2 border">Customer</th>
                    <th class="p-2 border">Total Amount</th>
                    <th class="p-2 border">Cashier</th>
                    <th class="p-2 border">Time</th>
                </tr>
                </thead>
                <tbody>
                <% if (bills != null && !bills.isEmpty()) {
                    for (com.example.demo.model.Bill bill : bills) { %>
                <tr class="hover:bg-sky-50">
                    <td class="p-2 border text-center"><%= bill.getId() %></td>
                    <td class="p-2 border">
                        <%= bill.getCustomerAccountNumber() %>
                    </td>
                    <td class="p-2 border text-right">
                        Rs. <%= bill.getTotal() != null ? bill.getTotal() : "0.00" %>
                    </td>
                    <td class="p-2 border">
                        <%-- Show cashier id if available, else blank --%>
                        <%
                            // Try to get cashierId via reflection if not present in model
                            Object cashierId = null;
                            try {
                                java.lang.reflect.Method m = bill.getClass().getMethod("getCashierId");
                                cashierId = m.invoke(bill);
                            } catch (Exception e) {
                                cashierId = "";
                            }
                        %>
                        <%= cashierId != null ? cashierId : "" %>
                    </td>
                    <td class="p-2 border">
                        <%-- Show bill date or created at --%>
                        <%
                            Object billDate = null;
                            try {
                                java.lang.reflect.Method m = bill.getClass().getMethod("getBillDate");
                                billDate = m.invoke(bill);
                            } catch (Exception e) {
                                try {
                                    java.lang.reflect.Method m2 = bill.getClass().getMethod("getCreatedAt");
                                    billDate = m2.invoke(bill);
                                } catch (Exception ex) {
                                    billDate = "";
                                }
                            }
                        %>
                        <%= billDate != null ? billDate : "" %>
                    </td>
                </tr>
                <% }
                } else { %>
                <tr>
                    <td colspan="5" class="p-2 border text-center text-gray-500">No bills found for this date.</td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </div>
</div>
</body>
</html>
