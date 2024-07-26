<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException" %>
<%@ page contentType="application/json" %>
<%
    String dni = request.getParameter("dni");

    String host = "localhost";
    String usua = "root";
    String pass = "123456";
    String bd = "interbank";

    Connection conexion = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    String json = "";

    try {
        Class.forName("org.mariadb.jdbc.Driver");
        conexion = DriverManager.getConnection("jdbc:mariadb://" + host + "/" + bd, usua, pass);

        String sql = "SELECT card_number FROM clientes WHERE dni = ?";
        ps = conexion.prepareStatement(sql);
        ps.setString(1, dni);

        rs = ps.executeQuery();

        if (rs.next()) {
            String numeroCuenta = rs.getString("card_number");
            json = "{\"numeroCuenta\": \"" + numeroCuenta + "\"}";
        } else {
            json = "{\"error\": \"Cuenta no encontrada.\"}";
        }
    } catch (SQLException | ClassNotFoundException ex) {
        json = "{\"error\": \"Error en la base de datos: " + ex.getMessage() + "\"}";
    } finally {
        if (rs != null) {
            try { rs.close(); } catch (SQLException ignore) {}
        }
        if (ps != null) {
            try { ps.close(); } catch (SQLException ignore) {}
        }
        if (conexion != null) {
            try { conexion.close(); } catch (SQLException ignore) {}
        }
    }

    out.print(json);
%>
