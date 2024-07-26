<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException" %>
<%
    String dni = request.getParameter("dni");

    String host = "localhost"; // Cambia según tu configuración
    String usua = "root";      // Cambia según tu configuración
    String pass = "123456";    // Cambia según tu configuración
    String bd = "interbank";   // Cambia según tu configuración

    Connection conexion = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    String nombre = "";
    String celular = "";
    String correo = "";

    try {
        Class.forName("org.mariadb.jdbc.Driver");
        conexion = DriverManager.getConnection("jdbc:mariadb://" + host + "/" + bd, usua, pass);

        String sql = "SELECT nombre, celular, correo FROM clientes WHERE dni = ?";
        ps = conexion.prepareStatement(sql);
        ps.setString(1, dni);

        rs = ps.executeQuery();

        if (rs.next()) {
            nombre = rs.getString("nombre");
            celular = rs.getString("celular");
            correo = rs.getString("correo");
        } else {
            out.println("<script>alert('Cliente no encontrado.'); window.history.back();</script>");
        }
    } catch (SQLException | ClassNotFoundException ex) {
        out.println("<script>alert('Error de conexión a la base de datos: " + ex.getMessage() + "'); window.history.back();</script>");
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
%>
<div class="perfil">
    <h2>Perfil del Usuario</h2>
    <p><strong>DNI:</strong> <%= dni %></p>
    <p><strong>Nombre:</strong> <%= nombre %></p>
    <p><strong>Email:</strong> <%= correo %></p>
    <p><strong>Celular:</strong> <%= celular %></p>
    <button onclick="location.href='cuenta.jsp?dni=<%= dni %>'">Volver</button>
</div>
