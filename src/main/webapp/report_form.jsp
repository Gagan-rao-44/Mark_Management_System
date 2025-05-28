<%-- File: WebContent/report_form.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Report Criteria</title>
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
            max-width: 500px;
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
        .btn-submit {
            background-color: #10b981; /* Green for reports */
            color: white;
            padding: 0.75rem 1.5rem;
            border-radius: 0.5rem;
            font-weight: 600;
            transition: background-color 0.3s ease;
        }
        .btn-submit:hover {
            background-color: #059669;
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
    </style>
</head>
<body>
    <div class="container">
        <h1 class="text-3xl font-bold text-gray-800 mb-6 text-center">Report Criteria</h1>

        <% String reportType = (String) request.getAttribute("reportType"); %>
        <form action="ReportServlet" method="post">
            <input type="hidden" name="reportType" value="<%= reportType %>">

            <% if ("marksAboveThreshold".equals(reportType)) { %>
                <h2 class="text-2xl font-semibold text-gray-700 mb-4 text-center">Students with Marks Above a Value</h2>
                <div class="form-group">
                    <label for="threshold" class="form-label">Minimum Marks:</label>
                    <input type="number" id="threshold" name="threshold" class="form-input" required min="0" max="100">
                </div>
            <% } else if ("marksBySubject".equals(reportType)) { %>
                <h2 class="text-2xl font-semibold text-gray-700 mb-4 text-center">Students Scoring in a Specific Subject</h2>
                <div class="form-group">
                    <label for="subject" class="form-label">Subject Name:</label>
                    <input type="text" id="subject" name="subject" class="form-input" required>
                </div>
            <% } else if ("topNStudents".equals(reportType)) { %>
                <h2 class="text-2xl font-semibold text-gray-700 mb-4 text-center">Top N Students by Marks</h2>
                <div class="form-group">
                    <label for="topN" class="form-label">Number of Top Students (N):</label>
                    <input type="number" id="topN" name="topN" class="form-input" required min="1">
                </div>
            <% } else { %>
                <p class="text-center text-gray-600">No report type selected or invalid report type. Please go back to reports menu.</p>
            <% } %>

            <div class="flex justify-center mt-8">
                <% if (reportType != null && !reportType.isEmpty()) { %>
                    <button type="submit" class="btn-submit">Generate Report</button>
                <% } %>
                <a href="reports.jsp" class="btn-secondary flex items-center justify-center">Back to Reports Menu</a>
            </div>
        </form>
    </div>
</body>
</html>
