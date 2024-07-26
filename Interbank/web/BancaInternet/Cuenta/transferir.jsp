<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException" %>
<%
    String dniDestinatario = request.getParameter("dni");
    String montoStr = request.getParameter("monto");
    
    // Verifica que el monto no sea nulo y sea un número positivo
    double monto = 0;
    try {
        monto = Double.parseDouble(montoStr);
        if (monto <= 0) {
            throw new NumberFormatException("El monto debe ser mayor a 0.");
        }
    } catch (NumberFormatException e) {
        out.print("Error en el monto: " + e.getMessage());
        return;
    }

    // Verifica que se haya enviado un DNI
    if (dniDestinatario == null || dniDestinatario.trim().isEmpty()) {
        out.print("Error: DNI del destinatario no proporcionado.");
        return;
    }

    String dniRemitente = (String) session.getAttribute("dni");
    
    if (dniRemitente == null || dniRemitente.trim().isEmpty()) {
        out.print("Error: DNI del remitente no proporcionado.");
        return;
    }

    String host = "localhost";
    String usua = "root";
    String pass = "123456";
    String bd = "interbank";

    Connection conexion = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        Class.forName("org.mariadb.jdbc.Driver");
        conexion = DriverManager.getConnection("jdbc:mariadb://" + host + "/" + bd, usua, pass);

        conexion.setAutoCommit(false);

        // Verificar el saldo del remitente
        String sqlVerificarSaldo = "SELECT saldo FROM clientes WHERE dni = ?";
        ps = conexion.prepareStatement(sqlVerificarSaldo);
        ps.setString(1, dniRemitente);
        rs = ps.executeQuery();

        double saldoRemitente = 0;
        if (rs.next()) {
            saldoRemitente = rs.getDouble("saldo");
            if (saldoRemitente < monto) {
                throw new SQLException("Saldo insuficiente en la cuenta del remitente.");
            }
        } else {
            throw new SQLException("Remitente no encontrado.");
        }

        // Aumentar el monto en el destinatario
        String sqlAumentar = "UPDATE clientes SET saldo = saldo + ? WHERE dni = ?";
        ps = conexion.prepareStatement(sqlAumentar);
        ps.setDouble(1, monto);
        ps.setString(2, dniDestinatario);
        int filasAfectadas = ps.executeUpdate();

        if (filasAfectadas == 0) {
            throw new SQLException("Error al aumentar el saldo del destinatario.");
        }

        // Descontar el monto del remitente
        String sqlDescontar = "UPDATE clientes SET saldo = saldo - ? WHERE dni = ?";
        ps = conexion.prepareStatement(sqlDescontar);
        ps.setDouble(1, monto);
        ps.setString(2, dniRemitente);
        filasAfectadas = ps.executeUpdate();

        if (filasAfectadas == 0) {
            throw new SQLException("Error al descontar el saldo del remitente.");
        }

        conexion.commit();
        out.print("Transferencia exitosa.");
    } catch (SQLException | ClassNotFoundException ex) {
        if (conexion != null) {
            try { conexion.rollback(); } catch (SQLException ignore) {}
        }
        out.print("Error en la transferencia: " + ex.getMessage());
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
