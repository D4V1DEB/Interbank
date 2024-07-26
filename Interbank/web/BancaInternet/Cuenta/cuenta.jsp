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

                String host = "localhost";
                String usua = "root";
                String pass = "123456";
                String bd = "interbank";

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
                <form id="transferForm">
                    <label for="dni-destinatario">DNI del destinatario</label>
                    <input type="text" id="dni-destinatario">
                    <button type="button" onclick="buscarCuenta()">Buscar cuenta</button>
                    <label for="cuenta-destino">Cuenta destino</label>
                    <input type="text" id="cuenta-destino" readonly>
                    <input type="hidden" id="dni-real-destinatario">
                    <label for="monto">Monto</label>
                    <input type="number" id="monto">
                    <button type="button" onclick="transferir()">Transferir</button>
                </form>
            </section>

            <section class="paga-recarga">
                <h2>Paga o Recarga</h2>
                <form id="pagoRecargaForm">
                    <label>Selecciona la operación que deseas realizar</label>
                    <div class="radio-group">
                        <label><input type="radio" name="pago" value="servicios"> Pago de servicios</label>
                        <label><input type="radio" name="pago" value="instituciones"> Pago de institución o empresas</label>
                        <label><input type="radio" name="pago" value="tarjetas"> Pago de tarjetas de crédito</label>
                        <label><input type="radio" name="pago" value="prestamos"> Pago de cuota de Préstamos</label>
                        <label><input type="radio" name="pago" value="sunat"> Pago SUNAT NPS</label>
                        <label><input type="radio" name="pago" value="celular"> Recarga de Celular</label>
                        <label><input type="radio" name="pago" value="billetera"> Recarga de Billetera Móvil</label>
                        <label><input type="radio" name="pago" value="donacion"> Donación</label>
                    </div>
                    <button type="button" onclick="iniciarPagoRecarga()">Iniciar pago o recarga</button>
                </form>
            </section>

        </div>
    </main>
</body>
</html>
