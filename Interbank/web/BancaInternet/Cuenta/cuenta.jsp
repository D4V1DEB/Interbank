<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Interbank</title>
    <link rel="stylesheet" type="text/css" href="cuenta.css">
    <script src="scripts.js" defer></script>
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
            <span>20 jul 2024 Compra: S/ 3.686 Venta: S/ 3.808</span>
            <button>Cesar <span class="arrow">&#9660;</span></button>
        </div>
    </header>
    <main>
        <div class="container">
            <section class="consulta">
                <h2>Consulta</h2>
                <div class="saldo">
                    <p>Cuenta Simple Soles</p>
                    <p>S/ 9.85</p>
                    <p>Saldo disponible</p>
                </div>
            </section>
            <section class="transfiere">
                <h2>Transfiere</h2>
                <form>
                    <label for="transferir-a">Transferir a</label>
                    <select id="transferir-a">
                        <option value="frecuentes">Transferencias frecuentes</option>
                        <!-- Otras opciones -->
                    </select>
                    <label for="cuenta">Cuenta o tarjeta de cargo</label>
                    <input type="text" id="cuenta">
                    <label for="moneda">Moneda</label>
                    <select id="moneda">
                        <!-- Opciones de moneda -->
                    </select>
                    <label for="monto">Monto</label>
                    <input type="number" id="monto">
                    <button type="submit">Transferir</button>
                </form>
            </section>
            <section class="paga-recarga">
                <h2>Paga o Recarga</h2>
                <form>
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
                    <button type="submit">Iniciar pago o recarga</button>
                </form>
            </section>
        </div>
    </main>
</body>
</html>
