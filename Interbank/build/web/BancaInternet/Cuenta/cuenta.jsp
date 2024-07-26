<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException" %>
<!DOCTYPE html>
<html>
<head>
    <title>Interbank - Cuenta</title>
    <link rel="stylesheet" type="text/css" href="cuenta.css">
    <script src="cuenta.js" defer></script>
</head>
<body>
    <header>
        <div class="logo">
            <img src="logo.svg" alt="Interbank Logo">
        </div>
        <nav>
            <ul>
                <li><a href="#">Inicio</a></li>
                <li><a href="#">Mis productos</a></li>
                <li><a href="#">Mis operaciones</a></li>
                <li><a href="#">Te ofrecemos</a></li>
                <li><a href="#">Ayuda</a></li>
            </ul>
        </nav>
        <div class="user-info">
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
                double saldo = 0.0;

                try {
                    Class.forName("org.mariadb.jdbc.Driver");
                    conexion = DriverManager.getConnection("jdbc:mariadb://" + host + "/" + bd, usua, pass);

                    String sql = "SELECT nombre, saldo FROM clientes WHERE dni = ?";
                    ps = conexion.prepareStatement(sql);
                    ps.setString(1, dni);

                    rs = ps.executeQuery();

                    if (rs.next()) {
                        nombre = rs.getString("nombre");
                        saldo = rs.getDouble("saldo");
                    } else {
                        response.getWriter().println("<html><body><script>alert('Cliente no encontrado.'); window.history.back();</script></body></html>");
                    }
                } catch (SQLException | ClassNotFoundException ex) {
                    response.getWriter().println("<html><body><script>alert('Error de conexión a la base de datos: " + ex.getMessage() + "'); window.history.back();</script></body></html>");
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
            <span><%= nombre.isEmpty() ? "Usuario" : nombre.split(" ")[0] %></span>
            <button class="profile-btn" onclick="cargarPerfil('<%= dni %>')">Mi Perfil</button>
            <button class="logout-btn" onclick="location.href='cerrarSesion.jsp'">Cerrar Sesión</button>
        </div>
    </header>
    <div class="exchange-rate">
        <span>Compra: S/ 3.705 Venta: S/ 3.825</span>
    </div>
    <main>
        <div class="container" id="contenido">
            <section class="consulta">
                <h2>Consulta</h2>
                <div class="saldo">
                    <p>Cuenta Simple Soles</p>
                    <p>S/ <%= saldo %></p>
                    <p>Saldo disponible</p>
                </div>
            </section>
            <section class="transfiere">
                <h2>Transfiere</h2>
                <form id="transferForm" method="post">
                    <label for="cuenta-destino">Cuenta destino</label>
                    <input type="text" id="cuenta-destino" name="cuenta-destino">
                    <label for="moneda">Moneda</label>
                    <select id="moneda" name="moneda">
                        <option value="Soles">Soles</option>
                        <option value="Dólares">Dólares</option>
                    </select>
                    <label for="monto">Monto</label>
                    <input type="number" id="monto" name="monto">
                    <button type="submit" name="accion" value="transferir">Transferir</button>
                </form>
            </section>
            <section class="paga-recarga">
                <h2>Paga o Recarga</h2>
                <form id="pagoRecargaForm" method="post">
                    <label>Selecciona la operación que deseas realizar</label>
                    <div class="radio-group">
                        <label><input type="radio" name="pago" value="servicios"> Pago de servicios (50 soles)</label>
                        <label><input type="radio" name="pago" value="instituciones"> Pago de institución o empresas (50 soles)</label>
                        <label><input type="radio" name="pago" value="tarjetas"> Pago de tarjetas de crédito (50 soles)</label>
                        <label><input type="radio" name="pago" value="prestamos"> Pago de cuota de Préstamos (50 soles)</label>
                        <label><input type="radio" name="pago" value="sunat"> Pago SUNAT NPS (50 soles)</label>
                        <label><input type="radio" name="pago" value="celular"> Recarga de Celular (50 soles)</label>
                        <label><input type="radio" name="pago" value="billetera"> Recarga de Billetera Móvil (50 soles)</label>
                        <label><input type="radio" name="pago" value="donacion"> Donación (50 soles)</label>
                    </div>
                    <button type="submit" name="accion" value="pagoRecarga">Iniciar pago o recarga</button>
                </form>
            </section>
        </div>
    </main>
    <%
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            String accion = request.getParameter("accion");
            if ("pagoRecarga".equals(accion)) {
                String tipoPago = request.getParameter("pago");
                double montoPago = 50.0; // monto fijo para pagos y recargas

                try {
                    Class.forName("org.mariadb.jdbc.Driver");
                    conexion = DriverManager.getConnection("jdbc:mariadb://" + host + "/" + bd, usua, pass);

                    String updateSql = "UPDATE cuentas SET saldo = saldo - ? WHERE dni = ?";
                    ps = conexion.prepareStatement(updateSql);
                    ps.setDouble(1, montoPago);
                    ps.setString(2, dni);

                    int rowsAffected = ps.executeUpdate();
                    if (rowsAffected > 0) {
                        response.getWriter().println("<html><body><script>alert('Pago/Recarga realizado con éxito'); window.location='cuenta.jsp?dni=" + dni + "';</script></body></html>");
                    } else {
                        response.getWriter().println("<html><body><script>alert('Error al realizar el pago/recarga.'); window.history.back();</script></body></html>");
                    }
                } catch (SQLException | ClassNotFoundException ex) {
                    response.getWriter().println("<html><body><script>alert('Error de conexión a la base de datos: " + ex.getMessage() + "'); window.history.back();</script></body></html>");
                } finally {
                    if (ps != null) {
                        try { ps.close(); } catch (SQLException ignore) {}
                    }
                    if (conexion != null) {
                        try { conexion.close(); } catch (SQLException ignore) {}
                    }
                }
            } else if ("transferir".equals(accion)) {
                String cuentaDestino = request.getParameter("cuenta-destino");
                String moneda = request.getParameter("moneda");
                String montoStr = request.getParameter("monto");
                double monto = Double.parseDouble(montoStr);

                try {
                    Class.forName("org.mariadb.jdbc.Driver");
                    conexion = DriverManager.getConnection("jdbc:mariadb://" + host + "/" + bd, usua, pass);

                    // Iniciar transacción
                    conexion.setAutoCommit(false);

                    // Descontar saldo del remitente
                    String updateSqlRemitente = "UPDATE cuentas SET saldo = saldo - ? WHERE dni = ?";
                    ps = conexion.prepareStatement(updateSqlRemitente);
                    ps.setDouble(1, monto);
                    ps.setString(2, dni);
                    int rowsAffectedRemitente = ps.executeUpdate();

                    // Aumentar saldo del destinatario
                    String updateSqlDestinatario = "UPDATE cuentas SET saldo = saldo + ? WHERE cuenta = ?";
                    ps = conexion.prepareStatement(updateSqlDestinatario);
                    ps.setDouble(1, monto);
                    ps.setString(2, cuentaDestino);
                    int rowsAffectedDestinatario = ps.executeUpdate();

                    if (rowsAffectedRemitente > 0 && rowsAffectedDestinatario > 0) {
                        // Confirmar transacción
                        conexion.commit();
                        response.getWriter().println("<html><body><script>alert('Transferencia realizada con éxito'); window.location='cuenta.jsp?dni=" + dni + "';</script></body></html>");
                    } else {
                        // Revertir transacción en caso de error
                        conexion.rollback();
                        response.getWriter().println("<html><body><script>alert('Error al realizar la transferencia.'); window.history.back();</script></body></html>");
                    }
                } catch (SQLException | ClassNotFoundException ex) {
                    try {
                        if (conexion != null) {
                            conexion.rollback();
                        }
                    } catch (SQLException ignore) {}
                    response.getWriter().println("<html><body><script>alert('Error de conexión a la base de datos: " + ex.getMessage() + "'); window.history.back();</script></body></html>");
                } finally {
                    if (ps != null) {
                        try { ps.close(); } catch (SQLException ignore) {}
                    }
                    if (conexion != null) {
                        try { conexion.close(); } catch (SQLException ignore) {}
                    }
                }
            }
        }
    %>
</body>
</html>
