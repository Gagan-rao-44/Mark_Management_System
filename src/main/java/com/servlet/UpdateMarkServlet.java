// File: src/com/servlet/UpdateMarkServlet.java
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
 * Servlet for updating existing student marks.
 * Handles GET requests to retrieve a student's data for update,
 * and POST requests to perform the actual update.
 */
@WebServlet("/UpdateMarkServlet")
public class UpdateMarkServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private MarkDAO markDAO;

    public void init() {
        markDAO = new MarkDAO();
    }

    /**
     * Handles HTTP GET requests.
     * Used to fetch a student's current mark details based on StudentID
     * and display them in the update form (markupdate.jsp).
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String message = "";
        StudentMark studentMark = null;

        try {
            String studentIDParam = request.getParameter("studentID");
            if (studentIDParam != null && !studentIDParam.isEmpty()) {
                int studentID = Integer.parseInt(studentIDParam);
                studentMark = markDAO.getMarkById(studentID); // Fetch existing data

                if (studentMark == null) {
                    message = "No student found with ID: " + studentID;
                }
            }
        } catch (NumberFormatException e) {
            message = "Invalid Student ID format. Please enter a numeric value.";
            e.printStackTrace();
        } catch (Exception e) {
            message = "An error occurred while fetching student data: " + e.getMessage();
            e.printStackTrace();
        }

        request.setAttribute("studentMark", studentMark); // Pass the retrieved student data to JSP
        request.setAttribute("message", message);
        request.getRequestDispatcher("markupdate.jsp").forward(request, response);
    }

    /**
     * Handles HTTP POST requests for updating marks.
     * Retrieves updated form parameters, creates/updates a StudentMark object,
     * and calls DAO to update it.
     * Redirects to markupdate.jsp with a success/failure message.
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
            Date examDate = Date.valueOf(request.getParameter("examDate"));

            // Create a StudentMark object with updated data
            StudentMark updatedMark = new StudentMark(studentID, studentName, subject, marks, examDate);

            // Call DAO to update the mark
            if (markDAO.updateMark(updatedMark)) {
                message = "Mark updated successfully for Student ID: " + studentID;
                // After successful update, re-fetch the updated data to display on the form
                request.setAttribute("studentMark", markDAO.getMarkById(studentID));
            } else {
                message = "Failed to update mark. Student ID not found or an error occurred.";
            }
        } catch (NumberFormatException e) {
            message = "Invalid input for Student ID or Marks. Please enter numeric values.";
            e.printStackTrace();
        } catch (IllegalArgumentException e) {
            message = "Invalid date format. Please use YYYY-MM-DD.";
            e.printStackTrace();
        } catch (Exception e) {
            message = "An unexpected error occurred: " + e.getMessage();
            e.printStackTrace();
        }

        request.setAttribute("message", message);
        request.getRequestDispatcher("markupdate.jsp").forward(request, response);
    }
}
