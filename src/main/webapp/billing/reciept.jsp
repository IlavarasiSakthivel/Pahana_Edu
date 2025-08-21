<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.example.demo.model.Bill" %>
<%@ page import="com.example.demo.model.BillItem" %>

<%
    Bill bill = (Bill) request.getAttribute("bill");
    if (bill == null) {
        response.sendRedirect(request.getContextPath() + "/bills");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Receipt #${bill.id}</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        @media print {
            body {
                background: #fff !important;
            }
            .no-print {
                display: none !important;
            }
            .print-container {
                box-shadow: none !important;
                margin: 0 !important;
                padding: 0 !important;
            }
        }
    </style>
</head>
<body class="bg-sky-50">

<div class="p-6 flex justify-between bg-sky-700 text-white items-center no-print">
    <div>
        <h1 class="text-xl font-bold">Pahana Edu - Receipt</h1>
        <p>Bill ID: ${bill.id} | Date: ${bill.createdAt}</p>
    </div>
    <button onclick="window.print()" class="bg-sky-800 px-3 py-1 rounded hover:bg-sky-900">Print</button>
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

<div class="p-6 print-container">
    <div class="mb-4 print:block hidden">
        <h1 class="text-xl font-bold">Pahana Edu - Receipt</h1>
        <p>Bill ID: ${bill.id} | Date: ${bill.createdAt}</p>
    </div>
    <table class="min-w-full bg-white border">
        <thead class="bg-sky-100">
        <tr>
            <th class="p-2 border">Item</th>
            <th class="p-2 border">Qty</th>
            <th class="p-2 border">Unit Price</th>
            <th class="p-2 border">Line Total</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="bi" items="${bill.items}">
            <tr>
                <td class="p-2 border">${bi.itemName}</td>
                <td class="p-2 border">${bi.qty}</td>
                <td class="p-2 border">Rs. ${bi.unitPrice}</td>
                <td class="p-2 border">Rs. ${bi.lineTotal}</td>
            </tr>
        </c:forEach>
        </tbody>
        <tfoot>
        <tr>
            <td colspan="3" class="p-2 border text-right font-semibold">Total</td>
            <td class="p-2 border font-bold">Rs. ${bill.total}</td>
        </tr>
        </tfoot>
    </table>
</div>

</body>
</html>
