// File: src/com/servlet/DeleteMarkServlet.java
package com.servlet;

import com.dao.MarkDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Servlet for deleting student mark records.
 * Handles POST requests from markdelete.jsp.
 */
@WebServlet("/DeleteMarkServlet")
public class DeleteMarkServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private MarkDAO markDAO;

    public void init() {
        markDAO = new MarkDAO();
    }

    /**
     * Handles HTTP POST requests for deleting marks.
     * Retrieves StudentID from form parameters and calls DAO to delete the record.
     * Redirects to markdelete.jsp with a success/failure message.
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String message;
        try {
            // Retrieve StudentID from form
            int studentID = Integer.parseInt(request.getParameter("studentID"));

            // Call DAO to delete the mark
            if (markDAO.deleteMark(studentID)) {
                message = "Mark for Student ID: " + studentID + " deleted successfully.";
            } else {
                message = "Failed to delete mark. Student ID: " + studentID + " not found.";
            }
        } catch (NumberFormatException e) {
            message = "Invalid Student ID. Please enter a numeric value.";
            e.printStackTrace();
        } catch (Exception e) {
            message = "An unexpected error occurred: " + e.getMessage();
            e.printStackTrace();
        }

        // Set the message and forward back to the markdelete.jsp
        request.setAttribute("message", message);
        request.getRequestDispatcher("markdelete.jsp").forward(request, response);
    }

    /**
     * Handles HTTP GET requests.
     * For this servlet, GET requests might just display the form.
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("markdelete.jsp").forward(request, response);
    }
}
