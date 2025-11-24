<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<html>
<head>
    <title>Doctors List</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<div class="main-container">
    <h2>All Doctors</h2>

    <table border="1" cellpadding="10">
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Specialty</th>
        </tr>

        <%
            Connection con = null;
            Statement stmt = null;
            ResultSet rs = null;

            try {
                // Database connection (update credentials if needed)
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hospital_db", "root", "Radhekarna@01");

                String query = "SELECT id, name, speciality FROM doctor";
                stmt = con.createStatement();
                rs = stmt.executeQuery(query);

                while(rs.next()) {
                    int id = rs.getInt("id");
                    String name = rs.getString("name");
                    String specialty = rs.getString("speciality");
        %>
        <tr>
            <td><%= id %></td>
            <td><%= name %></td>
            <td><%= specialty %></td>
        </tr>
        <%
                }
            } catch(Exception e) {
                out.println("<tr><td colspan='3'>Error: " + e.getMessage() + "</td></tr>");
            } finally {
                try { if(rs!=null) rs.close(); } catch(Exception e){}
                try { if(stmt!=null) stmt.close(); } catch(Exception e){}
                try { if(con!=null) con.close(); } catch(Exception e){}
            }
        %>

    </table>
</div>

</body>
</html>
