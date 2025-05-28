// File: src/com/servlet/AddMarkServlet.java
package com.servlet;

import com.dao.MarkDAO;
import com.model.StudentMark;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date; // For java.sql.Date

/**
 * Servlet for adding new student marks.
 * Handles POST requests from markadd.jsp.
 */
@WebServlet("/AddMarkServlet") // Maps this servlet to the /AddMarkServlet URL
public class AddMarkServlet extends HttpServlet {
    private static final long serialVersionUID = 1L; // Recommended for servlets
    private MarkDAO markDAO;

    // Initialize the DAO when the servlet is created
    public void init() {
        markDAO = new MarkDAO();
    }

    /**
     * Handles HTTP POST requests for adding marks.
     * Retrieves form parameters, creates a StudentMark object, and calls DAO to add it.
     * Redirects to markadd.jsp with a success/failure message.
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String message;
        try {
            // Retrieve form parameters
            int studentID = Integer.parseInt(request.getParameter("studentID"));
            String studentName = request.getParameter("studentName");
            String subject = request.getParameter("subject");
            int marks = Integer.parseInt(request.getParameter("marks"));
            // Convert String date to java.sql.Date
            Date examDate = Date.valueOf(request.getParameter("examDate"));

            // Create a StudentMark object
            StudentMark newMark = new StudentMark(studentID, studentName, subject, marks, examDate);

            // Call DAO to add the mark
            if (markDAO.addMark(newMark)) {
                message = "Mark added successfully for Student ID: " + studentID;
            } else {
                message = "Failed to add mark. Student ID might already exist or an error occurred.";
            }
        } catch (NumberFormatException e) {
            message = "Invalid input for Student ID or Marks. Please enter numeric values.";
            e.printStackTrace();
        } catch (IllegalArgumentException e) { // Catches error from Date.valueOf if date format is wrong
            message = "Invalid date format. Please use YYYY-MM-DD.";
            e.printStackTrace();
        } catch (Exception e) {
            message = "An unexpected error occurred: " + e.getMessage();
            e.printStackTrace();
        }

        // Set the message as a request attribute to display on the JSP
        request.setAttribute("message", message);
        // Forward back to the markadd.jsp page to display the message
        request.getRequestDispatcher("markadd.jsp").forward(request, response);
    }

    /**
     * Handles HTTP GET requests.
     * For this servlet, GET requests might just display the form,
     * or it could be used for initial page load.
     * We'll just forward to markadd.jsp.
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("markadd.jsp").forward(request, response);
    }
}
