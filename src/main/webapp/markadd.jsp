<%-- File: WebContent/markadd.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Student Mark</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap');
        body {
            font-family: 'Inter', sans-serif;
            background-color: #f3f4f6;
            background-image: linear-gradient(to bottom, #f3f4f6 0%, #e2e8f0 100%);
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 1.5rem;
        }
        .container {
            background-color: #ffffff;
            padding: 3rem;
            border-radius: 1.5rem;
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 650px;
            border: 1px solid #e2e8f0;
        }
        .form-group {
            margin-bottom: 1.75rem;
        }
        .form-label {
            display: block;
            font-weight: 600;
            color: #374151;
            margin-bottom: 0.6rem;
            font-size: 1.05rem;
        }
        .form-input {
            width: 100%;
            padding: 0.9rem 1.2rem;
            border: 1px solid #cbd5e0;
            border-radius: 0.75rem;
            font-size: 1rem;
            color: #4b5563;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
        }
        .form-input:focus {
            border-color: #6366f1; /* Indigo focus */
            box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.2);
            outline: none;
        }
        .btn-primary {
            background-color: #4f46e5;
            color: white;
            padding: 0.9rem 2rem;
            border-radius: 0.75rem;
            font-weight: 700;
            font-size: 1.05rem;
            transition: background-color 0.3s ease, transform 0.2s ease, box-shadow 0.3s ease;
            box-shadow: 0 4px 10px rgba(79, 70, 229, 0.3);
        }
        .btn-primary:hover {
            background-color: #4338ca;
            transform: translateY(-2px);
            box-shadow: 0 6px 12px rgba(79, 70, 229, 0.4);
        }
        .btn-secondary {
            background-color: #6b7280;
            color: white;
            padding: 0.9rem 2rem;
            border-radius: 0.75rem;
            font-weight: 700;
            font-size: 1.05rem;
            transition: background-color 0.3s ease, transform 0.2s ease;
            margin-left: 1.5rem;
            box-shadow: 0 4px 10px rgba(107, 114, 128, 0.2);
        }
        .btn-secondary:hover {
            background-color: #4b5563;
            transform: translateY(-2px);
            box-shadow: 0 6px 12px rgba(107, 114, 128, 0.3);
        }
        .message {
            margin-top: 2rem;
            margin-bottom: 2rem;
            padding: 1.25rem;
            border-radius: 0.75rem;
            font-weight: 600;
            font-size: 1.05rem;
            text-align: center;
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
        <h1 class="text-4xl font-bold text-gray-900 mb-8 text-center">Add Student Mark</h1>

        <%-- Display message from servlet --%>
        <% String message = (String) request.getAttribute("message"); %>
        <% if (message != null && !message.isEmpty()) { %>
            <div class="message <%= message.contains("successfully") ? "success" : "error" %>">
                <%= message %>
            </div>
        <% } %>

        <form action="AddMarkServlet" method="post" class="mt-6">
            <div class="form-group">
                <label for="studentID" class="form-label">Student ID:</label>
                <input type="number" id="studentID" name="studentID" class="form-input" required min="1" placeholder="e.g., 101">
            </div>
            <div class="form-group">
                <label for="studentName" class="form-label">Student Name:</label>
                <input type="text" id="studentName" name="studentName" class="form-input" required placeholder="e.g., John Doe">
            </div>
            <div class="form-group">
                <label for="subject" class="form-label">Subject:</label>
                <input type="text" id="subject" name="subject" class="form-input" required placeholder="e.g., Mathematics">
            </div>
            <div class="form-group">
                <label for="marks" class="form-label">Marks:</label>
                <input type="number" id="marks" name="marks" class="form-input" required min="0" max="100" placeholder="e.g., 85">
            </div>
            <div class="form-group">
                <label for="examDate" class="form-label">Exam Date:</label>
                <input type="date" id="examDate" name="examDate" class="form-input" required>
            </div>
            <div class="flex justify-center mt-10 space-x-4">
                <button type="submit" class="btn-primary">Add Mark</button>
                <a href="index.jsp" class="btn-secondary flex items-center justify-center">Back to Home</a>
            </div>
        </form>
    </div>
</body>
</html>
