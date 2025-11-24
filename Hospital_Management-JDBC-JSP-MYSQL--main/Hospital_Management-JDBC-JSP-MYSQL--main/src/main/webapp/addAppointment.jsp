<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ include file="dbconnect.jsp" %>

<html>
<head>
    <title>Add Appointment</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<div class="main-container">
    <h2>Create Appointment</h2>

    <div class="form-box">

        <%
            String message = null;

            if ("POST".equalsIgnoreCase(request.getMethod())) {

                String patientId = request.getParameter("patientId");
                String doctorId = request.getParameter("doctorId");
                String date = request.getParameter("date");
                String time = request.getParameter("time");

                PreparedStatement ps = null;

                try {
                    String sql = "INSERT INTO Appointment(patient_id, doctor_id, date, time) VALUES (?, ?, ?, ?)";

                    ps = conn.prepareStatement(sql);
                    ps.setInt(1, Integer.parseInt(patientId));
                    ps.setInt(2, Integer.parseInt(doctorId));
                    ps.setString(3, date);
                    ps.setString(4, time);

                    int rows = ps.executeUpdate();
                    message = (rows > 0) ? "✔ Appointment Created Successfully!" :
                            "✖ Failed to Create Appointment.";

                } catch (SQLException se) {
                    message = "Database Error: " + se.getMessage();
                    se.printStackTrace();
                } finally {
                    try { if (ps != null) ps.close(); } catch (Exception ignore) {}
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

        <form action="addAppointment.jsp" method="post">
            <label>Patient ID:</label>
            <input type="number" name="patientId" required>

            <label>Doctor ID:</label>
            <input type="number" name="doctorId" required>

            <label>Date:</label>
            <input type="date" name="date" required>

            <label>Time:</label>
            <input type="time" name="time" required>

            <button type="submit">Create Appointment</button>
        </form>
    </div>
</div>

</body>
</html>
