<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.SQLException" %>
<%
    String pago = request.getParameter("pago");
    String montoStr = request.getParameter("monto");
    double monto = Double.parseDouble(montoStr);

    String dniRemitente = (String) session.getAttribute("dni");

    String host = "localhost";
    String usua = "root";
    String pass = "123456";
    String bd = "interbank";

    Connection conexion = null;
    PreparedStatement ps = null;

    try {
        Class.forName("org.mariadb.jdbc.Driver");
        conexion = DriverManager.getConnection("jdbc:mariadb://" + host + "/" + bd, usua, pass);

        // Descontar el monto del remitente
        String sqlDescontar = "UPDATE clientes SET saldo = saldo - ? WHERE dni = ?";
        ps = conexion.prepareStatement(sqlDescontar);
        ps.setDouble(1, monto);
        ps.setString(2, dniRemitente);
        int filasAfectadas = ps.executeUpdate();

        if (filasAfectadas == 0) {
            throw new SQLException("Error al descontar el saldo del remitente.");
        }

        out.print("Pago/Recarga exitoso.");
    } catch (SQLException | ClassNotFoundException ex) {
        out.print("Error en el pago/recarga: " + ex.getMessage());
    } finally {
        if (ps != null) {
            try { ps.close(); } catch (SQLException ignore) {}
        }
        if (conexion != null) {
            try { conexion.close(); } catch (SQLException ignore) {}
        }
    }
%>