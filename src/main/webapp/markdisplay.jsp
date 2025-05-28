<%-- File: WebContent/markdisplay.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.model.StudentMark" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Display Student Marks</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Inter', sans-serif;
            background-color: #f3f4f6;
            display: flex;
            justify-content: center;
            min-height: 100vh;
            padding: 2rem 1rem;
        }
        .container {
            background-color: #ffffff;
            padding: 2.5rem;
            border-radius: 1rem;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 900px;
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
            text-align: center;
        }
        .message.info {
            background-color: #e0f2fe;
            color: #0284c7;
            border: 1px solid #38bdf8;
        }
        .message.error {
            background-color: #fee2e2;
            color: #991b1b;
            border: 1px solid #ef4444;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 1.5rem;
        }
        th, td {
            border: 1px solid #e5e7eb;
            padding: 0.75rem;
            text-align: left;
        }
        th {
            background-color: #f9fafb;
            font-weight: 600;
            color: #374151;
            text-transform: uppercase;
            font-size: 0.875rem;
        }
        tr:nth-child(even) {
            background-color: #f3f4f6;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1 class="text-3xl font-bold text-gray-800 mb-6 text-center">Display Student Marks</h1>

        <%-- Search Form --%>
        <form action="DisplayMarksServlet" method="get" class="mb-8 p-4 border border-gray-200 rounded-lg bg-gray-50">
            <div class="flex flex-col sm:flex-row items-end">
                <div class="flex-grow w-full sm:w-auto mr-0 sm:mr-4 mb-4 sm:mb-0">
                    <label for="searchID" class="block font-semibold text-gray-700 mb-2">Search by Student ID (Leave empty to show all):</label>
                    <input type="number" id="searchID" name="searchID" class="form-input" placeholder="Enter Student ID">
                </div>
                <button type="submit" class="btn-primary w-full sm:w-auto py-2 px-4">Search / Show All</button>
            </div>
        </form>

        <%-- Display Message --%>
        <% String message = (String) request.getAttribute("message"); %>
        <% if (message != null && !message.isEmpty()) { %>
            <div class="message <%= message.contains("No mark found") || message.contains("Invalid") ? "error" : "info" %>">
                <%= message %>
            </div>
        <% } %>

        <%-- Display Marks Table --%>
        <% List<StudentMark> studentMarks = (List<StudentMark>) request.getAttribute("studentMarks"); %>
        <% if (studentMarks != null && !studentMarks.isEmpty()) { %>
            <div class="overflow-x-auto rounded-lg shadow-md mt-6">
                <table>
                    <thead>
                        <tr>
                            <th>Student ID</th>
                            <th>Student Name</th>
                            <th>Subject</th>
                            <th>Marks</th>
                            <th>Exam Date</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (StudentMark mark : studentMarks) { %>
                            <tr>
                                <td><%= mark.getStudentID() %></td>
                                <td><%= mark.getStudentName() %></td>
                                <td><%= mark.getSubject() %></td>
                                <td><%= mark.getMarks() %></td>
                                <td><%= mark.getExamDate() %></td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        <% } else if (message == null || message.isEmpty() || (message != null && !message.contains("No mark found") && !message.contains("Invalid"))) { %>
            <%-- Only show this if no specific message or if it's not an error/not found message --%>
            <p class="text-center text-gray-600 mt-4">No marks to display. Use the search bar or add new marks.</p>
        <% } %>

        <div class="flex justify-center mt-8">
            <a href="index.jsp" class="btn-secondary flex items-center justify-center">Back to Home</a>
        </div>
    </div>
</body>
</html>
