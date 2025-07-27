<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<head>
    <title><%= request.getAttribute("title") != null ? request.getAttribute("title") : "My App" %></title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>