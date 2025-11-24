<%@ page import="java.sql.*" %>

<%
    Connection conn = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver"); // optional but ok

        conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/hospital_db",
                "root",
                "Radhekarna@01"
        );

    } catch (Exception e) {
        out.println("Database Connection Error: " + e);
    }
%>
