<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ include file="dbconnect.jsp" %>
<html>
<head>
    <title>Patients List</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<div class="main-container">
    <h2>Patient List</h2>

    <table border="1" cellpadding="10">
        <tr>
            <th>Name</th>
            <th>Age</th>
            <th>Gender</th>
            <th>Phone</th>
        </tr>

        <%
            Connection con = null;
            Statement stmt = null;
            ResultSet rs = null;

            try {
                // Database connection (update credentials if needed)
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hospital_db", "root", "Radhekarna@01");

                String query = "SELECT name, age, gender, phone FROM patient";
                stmt = con.createStatement();
                rs = stmt.executeQuery(query);

                while(rs.next()) {
                    String name = rs.getString("name");
                    int age = rs.getInt("age");
                    String gender = rs.getString("gender");
                    String phone = rs.getString("phone");
        %>
        <tr>
            <td><%= name %></td>
            <td><%= age %></td>
            <td><%= gender %></td>
            <td><%= phone %></td>
        </tr>
        <%
                }
            } catch(Exception e) {
                out.println("<tr><td colspan='5'>Error: " + e.getMessage() + "</td></tr>");
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
