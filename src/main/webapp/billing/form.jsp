<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Create Bill - Pahana Edu</title>
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
            <a href="${pageContext.request.contextPath}/billing" class="block py-2.5 px-4 rounded bg-sky-700">
                <i class="fas fa-file-invoice-dollar mr-2"></i>Billing
            </a>
            <a href="${pageContext.request.contextPath}/reports?type=sales" class="block py-2.5 px-4 rounded hover:bg-sky-700">
                <i class="fas fa-chart-bar mr-2"></i>Sales Report
            </a>
            <a href="${pageContext.request.contextPath}/reports?type=stock" class="block py-2.5 px-4 rounded hover:bg-sky-700">
                <i class="fas fa-warehouse mr-2"></i>Stock Report
            </a>
            <a href="${pageContext.request.contextPath}/help.jsp" class="block py-2.5 px-4 rounded hover:bg-sky-700">
                <i class="fas fa-question-circle mr-2"></i>Help
            </a>
            <a href="${pageContext.request.contextPath}/auth/logout" class="block py-2.5 px-4 rounded hover:bg-sky-700">
                <i class="fas fa-sign-out-alt mr-2"></i>Logout
            </a>
        </nav>
    </div>

    <!-- Main Content -->
    <div class="flex-1 p-8">
        <div class="flex justify-between items-center mb-6">
            <h1 class="text-3xl font-bold text-sky-800">Create New Bill</h1>
            <a href="${pageContext.request.contextPath}/billing"
               class="text-sky-700 hover:text-sky-900 flex items-center">
                <i class="fas fa-arrow-left mr-2"></i>Back to Billing
            </a>
        </div>

        <div class="bg-white rounded-lg shadow p-6">
            <% if (request.getAttribute("errorMessage") != null) { %>
            <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-4">
                <%= request.getAttribute("errorMessage") %>
            </div>
            <% } %>

            <form action="${pageContext.request.contextPath}/billing" method="post">
                <input type="hidden" name="action" value="create">

                <div class="grid grid-cols-1 gap-6">
                    <div>
                        <label for="customerAccountNumber" class="block text-sm font-medium text-gray-700">Customer</label>
                        <select id="customerAccountNumber" name="customerAccountNumber" required
                                class="mt-1 block w-full border border-gray-300 rounded-md shadow-sm py-2 px-3 focus:outline-none focus:ring-sky-500 focus:border-sky-500">
                            <option value="">Select a customer</option>
                            <c:forEach var="customer" items="${customers}">
                                <option value="${customer.accountNumber}">${customer.name} (${customer.accountNumber})</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div>
                        <label class="block text-sm font-medium text-gray-700">Items</label>
                        <div class="mt-1 space-y-4" id="items-container">
                            <div class="grid grid-cols-12 gap-4 items-center item-row">
                                <div class="col-span-5">
                                    <select name="itemId" class="item-select block w-full border border-gray-300 rounded-md shadow-sm py-2 px-3 focus:outline-none focus:ring-sky-500 focus:border-sky-500">
                                        <option value="">Select an item</option>
                                        <c:forEach var="item" items="${items}">
                                            <option value="${item.id}" data-price="${item.price}" data-stock="${item.stockQuantity}">${item.name} - Rs. ${item.price} (Stock: ${item.stockQuantity})</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="col-span-3">
                                    <input type="number" name="quantity" min="1" value="1" class="quantity-input block w-full border border-gray-300 rounded-md shadow-sm py-2 px-3 focus:outline-none focus:ring-sky-500 focus:border-sky-500">
                                </div>
                                <div class="col-span-3">
                                    <input type="text" readonly class="item-total block w-full border border-gray-300 rounded-md shadow-sm py-2 px-3 bg-gray-100" value="0.00">
                                </div>
                                <div class="col-span-1">
                                    <button type="button" class="remove-item-btn text-red-600 hover:text-red-800">
                                        <i class="fas fa-trash"></i>
                                    </button>
                                </div>
                            </div>
                        </div>
                        <button type="button" id="add-item-btn" class="mt-4 bg-sky-700 hover:bg-sky-800 text-white py-2 px-4 rounded">
                            <i class="fas fa-plus mr-2"></i>Add Item
                        </button>
                    </div>

                    <div class="flex justify-between items-center">
                        <div class="text-xl font-semibold">
                            Total: Rs. <span id="total-amount">0.00</span>
                        </div>
                        <div>
                            <button type="submit" class="bg-sky-700 hover:bg-sky-800 text-white py-2 px-4 rounded">
                                Create Bill
                            </button>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const itemsContainer = document.getElementById('items-container');
        const addItemBtn = document.getElementById('add-item-btn');
        const totalAmountSpan = document.getElementById('total-amount');

        // Function to calculate total
        function calculateTotal() {
            let total = 0;
            document.querySelectorAll('.item-row').forEach(row => {
                const itemSelect = row.querySelector('.item-select');
                const quantityInput = row.querySelector('.quantity-input');
                const itemTotalInput = row.querySelector('.item-total');

                if (itemSelect.value && quantityInput.value) {
                    const price = parseFloat(itemSelect.options[itemSelect.selectedIndex].dataset.price);
                    const quantity = parseInt(quantityInput.value);
                    const itemTotal = price * quantity;
                    itemTotalInput.value = itemTotal.toFixed(2);
                    total += itemTotal;
                } else {
                    itemTotalInput.value = '0.00';
                }
            });
            totalAmountSpan.textContent = total.toFixed(2);
        }

        // Add event listeners to existing elements
        itemsContainer.addEventListener('change', function(e) {
            if (e.target.classList.contains('item-select') || e.target.classList.contains('quantity-input')) {
                calculateTotal();

                // Check stock when item or quantity changes
                if (e.target.classList.contains('item-select') || e.target.classList.contains('quantity-input')) {
                    const row = e.target.closest('.item-row');
                    const itemSelect = row.querySelector('.item-select');
                    const quantityInput = row.querySelector('.quantity-input');

                    if (itemSelect.value && quantityInput.value) {
                        const stock = parseInt(itemSelect.options[itemSelect.selectedIndex].dataset.stock);
                        const quantity = parseInt(quantityInput.value);

                        if (quantity > stock) {
                            alert(`Only ${stock} items available in stock`);
                            quantityInput.value = stock;
                            calculateTotal();
                        }
                    }
                }
            }
        });

        // Add new item row
        addItemBtn.addEventListener('click', function() {
            const newRow = document.createElement('div');
            newRow.className = 'grid grid-cols-12 gap-4 items-center item-row';
            newRow.innerHTML = `
                <div class="col-span-5">
                    <select name="itemId" class="item-select block w-full border border-gray-300 rounded-md shadow-sm py-2 px-3 focus:outline-none focus:ring-sky-500 focus:border-sky-500">
                        <option value="">Select an item</option>
                        <c:forEach var="item" items="${items}">
                            <option value="${item.id}" data-price="${item.price}" data-stock="${item.stockQuantity}">${item.name} - Rs. ${item.price} (Stock: ${item.stockQuantity})</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-span-3">
                    <input type="number" name="quantity" min="1" value="1" class="quantity-input block w-full border border-gray-300 rounded-md shadow-sm py-2 px-3 focus:outline-none focus:ring-sky-500 focus:border-sky-500">
                </div>
                <div class="col-span-3">
                    <input type="text" readonly class="item-total block w-full border border-gray-300 rounded-md shadow-sm py-2 px-3 bg-gray-100" value="0.00">
                </div>
                <div class="col-span-1">
                    <button type="button" class="remove-item-btn text-red-600 hover:text-red-800">
                        <i class="fas fa-trash"></i>
                    </button>
                </div>
            `;
            itemsContainer.appendChild(newRow);
        });

        // Remove item row
        itemsContainer.addEventListener('click', function(e) {
            if (e.target.closest('.remove-item-btn')) {
                e.target.closest('.item-row').remove();
                calculateTotal();
            }
        });

        // Initial calculation
        calculateTotal();
    });
</script>
</body>
</html>