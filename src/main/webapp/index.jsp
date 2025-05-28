<%-- File: WebContent/index.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mark Management System</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap');
        body {
            font-family: 'Inter', sans-serif;
            /* New vibrant background: Soft Pink to Light Yellow gradient */
            background-color: #fbcfe8; /* Base for gradient start (Light Pink) */
            background-image: linear-gradient(to top, #fbcfe8 0%, #fef08a 100%); /* Light Pink to Light Yellow */
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 1rem;
        }
        .container {
            background-color: #ffffff;
            padding: 3rem;
            border-radius: 1.5rem; /* More rounded corners */
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.2); /* Stronger, more pronounced shadow */
            text-align: center;
            width: 100%;
            max-width: 550px;
            border: 1px solid #e2e8f0; /* Lighter, subtle border */
        }
        .nav-link {
            display: block;
            /* New vibrant button color: Deep Purple */
            background-color: #a855f7; /* A strong, appealing purple */
            color: white;
            padding: 1rem 2rem; /* Larger padding */
            margin-bottom: 1.25rem;
            border-radius: 0.75rem; /* More rounded buttons */
            text-decoration: none;
            font-weight: 700; /* Bolder text */
            font-size: 1.125rem; /* Larger font size */
            transition: background-color 0.3s ease, transform 0.2s ease, box-shadow 0.3s ease; /* Added box-shadow to transition */
            box-shadow: 0 4px 15px rgba(168, 85, 247, 0.4); /* Button shadow based on new color */
        }
        .nav-link:hover {
            /* Darker shade of purple on hover */
            background-color: #9333ea; /* Darker purple */
            transform: translateY(-3px); /* Slight lift effect */
            box-shadow: 0 8px 20px rgba(168, 85, 247, 0.6); /* Stronger shadow on hover */
        }
        .nav-link:last-child {
            margin-bottom: 0;
        }
        h1 {
            color: #1f2937; /* Dark gray for better contrast */
            text-shadow: 1px 1px 2px rgba(0,0,0,0.05); /* Subtle text shadow */
        }
    </style>
</head>
<body>
    <div class="container">
        <h1 class="text-5xl font-extrabold text-gray-900 mb-10 leading-tight">
            Mark Management <br class="sm:hidden"> System
        </h1>

        <nav class="space-y-5">
            <a href="markadd.jsp" class="nav-link">Add Student Mark</a>
            <a href="markupdate.jsp" class="nav-link">Update Student Mark</a>
            <a href="markdelete.jsp" class="nav-link">Delete Student Mark</a>
            <a href="DisplayMarksServlet" class="nav-link">Display All Marks / Search</a>
            <a href="reports.jsp" class="nav-link">Generate Reports</a>
        </nav>
    </div>
</body>
</html>
