// File: src/com/servlet/ReportCriteriaServlet.java
package com.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Servlet for handling the selection of report criteria.
 * This servlet acts as an intermediary to show the correct report form (report_form.jsp)
 * based on the user's report type selection from reports.jsp.
 */
@WebServlet("/ReportCriteriaServlet")
public class ReportCriteriaServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * Handles HTTP GET requests.
     * Retrieves the 'reportType' parameter and forwards to report_form.jsp,
     * setting the report type as a request attribute.
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String reportType = request.getParameter("reportType");

        if (reportType == null || reportType.isEmpty()) {
            // If no report type is specified, redirect back to the main reports page
            response.sendRedirect("reports.jsp?message=Please select a report type.");
            return;
        }

        // Set the report type as a request attribute so report_form.jsp knows which fields to show
        request.setAttribute("reportType", reportType);
        request.getRequestDispatcher("report_form.jsp").forward(request, response);
    }

    /**
     * Handles HTTP POST requests.
     * For this servlet, POST is not typically used as it's just for displaying the form.
     * The actual report generation will be handled by ReportServlet.
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response); // Delegate POST to GET if needed, though not strictly necessary here.
    }
}
