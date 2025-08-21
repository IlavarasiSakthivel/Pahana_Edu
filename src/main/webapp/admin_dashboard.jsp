<%@ page import="com.example.demo.model.User" %>
<%
    User u = (User) session.getAttribute("loggedUser");
    if (u == null) { response.sendRedirect(request.getContextPath()+"/index.jsp"); return; }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard - Pahana Edu</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
</head>
<body class="min-h-screen bg-gradient-to-br from-sky-200 via-white to-sky-400 flex relative overflow-hidden">
    <div class="absolute inset-0 pointer-events-none opacity-30 z-0"
         style="background: url('https://www.toptal.com/designers/subtlepatterns/uploads/symphony.png') repeat;"></div>
    <div class="flex w-full min-h-screen relative z-10">
        <!-- Sidebar -->
        <aside class="w-64 bg-white shadow-xl px-6 py-8 flex flex-col space-y-8">
            <div class="flex flex-col items-center mb-4">
        <span class="inline-block bg-sky-100 rounded-full p-4 shadow">
            <i class="fas fa-user-shield fa-2x text-sky-700"></i>
        </span>
                <h2 class="text-xl font-bold text-sky-700 mt-3">Admin Panel</h2>
            </div>

            <nav class="flex-1 space-y-2">
                <!-- Dashboard -->
                <a href="<%= request.getContextPath() %>/admin_dashboard.jsp"
                   class="flex items-center p-3 rounded-lg text-sky-700 font-semibold bg-sky-100 hover:bg-sky-200 transition">
                    <i class="fas fa-tachometer-alt mr-3"></i> Dashboard
                </a>

                <!-- Manage Users -->
                <div>
                    <button onclick="toggleDropdown('usersMenu')"
                            class="w-full flex items-center p-3 rounded-lg text-gray-700 hover:bg-gray-100 transition">
                        <i class="fas fa-users-cog mr-3"></i> Manage Users
                        <i class="fas fa-chevron-down ml-auto"></i>
                    </button>
                    <div id="usersMenu" class="hidden ml-6 mt-1 space-y-1">
                        <a href="<%= request.getContextPath() %>/auth/users.jsp" class="block px-3 py-2 rounded hover:bg-gray-100">User List</a>
                        <a href="<%= request.getContextPath() %>/auth/register.jsp" class="block px-3 py-2 rounded hover:bg-gray-100">Add User</a>
                    </div>
                </div>

                <!-- Customers -->
                <div>
                    <button onclick="toggleDropdown('customersMenu')"
                            class="w-full flex items-center p-3 rounded-lg text-gray-700 hover:bg-gray-100 transition">
                        <i class="fas fa-users mr-3"></i> Customers
                        <i class="fas fa-chevron-down ml-auto"></i>
                    </button>
                    <div id="customersMenu" class="hidden ml-6 mt-1 space-y-1">
                        <a href="<%= request.getContextPath() %>/customer/CList.jsp" class="block px-3 py-2 rounded hover:bg-gray-100">List</a>
                        <a href="<%= request.getContextPath() %>/customer/CForm.jsp" class="block px-3 py-2 rounded hover:bg-gray-100">Add New</a>
                        <a href="<%= request.getContextPath() %>/customer/CView.jsp" class="block px-3 py-2 rounded hover:bg-gray-100">View</a>
                    </div>
                </div>

                <!-- Items -->
                <div>
                    <button onclick="toggleDropdown('itemsMenu')"
                            class="w-full flex items-center p-3 rounded-lg text-gray-700 hover:bg-gray-100 transition">
                        <i class="fas fa-boxes mr-3"></i> Items
                        <i class="fas fa-chevron-down ml-auto"></i>
                    </button>
                    <div id="itemsMenu" class="hidden ml-6 mt-1 space-y-1">
                        <a href="<%= request.getContextPath() %>/items/itemList.jsp" class="block px-3 py-2 rounded hover:bg-gray-100">List</a>
                        <a href="<%= request.getContextPath() %>/items/itemForm.jsp" class="block px-3 py-2 rounded hover:bg-gray-100">Add Item</a>
                    </div>
                </div>

                <!-- Billing -->
                <div>
                    <button onclick="toggleDropdown('billingMenu')"
                            class="w-full flex items-center p-3 rounded-lg text-gray-700 hover:bg-gray-100 transition">
                        <i class="fas fa-receipt mr-3"></i> Billing
                        <i class="fas fa-chevron-down ml-auto"></i>
                    </button>
                    <div id="billingMenu" class="hidden ml-6 mt-1 space-y-1">
                        <a href="<%= request.getContextPath() %>/billing/list.jsp" class="block px-3 py-2 rounded hover:bg-gray-100">Bill List</a>
                        <a href="<%= request.getContextPath() %>/billing/new.jsp" class="block px-3 py-2 rounded hover:bg-gray-100">New Bill</a>
                        <a href="<%= request.getContextPath() %>/billing/reciept.jsp" class="block px-3 py-2 rounded hover:bg-gray-100">Receipts</a>
                    </div>
                </div>

                <!-- Reports -->
                <div>
                    <button onclick="toggleDropdown('reportsMenu')"
                            class="w-full flex items-center p-3 rounded-lg text-gray-700 hover:bg-gray-100 transition">
                        <i class="fas fa-chart-bar mr-3"></i> Reports
                        <i class="fas fa-chevron-down ml-auto"></i>
                    </button>
                    <div id="reportsMenu" class="hidden ml-6 mt-1 space-y-1">
                        <a href="<%= request.getContextPath() %>/reports/sales.jsp" class="block px-3 py-2 rounded hover:bg-gray-100">Sales</a>
                        <a href="<%= request.getContextPath() %>/reports/stock.jsp" class="block px-3 py-2 rounded hover:bg-gray-100">Stock</a>
                    </div>
                </div>

                <!-- Help -->
                <a href="<%= request.getContextPath() %>/help.jsp" class="flex items-center p-3 rounded-lg text-sky-700 hover:bg-sky-100 transition">
                    <i class="fas fa-question-circle mr-3"></i> Help
                </a>
            </nav>

            <!-- Logout -->
            <div class="mt-auto text-center">
                <a href="<%= request.getContextPath() %>/index.jsp" class="inline-flex items-center justify-center bg-sky-600 hover:bg-sky-700 text-white font-bold py-2 px-5 rounded shadow transition-all duration-200 w-full">
                    <i class="fas fa-sign-out-alt mr-2"></i> Logout
                </a>
            </div>
        </aside>

        <!-- Dropdown Toggle Script -->
        <script>
            function toggleDropdown(id) {
                document.getElementById(id).classList.toggle('hidden');
            }
        </script>
        <!-- Main content -->
        <main class="flex-1 flex flex-col px-8 py-12">
            <!-- Dashboard Header Navbar -->
            <div class="w-full bg-white bg-opacity-80 shadow-md rounded-xl mb-8 px-8 py-4 flex justify-between items-center">
                <h1 class="text-2xl md:text-3xl font-black text-sky-800 drop-shadow-lg">
                    Admin Dashboard
                </h1>
                <p class="text-lg text-gray-700">
                    Welcome, <%= u.getUsername() %> (<%= u.getRole() %>)
                </p>
            </div>
            <!-- Dashboard Cards -->
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                <!-- Users -->
                <div class="bg-white bg-opacity-80 rounded-2xl shadow-lg p-6 flex items-center space-x-4 hover:shadow-xl transition">
                    <span class="bg-sky-100 p-4 rounded-full text-sky-700">
                        <i class="fas fa-users-cog fa-lg"></i>
                    </span>
                    <div>
                        <h3 class="text-lg font-bold text-sky-800">Users</h3>
                        <p class="text-2xl font-black text-gray-700">120</p>
                    </div>
                </div>

                <!-- Customers -->
                <div class="bg-white bg-opacity-80 rounded-2xl shadow-lg p-6 flex items-center space-x-4 hover:shadow-xl transition">
                    <span class="bg-green-100 p-4 rounded-full text-green-700">
                        <i class="fas fa-users fa-lg"></i>
                    </span>
                    <div>
                        <h3 class="text-lg font-bold text-green-800">Customers</h3>
                        <p class="text-2xl font-black text-gray-700">340</p>
                    </div>
                </div>

                <!-- Items -->
                <div class="bg-white bg-opacity-80 rounded-2xl shadow-lg p-6 flex items-center space-x-4 hover:shadow-xl transition">
                    <span class="bg-purple-100 p-4 rounded-full text-purple-700">
                        <i class="fas fa-boxes fa-lg"></i>
                    </span>
                    <div>
                        <h3 class="text-lg font-bold text-purple-800">Items</h3>
                        <p class="text-2xl font-black text-gray-700">85</p>
                    </div>
                </div>

                <!-- Bills -->
                <div class="bg-white bg-opacity-80 rounded-2xl shadow-lg p-6 flex items-center space-x-4 hover:shadow-xl transition">
                    <span class="bg-yellow-100 p-4 rounded-full text-yellow-700">
                        <i class="fas fa-receipt fa-lg"></i>
                    </span>
                    <div>
                        <h3 class="text-lg font-bold text-yellow-800">Bills</h3>
                        <p class="text-2xl font-black text-gray-700">56</p>
                    </div>
                </div>

                <!-- Reports -->
                <div class="bg-white bg-opacity-80 rounded-2xl shadow-lg p-6 flex items-center space-x-4 hover:shadow-xl transition">
                    <span class="bg-red-100 p-4 rounded-full text-red-700">
                        <i class="fas fa-chart-bar fa-lg"></i>
                    </span>
                    <div>
                        <h3 class="text-lg font-bold text-red-800">Reports</h3>
                        <p class="text-2xl font-black text-gray-700">12</p>
                    </div>
                </div>
            </div>
        </main>
    </div>
</body>
</html>
