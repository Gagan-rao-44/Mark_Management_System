// File: src/com/servlet/DisplayMarksServlet.java
package com.servlet;

import com.dao.MarkDAO;
import com.model.StudentMark;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * Servlet for displaying student mark records.
 * Handles GET requests to display all marks or search by StudentID.
 */
@WebServlet("/DisplayMarksServlet")
public class DisplayMarksServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private MarkDAO markDAO;

    public void init() {
        markDAO = new MarkDAO();
    }

    /**
     * Handles HTTP GET requests.
     * If a StudentID is provided, it searches for that specific student.
     * Otherwise, it retrieves and displays all student marks.
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<StudentMark> studentMarks = new ArrayList<>();
        String message = "";
        String searchIDParam = request.getParameter("searchID");

        try {
            if (searchIDParam != null && !searchIDParam.trim().isEmpty()) {
                // Search by StudentID
                int studentID = Integer.parseInt(searchIDParam);
                StudentMark studentMark = markDAO.getMarkById(studentID);
                if (studentMark != null) {
                    studentMarks.add(studentMark); // Add single result to list
                    message = "Displaying mark for Student ID: " + studentID;
                } else {
                    message = "No mark found for Student ID: " + studentID;
                }
            } else {
                // Display all marks
                studentMarks = markDAO.getAllMarks();
                if (studentMarks.isEmpty()) {
                    message = "No student marks available in the system.";
                } else {
                    message = "Displaying all student marks.";
                }
            }
        } catch (NumberFormatException e) {
            message = "Invalid Student ID for search. Please enter a numeric value.";
            e.printStackTrace();
        } catch (Exception e) {
            message = "An unexpected error occurred: " + e.getMessage();
            e.printStackTrace();
        }

        // Set the list of student marks and message as request attributes
        request.setAttribute("studentMarks", studentMarks);
        request.setAttribute("message", message);
        // Forward to markdisplay.jsp to render the results
        request.getRequestDispatcher("markdisplay.jsp").forward(request, response);
    }

    /**
     * Handles HTTP POST requests.
     * For this servlet, POST requests will typically be used for the search functionality
     * which is handled by doGet by redirecting (or can be directly handled here).
     * For simplicity, we'll just call doGet.
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response); // Delegate POST requests to doGet for search/display logic
    }
}
