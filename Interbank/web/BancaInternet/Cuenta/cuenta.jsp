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
                // Configura los datos de conexión
                String url = "jdbc:mysql://localhost:3306/interbank";
                String user = "root";
                String password = "123456";

                Connection conn = null;
                PreparedStatement stmt = null;
                ResultSet rs = null;
                double saldo = 0.0;
                String nombre = "";

                try {
                    // Establecer conexión
                    conn = DriverManager.getConnection(url, user, password);

                    // Consulta para obtener el nombre del usuario y el saldo
                    String query = "SELECT nombre, saldo FROM clientes WHERE dni = ?";
                    stmt = conn.prepareStatement(query);
                    stmt.setString(1, "12345678"); // Cambia esto según el DNI del usuario actual

                    rs = stmt.executeQuery();
                    if (rs.next()) {
                        nombre = rs.getString("nombre");
                        saldo = rs.getDouble("saldo");
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                } finally {
                    // Cerrar recursos
                    try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                    try { if (stmt != null) stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                    try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                }
            %>
            <span><%= nombre.split(" ")[0] %><span class='arrow'>&#9660;</span></span>
            <span>Compra: S/ 3.705 Venta: S/ 3.825</span>
        </div>
    </header>
    <main>
        <div class="container">
            <section class="consulta">
                <h2>Consulta</h2>
                <div class="saldo">
                    <p>Cuenta Simple Soles</p>
                    <p>S/ <%= saldo > 0 ? saldo : "0.00" %></p>
                    <p>Saldo disponible</p>
                </div>
            </section>
            <section class="transfiere">
                <h2>Transfiere</h2>
                <form id="transferForm">
                    <label for="transferir-a">Transferir a</label>
                    <select id="transferir-a">
                        <option value="frecuentes">Transferencias frecuentes</option>
                        <!-- Otras opciones -->
                    </select>
                    <label for="cuenta">Cuenta o tarjeta de cargo</label>
                    <input type="text" id="cuenta">
                    <label for="cuenta-destino">Cuenta destino</label>
                    <input type="text" id="cuenta-destino">
                    <label for="moneda">Moneda</label>
                    <select id="moneda">
                        <option value="Soles">Soles</option>
                        <option value="Dólares">Dólares</option>
                    </select>
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
    <script>
        function transferir() {
            const formData = new FormData(document.getElementById('transferForm'));
            fetch('transferirServlet', {
                method: 'POST',
                body: formData
            }).then(response => response.text())
              .then(data => alert('Transferencia realizada: ' + data))
              .catch(error => console.error('Error:', error));
        }

        function iniciarPagoRecarga() {
            const formData = new FormData(document.getElementById('pagoRecargaForm'));
            fetch('pagoRecargaServlet', {
                method: 'POST',
                body: formData
            }).then(response => response.text())
              .then(data => alert('Pago/Recarga realizada: ' + data))
              .catch(error => console.error('Error:', error));
        }
    </script>
</body>
</html>
