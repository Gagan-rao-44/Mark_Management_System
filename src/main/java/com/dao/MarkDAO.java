// File: src/com/dao/MarkDAO.java
package com.dao;

import com.model.StudentMark;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object (DAO) for StudentMark.
 * Handles all database operations related to student marks.
 */
public class MarkDAO {
    // Database connection parameters - REPLACE WITH YOUR ACTUAL DATABASE CREDENTIALS
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/structure"; // Replace with your DB name
    private static final String JDBC_USERNAME = "root"; // Replace with your DB username
    private static final String JDBC_PASSWORD = ""; // Replace with your DB password

    // Static block to load the JDBC driver
    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); // For MySQL 8.0+
            // For older MySQL versions, use "com.mysql.jdbc.Driver"
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            throw new RuntimeException("Failed to load JDBC driver.");
        }
    }

    /**
     * Establishes a database connection.
     *
     * @return A Connection object.
     * @throws SQLException If a database access error occurs.
     */
    private Connection getConnection() throws SQLException {
        return DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);
    }

    /**
     * Adds a new student mark record to the database.
     *
     * @param studentMark The StudentMark object to add.
     * @return true if the record was added successfully, false otherwise.
     */
    public boolean addMark(StudentMark studentMark) {
        String SQL = "INSERT INTO StudentMarks (StudentID, StudentName, Subject, Marks, ExamDate) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(SQL)) {

            pstmt.setInt(1, studentMark.getStudentID());
            pstmt.setString(2, studentMark.getStudentName());
            pstmt.setString(3, studentMark.getSubject());
            pstmt.setInt(4, studentMark.getMarks());
            pstmt.setDate(5, studentMark.getExamDate());

            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Error adding mark: " + e.getMessage());
            return false;
        }
    }

    /**
     * Updates an existing student mark record in the database.
     *
     * @param studentMark The StudentMark object with updated details.
     * @return true if the record was updated successfully, false otherwise.
     */
    public boolean updateMark(StudentMark studentMark) {
        String SQL = "UPDATE StudentMarks SET StudentName = ?, Subject = ?, Marks = ?, ExamDate = ? WHERE StudentID = ?";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(SQL)) {

            pstmt.setString(1, studentMark.getStudentName());
            pstmt.setString(2, studentMark.getSubject());
            pstmt.setInt(3, studentMark.getMarks());
            pstmt.setDate(4, studentMark.getExamDate());
            pstmt.setInt(5, studentMark.getStudentID()); // WHERE clause

            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Error updating mark: " + e.getMessage());
            return false;
        }
    }

    /**
     * Deletes a student mark record from the database by StudentID.
     *
     * @param studentID The ID of the student to delete.
     * @return true if the record was deleted successfully, false otherwise.
     */
    public boolean deleteMark(int studentID) {
        String SQL = "DELETE FROM StudentMarks WHERE StudentID = ?";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(SQL)) {

            pstmt.setInt(1, studentID);

            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Error deleting mark: " + e.getMessage());
            return false;
        }
    }

    /**
     * Retrieves a single student mark record by StudentID.
     *
     * @param studentID The ID of the student to retrieve.
     * @return The StudentMark object if found, null otherwise.
     */
    public StudentMark getMarkById(int studentID) {
        String SQL = "SELECT StudentID, StudentName, Subject, Marks, ExamDate FROM StudentMarks WHERE StudentID = ?";
        StudentMark studentMark = null;
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(SQL)) {

            pstmt.setInt(1, studentID);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                studentMark = new StudentMark();
                studentMark.setStudentID(rs.getInt("StudentID"));
                studentMark.setStudentName(rs.getString("StudentName"));
                studentMark.setSubject(rs.getString("Subject"));
                studentMark.setMarks(rs.getInt("Marks"));
                studentMark.setExamDate(rs.getDate("ExamDate"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Error retrieving mark by ID: " + e.getMessage());
        }
        return studentMark;
    }

    /**
     * Retrieves all student mark records from the database.
     *
     * @return A list of StudentMark objects.
     */
    public List<StudentMark> getAllMarks() {
        List<StudentMark> studentMarks = new ArrayList<>();
        String SQL = "SELECT StudentID, StudentName, Subject, Marks, ExamDate FROM StudentMarks ORDER BY StudentID";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(SQL);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                StudentMark studentMark = new StudentMark();
                studentMark.setStudentID(rs.getInt("StudentID"));
                studentMark.setStudentName(rs.getString("StudentName"));
                studentMark.setSubject(rs.getString("Subject"));
                studentMark.setMarks(rs.getInt("Marks"));
                studentMark.setExamDate(rs.getDate("ExamDate"));
                studentMarks.add(studentMark);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Error retrieving all marks: " + e.getMessage());
        }
        return studentMarks;
    }

    /**
     * Retrieves students with marks above a specified value.
     *
     * @param threshold The minimum marks value.
     * @return A list of StudentMark objects.
     */
    public List<StudentMark> getMarksAboveValue(int threshold) {
        List<StudentMark> studentMarks = new ArrayList<>();
        String SQL = "SELECT StudentID, StudentName, Subject, Marks, ExamDate FROM StudentMarks WHERE Marks > ? ORDER BY Marks DESC, StudentID";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(SQL)) {

            pstmt.setInt(1, threshold);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                StudentMark studentMark = new StudentMark();
                studentMark.setStudentID(rs.getInt("StudentID"));
                studentMark.setStudentName(rs.getString("StudentName"));
                studentMark.setSubject(rs.getString("Subject"));
                studentMark.setMarks(rs.getInt("Marks"));
                studentMark.setExamDate(rs.getDate("ExamDate"));
                studentMarks.add(studentMark);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Error retrieving marks above threshold: " + e.getMessage());
        }
        return studentMarks;
    }

    /**
     * Retrieves students who scored in a specific subject.
     *
     * @param subject The subject name.
     * @return A list of StudentMark objects.
     */
    public List<StudentMark> getMarksBySubject(String subject) {
        List<StudentMark> studentMarks = new ArrayList<>();
        String SQL = "SELECT StudentID, StudentName, Subject, Marks, ExamDate FROM StudentMarks WHERE Subject = ? ORDER BY StudentID";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(SQL)) {

            pstmt.setString(1, subject);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                StudentMark studentMark = new StudentMark();
                studentMark.setStudentID(rs.getInt("StudentID"));
                studentMark.setStudentName(rs.getString("StudentName"));
                studentMark.setSubject(rs.getString("Subject"));
                studentMark.setMarks(rs.getInt("Marks"));
                studentMark.setExamDate(rs.getDate("ExamDate"));
                studentMarks.add(studentMark);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Error retrieving marks by subject: " + e.getMessage());
        }
        return studentMarks;
    }

    /**
     * Retrieves the top N students based on marks.
     * Note: This implementation assumes 'top N' means students with the highest marks,
     * and might return more than N if there are ties at the Nth position.
     * For a strict top N, you might need to adjust the SQL query (e.g., LIMIT N for MySQL).
     *
     * @param n The number of top students to retrieve.
     * @return A list of StudentMark objects.
     */
    public List<StudentMark> getTopNStudents(int n) {
        List<StudentMark> studentMarks = new ArrayList<>();
        // Note: For strict 'top N' in MySQL, you can use "LIMIT ?" at the end.
        // For other databases, syntax might vary (e.g., ROWNUM for Oracle, TOP N for SQL Server).
        // This query fetches all, then we'll sort and limit in Java if needed, or rely on DB LIMIT.
        String SQL = "SELECT StudentID, StudentName, Subject, Marks, ExamDate FROM StudentMarks ORDER BY Marks DESC, StudentID ASC LIMIT ?";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(SQL)) {

            pstmt.setInt(1, n);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                StudentMark studentMark = new StudentMark();
                studentMark.setStudentID(rs.getInt("StudentID"));
                studentMark.setStudentName(rs.getString("StudentName"));
                studentMark.setSubject(rs.getString("Subject"));
                studentMark.setMarks(rs.getInt("Marks"));
                studentMark.setExamDate(rs.getDate("ExamDate"));
                studentMarks.add(studentMark);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Error retrieving top N students: " + e.getMessage());
        }
        return studentMarks;
    }
}
