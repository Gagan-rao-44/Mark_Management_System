<%-- File: WebContent/markupdate.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.model.StudentMark" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Student Mark</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Inter', sans-serif;
            background-color: #f3f4f6;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 1rem;
        }
        .container {
            background-color: #ffffff;
            padding: 2.5rem;
            border-radius: 1rem;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 600px;
        }
        .form-group {
            margin-bottom: 1.5rem;
        }
        .form-label {
            display: block;
            font-weight: 600;
            color: #374151;
            margin-bottom: 0.5rem;
        }
        .form-input {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid #d1d5db;
            border-radius: 0.5rem;
            font-size: 1rem;
            color: #4b5563;
        }
        .btn-primary {
            background-color: #4f46e5;
            color: white;
            padding: 0.75rem 1.5rem;
            border-radius: 0.5rem;
            font-weight: 600;
            transition: background-color 0.3s ease;
        }
        .btn-primary:hover {
            background-color: #4338ca;
        }
        .btn-secondary {
            background-color: #6b7280;
            color: white;
            padding: 0.75rem 1.5rem;
            border-radius: 0.5rem;
            font-weight: 600;
            transition: background-color 0.3s ease;
            margin-left: 1rem;
        }
        .btn-secondary:hover {
            background-color: #4b5563;
        }
        .message {
            margin-top: 1.5rem;
            padding: 1rem;
            border-radius: 0.5rem;
            font-weight: 500;
        }
        .message.success {
            background-color: #d1fae5;
            color: #065f46;
            border: 1px solid #34d399;
        }
        .message.error {
            background-color: #fee2e2;
            color: #991b1b;
            border: 1px solid #ef4444;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1 class="text-3xl font-bold text-gray-800 mb-6 text-center">Update Student Mark</h1>

        <%-- Display message from servlet --%>
        <% String message = (String) request.getAttribute("message"); %>
        <% if (message != null && !message.isEmpty()) { %>
            <div class="message <%= message.contains("successfully") ? "success" : "error" %>">
                <%= message %>
            </div>
        <% } %>

        <form action="UpdateMarkServlet" method="get" class="mb-8 p-4 border border-gray-200 rounded-lg bg-gray-50">
            <div class="form-group flex items-end">
                <div class="flex-grow mr-4">
                    <label for="searchID" class="form-label">Enter Student ID to Update:</label>
                    <input type="number" id="searchID" name="studentID" class="form-input" required min="1">
                </div>
                <button type="submit" class="btn-primary py-2 px-4">Search</button>
            </div>
        </form>

        <%-- Display update form if student data is found --%>
        <% StudentMark studentMark = (StudentMark) request.getAttribute("studentMark"); %>
        <% if (studentMark != null) { %>
            <h2 class="text-2xl font-semibold text-gray-700 mb-4 text-center">Edit Student Details</h2>
            <form action="UpdateMarkServlet" method="post">
                <div class="form-group">
                    <label for="studentID" class="form-label">Student ID:</label>
                    <input type="number" id="studentID" name="studentID" class="form-input bg-gray-100 cursor-not-allowed" value="<%= studentMark.getStudentID() %>" readonly>
                </div>
                <div class="form-group">
                    <label for="studentName" class="form-label">Student Name:</label>
                    <input type="text" id="studentName" name="studentName" class="form-input" value="<%= studentMark.getStudentName() %>" required>
                </div>
                <div class="form-group">
                    <label for="subject" class="form-label">Subject:</label>
                    <input type="text" id="subject" name="subject" class="form-input" value="<%= studentMark.getSubject() %>" required>
                </div>
                <div class="form-group">
                    <label for="marks" class="form-label">Marks:</label>
                    <input type="number" id="marks" name="marks" class="form-input" value="<%= studentMark.getMarks() %>" required min="0" max="100">
                </div>
                <div class="form-group">
                    <label for="examDate" class="form-label">Exam Date:</label>
                    <input type="date" id="examDate" name="examDate" class="form-input" value="<%= studentMark.getExamDate() %>" required>
                </div>
                <div class="flex justify-center mt-8">
                    <button type="submit" class="btn-primary">Update Mark</button>
                    <a href="index.jsp" class="btn-secondary flex items-center justify-center">Back to Home</a>
                </div>
            </form>
        <% } else if (message != null && !message.isEmpty() && !message.contains("successfully")) { %>
            <%-- Only show "No student found" message if no studentMark is present and it's not a success message --%>
            <p class="text-center text-gray-600 mt-4">Please enter a Student ID and click 'Search' to load details for update.</p>
        <% } %>
    </div>
</body>
</html>
