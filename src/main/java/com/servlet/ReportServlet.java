// File: src/com/servlet/ReportServlet.java
package com.servlet;

import com.dao.MarkDAO;
import com.model.StudentMark;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.ArrayList;

/**
 * Servlet for generating various reports on student marks.
 * Handles POST requests from report_form.jsp based on the selected report type.
 */
@WebServlet("/ReportServlet")
public class ReportServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private MarkDAO markDAO;

    public void init() {
        markDAO = new MarkDAO();
    }

    /**
     * Handles HTTP POST requests for generating reports.
     * Retrieves report type and criteria, calls appropriate DAO methods,
     * and forwards results to report_result.jsp.
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String reportType = request.getParameter("reportType");
        List<StudentMark> reportResults = new ArrayList<>();
        String message = "";

        if (reportType == null || reportType.isEmpty()) {
            message = "Error: No report type specified.";
            request.setAttribute("message", message);
            request.getRequestDispatcher("report_result.jsp").forward(request, response);
            return;
        }

        try {
            switch (reportType) {
                case "marksAboveThreshold":
                    int threshold = Integer.parseInt(request.getParameter("threshold"));
                    reportResults = markDAO.getMarksAboveValue(threshold);
                    message = "Students with Marks Above " + threshold;
                    if (reportResults.isEmpty()) {
                        message += ": No records found.";
                    }
                    break;
                case "marksBySubject":
                    String subject = request.getParameter("subject");
                    reportResults = markDAO.getMarksBySubject(subject);
                    message = "Students who scored in Subject: '" + subject + "'";
                    if (reportResults.isEmpty()) {
                        message += ": No records found.";
                    }
                    break;
                case "topNStudents":
                    int topN = Integer.parseInt(request.getParameter("topN"));
                    reportResults = markDAO.getTopNStudents(topN);
                    message = "Top " + topN + " Students by Marks";
                    if (reportResults.isEmpty()) {
                        message += ": No records found.";
                    }
                    break;
                default:
                    message = "Invalid report type selected.";
                    break;
            }
        } catch (NumberFormatException e) {
            message = "Invalid numeric input for report criteria.";
            e.printStackTrace();
        } catch (Exception e) {
            message = "An unexpected error occurred while generating the report: " + e.getMessage();
            e.printStackTrace();
        }

        // Set results and message as request attributes
        request.setAttribute("reportResults", reportResults);
        request.setAttribute("reportMessage", message); // Use a different attribute name to avoid conflict with general messages

        // Forward to report_result.jsp to display the report
        request.getRequestDispatcher("report_result.jsp").forward(request, response);
    }

    /**
     * Handles HTTP GET requests.
     * For this servlet, GET requests are not directly supported for report generation.
     * Users should go through report_form.jsp first.
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("reports.jsp"); // Redirect to the main reports page
    }
}
