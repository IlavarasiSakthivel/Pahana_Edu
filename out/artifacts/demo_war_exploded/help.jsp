<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Help - Pahana Edu</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body class="bg-gray-100">
<div class="flex min-h-screen">
    <!-- Sidebar -->
    <div class="bg-sky-800 text-white w-64">
        <div class="p-4 text-2xl font-bold">Pahana Edu</div>
        <nav class="mt-6">
            <a href="${pageContext.request.contextPath}/dashboard" class="block py-2.5 px-4 rounded hover:bg-sky-700">
                <i class="fas fa-tachometer-alt mr-2"></i>Dashboard
            </a>
            <a href="${pageContext.request.contextPath}/customers" class="block py-2.5 px-4 rounded hover:bg-sky-700">
                <i class="fas fa-users mr-2"></i>Customers
            </a>
            <a href="${pageContext.request.contextPath}/items" class="block py-2.5 px-4 rounded hover:bg-sky-700">
                <i class="fas fa-box mr-2"></i>Items
            </a>
            <a href="${pageContext.request.contextPath}/billing" class="block py-2.5 px-4 rounded hover:bg-sky-700">
                <i class="fas fa-file-invoice-dollar mr-2"></i>Billing
            </a>
            <a href="${pageContext.request.contextPath}/reports?type=sales" class="block py-2.5 px-4 rounded hover:bg-sky-700">
                <i class="fas fa-chart-bar mr-2"></i>Sales Report
            </a>
            <a href="${pageContext.request.contextPath}/reports?type=stock" class="block py-2.5 px-4 rounded hover:bg-sky-700">
                <i class="fas fa-warehouse mr-2"></i>Stock Report
            </a>
            <a href="${pageContext.request.contextPath}/help.jsp" class="block py-2.5 px-4 rounded bg-sky-700">
                <i class="fas fa-question-circle mr-2"></i>Help
            </a>
            <a href="${pageContext.request.contextPath}/auth/logout" class="block py-2.5 px-4 rounded hover:bg-sky-700">
                <i class="fas fa-sign-out-alt mr-2"></i>Logout
            </a>
        </nav>
    </div>

    <!-- Main Content -->
    <div class="flex-1 p-8">
        <h1 class="text-3xl font-bold text-sky-800 mb-6">Help & Support</h1>

        <div class="bg-white rounded-lg shadow p-6">
            <div class="space-y-6">
                <div>
                    <h2 class="text-xl font-semibold text-sky-700 mb-2">How to use the system</h2>
                    <p class="text-gray-700">This system is designed to manage customer accounts, items, and billing for Pahana Edu bookshop. Follow the guidelines below to use the system effectively.</p>
                </div>

                <div>
                    <h3 class="text-lg font-medium text-sky-700 mb-2">Customer Management</h3>
                    <ul class="list-disc pl-6 text-gray-700">
                        <li>To add a new customer, go to the Customers section and click "Add Customer".</li>
                        <li>Fill in the required details including account number, name, address, and telephone.</li>
                        <li>To edit or delete a customer, use the action buttons in the customer list.</li>
                    </ul>
                </div>

                <div>
                    <h3 class="text-lg font-medium text-sky-700 mb-2">Item Management</h3>
                    <ul class="list-disc pl-6 text-gray-700">
                        <li>To add new items, go to the Items section and click "Add Item".</li>
                        <li>Fill in the item details including name, description, price, and stock quantity.</li>
                        <li>To update or delete items, use the action buttons in the item list.</li>
                    </ul>
                </div>

                <div>
                    <h3 class="text-lg font-medium text-sky-700 mb-2">Billing</h3>
                    <ul class="list-disc pl-6 text-gray-700">
                        <li>To create a new bill, go to the Billing section and click "Create New Bill".</li>
                        <li>Select a customer from the dropdown list.</li>
                        <li>Add items to the bill by selecting an item and entering the quantity.</li>
                        <li>The system will automatically calculate the total amount.</li>
                        <li>Click "Create Bill" to generate the bill.</li>
                        <li>You can print the bill from the bill details page.</li>
                    </ul>
                </div>

                <div>
                    <h3 class="text-lg font-medium text-sky-700 mb-2">Reports</h3>
                    <ul class="list-disc pl-6 text-gray-700">
                        <li>Access various reports from the Reports section.</li>
                        <li>View sales reports, customer account summaries, and item stock reports.</li>
                    </ul>
                </div>

                <div>
                    <h3 class="text-lg font-medium text-sky-700 mb-2">Support</h3>
                    <p class="text-gray-700">For additional support, please contact the system administrator at admin@pahanaedu.com or call +94 11 234 5678.</p>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>