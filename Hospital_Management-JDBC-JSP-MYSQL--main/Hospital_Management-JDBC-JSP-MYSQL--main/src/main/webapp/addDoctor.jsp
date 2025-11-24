<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ include file="dbconnect.jsp" %>

<html>
<head>
    <title>Add Doctor</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<div class="main-container">
    <h2>Add Doctor</h2>

    <div class="form-box">

        <%
            String message = null;

            // When form is submitted via POST
            if ("POST".equalsIgnoreCase(request.getMethod())) {
                String name = request.getParameter("name");
                String specialty = request.getParameter("specialty");

                if (name == null || name.trim().isEmpty() ||
                        specialty == null || specialty.trim().isEmpty()) {

                    message = "Please enter all required fields!";
                } else {
                    PreparedStatement ps = null;
                    try {
                        String sql = "INSERT INTO Doctor(name, speciality) VALUES (?, ?)";
                        ps = conn.prepareStatement(sql);
                        ps.setString(1, name.trim());
                        ps.setString(2, specialty.trim());

                        int rows = ps.executeUpdate();

                        if (rows > 0) {
                            message = "✔ Doctor added successfully!";
                        } else {
                            message = "✖ Failed to add doctor.";
                        }

                    } catch (SQLException se) {
                        message = "Database error: " + se.getMessage();
                        se.printStackTrace();
                    } finally {
                        try { if (ps != null) ps.close(); } catch (Exception ignore) {}
                    }
                }
            }

            if (message != null) {
        %>
        <div style="text-align:center; margin-bottom:16px; font-weight:bold;">
            <%= message %>
        </div>
        <%
            }
        %>

        <form action="addDoctor.jsp" method="post">
            <label>Name:</label>
            <input type="text" name="name" required>

            <label>Specialty:</label>
            <input type="text" name="specialty" required>

            <button type="submit">Add Doctor</button>
        </form>

    </div>
</div>

</body>
</html>
