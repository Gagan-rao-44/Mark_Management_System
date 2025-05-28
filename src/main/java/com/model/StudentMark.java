// File: src/com/model/StudentMark.java
package com.model;

import java.sql.Date; // Using java.sql.Date for database compatibility

/**
 * Represents a single student's mark record.
 * This is a simple Java bean (POJO) with properties corresponding to the StudentMarks table columns.
 */
public class StudentMark {
    private int studentID;
    private String studentName;
    private String subject;
    private int marks;
    private Date examDate; // Using java.sql.Date for database DATE type

    // Default constructor
    public StudentMark() {
    }

    // Parameterized constructor
    public StudentMark(int studentID, String studentName, String subject, int marks, Date examDate) {
        this.studentID = studentID;
        this.studentName = studentName;
        this.subject = subject;
        this.marks = marks;
        this.examDate = examDate;
    }

    // Getter and Setter methods for all properties

    public int getStudentID() {
        return studentID;
    }

    public void setStudentID(int studentID) {
        this.studentID = studentID;
    }

    public String getStudentName() {
        return studentName;
    }

    public void setStudentName(String studentName) {
        this.studentName = studentName;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public int getMarks() {
        return marks;
    }

    public void setMarks(int marks) {
        this.marks = marks;
    }

    public Date getExamDate() {
        return examDate;
    }

    public void setExamDate(Date examDate) {
        this.examDate = examDate;
    }

    @Override
    public String toString() {
        return "StudentMark{" +
               "studentID=" + studentID +
               ", studentName='" + studentName + '\'' +
               ", subject='" + subject + '\'' +
               ", marks=" + marks +
               ", examDate=" + examDate +
               '}';
    }
}
