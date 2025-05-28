<%-- File: WebContent/report_result.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.model.StudentMark" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Report Results</title>
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
        .message {
            margin-bottom: 1.5rem;
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
        .btn-secondary {
            background-color: #6b7280;
            color: white;
            padding: 0.75rem 1.5rem;
            border-radius: 0.5rem;
            font-weight: 600;
            transition: background-color 0.3s ease;
            margin-top: 1rem;
            display: inline-block;
        }
        .btn-secondary:hover {
            background-color: #4b5563;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1 class="text-3xl font-bold text-gray-800 mb-6 text-center">Report Results</h1>

        <%-- Display Report Message --%>
        <% String reportMessage = (String) request.getAttribute("reportMessage"); %>
        <% if (reportMessage != null && !reportMessage.isEmpty()) { %>
            <div class="message <%= reportMessage.contains("No records found") || reportMessage.contains("Invalid") || reportMessage.contains("Error") ? "error" : "info" %>">
                <%= reportMessage %>
            </div>
        <% } %>

        <%-- Display Report Table --%>
        <% List<StudentMark> reportResults = (List<StudentMark>) request.getAttribute("reportResults"); %>
        <% if (reportResults != null && !reportResults.isEmpty()) { %>
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
                        <% for (StudentMark mark : reportResults) { %>
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
        <% } else if (reportMessage == null || reportMessage.isEmpty() || (reportMessage != null && !reportMessage.contains("No records found") && !reportMessage.contains("Invalid") && !reportMessage.contains("Error"))) { %>
            <%-- Only show this if no specific message or if it's not an error/no records message --%>
            <p class="text-center text-gray-600 mt-4">No results to display for this report. Please adjust your criteria or add more data.</p>
        <% } %>

        <div class="flex justify-center mt-8">
            <a href="reports.jsp" class="btn-secondary flex items-center justify-center">Back to Reports Menu</a>
            <a href="index.jsp" class="btn-secondary flex items-center justify-center ml-4">Back to Home</a>
        </div>
    </div>
</body>
</html>
