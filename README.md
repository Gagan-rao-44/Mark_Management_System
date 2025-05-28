# Mark_Management_System

**Subject Name**: Advanced Java

**Subject Code**: BCS613D

**Name**: Gagan

**USN**: 4AL22CS044

**Sem/Section**: VI / A

---
A web-based system developed using JSP, Servlets, and MySQL, following the MVC architecture. It provides an efficient and user-friendly platform to manage student marks, generate reports, and maintain academic records.

## 🚀 Key Features

**Full CRUD Functionality**: Add, update, delete, and view student marks

**Search Functionality**: Find student records via Student ID

**Dynamic Reports**:

Students scoring above a specified mark

Students filtered by subject

Top-N performing students

## 📋 Prerequisites
-**java Development Kit (JDK)**

-**Apache Tomcat Server – Version 9.0**

-**MySQL Server (or XAMPP with MySQL support)**

-**MySQL JDBC Driver (mysql-connector-java)**

-**Integrated Development Environment (IDE)**

-**Modern Web Browser**:Chrome

## 📦 Project Structure

MarkWebApp/
├── src/
│   ├── dao/
│   │   └── MarkDAO.java
│   ├── model/
│   │   └── StudentMark.java
│   └── servlet/
│       ├── AddMarkServlet.java
│       ├── UpdateMarkServlet.java
│       ├── DeleteMarkServlet.java
│       ├── DisplayMarksServlet.java
│       ├── ReportServlet.java
│       └── ReportCriteriaServlet.java
├── WebContent/
│   ├── index.jsp
│   ├── markadd.jsp
│   ├── markupdate.jsp
│   ├── markdelete.jsp
│   ├── markdisplay.jsp
│   ├── reports.jsp
│   ├── report_form.jsp
│   └── report_result.jsp
├── WEB-INF/
│   └── web.xml
└── README.md

## 🗄️ Database Configuration







