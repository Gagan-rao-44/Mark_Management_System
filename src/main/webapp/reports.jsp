<%-- File: WebContent/reports.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Generate Reports</title>
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
            text-align: center;
            width: 100%;
            max-width: 500px;
        }
        .report-link {
            display: block;
            background-color: #10b981; /* Green for reports */
            color: white;
            padding: 0.75rem 1.5rem;
            margin-bottom: 1rem;
            border-radius: 0.5rem;
            text-decoration: none;
            font-weight: 600;
            transition: background-color 0.3s ease;
        }
        .report-link:hover {
            background-color: #059669;
        }
        .btn-secondary {
            background-color: #6b7280;
            color: white;
            padding: 0.75rem 1.5rem;
            border-radius: 0.5rem;
            font-weight: 600;
            transition: background-color 0.3s ease;
            margin-top: 1rem;
            display: inline-block; /* To allow margin-top and proper alignment */
        }
        .btn-secondary:hover {
            background-color: #4b5563;
        }
        .message {
            margin-bottom: 1.5rem;
            padding: 1rem;
            border-radius: 0.5rem;
            font-weight: 500;
            background-color: #e0f2fe;
            color: #0284c7;
            border: 1px solid #38bdf8;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1 class="text-3xl font-bold text-gray-800 mb-6">Generate Reports</h1>

        <% String message = (String) request.getParameter("message"); %>
        <% if (message != null && !message.isEmpty()) { %>
            <div class="message">
                <%= message %>
            </div>
        <% } %>

        <nav class="space-y-4">
            <a href="ReportCriteriaServlet?reportType=marksAboveThreshold" class="report-link">Students with Marks Above a Value</a>
            <a href="ReportCriteriaServlet?reportType=marksBySubject" class="report-link">Students Scoring in a Specific Subject</a>
            <a href="ReportCriteriaServlet?reportType=topNStudents" class="report-link">Top N Students by Marks</a>
        </nav>
        <div class="flex justify-center mt-8">
            <a href="index.jsp" class="btn-secondary flex items-center justify-center">Back to Home</a>
        </div>
    </div>
</body>
</html>
