<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ include file="dbconnect.jsp" %>

<html>
<head>
    <title>Add Patient</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<div class="main-container">
    <h2>Add New Patient</h2>

    <div class="form-box">

        <%
            String message = null;

            // Handle form submit (POST)
            if ("POST".equalsIgnoreCase(request.getMethod())) {
                String name = request.getParameter("name");
                String ageStr = request.getParameter("age");
                String gender = request.getParameter("gender");
                String phone = request.getParameter("phone");

                // Basic validation
                if (name == null || name.trim().isEmpty() ||
                        ageStr == null || ageStr.trim().isEmpty() ||
                        gender == null || gender.trim().isEmpty()) {

                    message = "Please fill required fields: Name, Age, Gender.";
                } else {
                    PreparedStatement ps = null;
                    try {
                        int age = Integer.parseInt(ageStr.trim());

                        String sql = "INSERT INTO Patient(name, age, gender, phone) VALUES (?, ?, ?, ?)";
                        ps = conn.prepareStatement(sql);
                        ps.setString(1, name.trim());
                        ps.setInt(2, age);
                        ps.setString(3, gender.trim());
                        ps.setString(4, (phone == null) ? "" : phone.trim());

                        int rows = ps.executeUpdate();
                        if (rows > 0) {
                            // Option A: show success message and keep on same page
                            message = "✔ Patient added successfully!";

                            // Option B: redirect to list page instead (uncomment if you want)
                            // response.sendRedirect("viewPatients");
                            // return;
                        } else {
                            message = "✖ Failed to add patient. Try again.";
                        }
                    } catch (NumberFormatException nfe) {
                        message = "Age must be a valid number.";
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
        <div style="text-align:center; margin-bottom:18px;">
            <strong><%= message %></strong>
        </div>
        <%
            }
        %>

        <form action="addPatient.jsp" method="post">
            <label>Name:</label>
            <input type="text" name="name" required>

            <label>Age:</label>
            <input type="number" name="age" required>

            <label>Gender:</label>
            <input type="text" name="gender" required>

            <label>Phone:</label>
            <input type="text" name="phone">

            <button type="submit">Add Patient</button>
        </form>
    </div>
</div>

</body>
</html>
