<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.io.IOException, java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException"%>
<%@include file="base_datos.jsp"%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registro - Interbank</title>
    <link rel="stylesheet" href="formulario.css">
    <script>
        function generateCardNumber() {
            let cardNumber = '';
            for (let i = 0; i < 4; i++) {
                cardNumber += Math.floor(1000 + Math.random() * 9000).toString();
            }
            return cardNumber;
        }

        function submitForm(event) {
            event.preventDefault();

            const dni = document.getElementById('dni').value;
            const correo = document.getElementById('correo').value;
            const nombre = document.getElementById('nombre').value;
            const celular = document.getElementById('celular').value;
            const claveweb = document.getElementById('claveweb').value;
            const cardNumber = generateCardNumber();

            const form = document.createElement('form');
            form.method = 'POST';
            form.action = 'registrobd.jsp';

            const fields = { dni, correo, nombre, celular, claveweb, cardNumber };

            for (const key in fields) {
                if (fields.hasOwnProperty(key)) {
                    const input = document.createElement('input');
                    input.type = 'hidden';
                    input.name = key;
                    input.value = fields[key];
                    form.appendChild(input);
                }
            }

            document.body.appendChild(form);
            form.submit();
        }
    </script>
</head>
<body>
    <div class="clogo">
        <img src="interbank.png" alt="Interbank Logo" id="logo">
    </div>
    <div class="container">
        <div class="left">
            <h1>Tu Cuenta Simple <br>
                100% digital te <br>
                ofrece los mejores <br>
                beneficios.</h1>
            <h2>Y con cero costo de mantenimiento.</h2>
            <ul>
                <li><img src="icono1.png" alt="Icono 1" id="icono">Realiza operaciones sin costo<br>Transfiere dinero a cualquier banco sin costo<br>adicional y desde cualquier lugar.</li>
                <li><img src="icono2.png" alt="Icono 2" id="icono">Es gratis y 100% digital<br>La Cuenta Simple no te cobra mantenimiento y<br>puedes solicitarla por la web y la app.</li>
                <li><img src="icono3.png" alt="Icono 3" id="icono">Paga lo que quieras desde tu celular<br>Ya que es compatible con Garmin pay, Apple pay y<br> Google pay.</li>
            </ul>
        </div>
        <div class="right">
            <div class="form-container">
                <h3>Ingresa tus datos y abre tu cuenta de ahorros al instante</h3>
                <br><br/>
                <form id="registroForm" onsubmit="submitForm(event)">
                    <label for="dni">DNI</label>
                    <input type="text" id="dni" name="dni" required pattern="[0-9]{8}">
                    <br><br/>
                    <label for="correo">Correo</label>
                    <input type="email" id="correo" name="correo" required>
                    <br><br/>
                    <label for="nombre">Nombre</label>
                    <input type="text" id="nombre" name="nombre" required>
                    <br><br/>
                    <label for="celular">Celular</label>
                    <input type="tel" id="celular" name="celular" required pattern="[0-9]{9}" placeholder="000000000">
                    <br><br/>
                    <label for="claveweb">Clave Web</label>
                    <input type="password" id="claveweb" name="claveweb" required>
                    <br><br/>
                    <div class="privacy">
                        <input type="checkbox" id="privacyPolicy" name="privacyPolicy" required>
                        <label for="privacyPolicy">He leído y acepto la <a href="#">Política de Privacidad</a>.</label>
                    </div>
                    
                    <button type="submit">Siguiente</button>
                </form>
            </div>
        </div>
    </div>
</body>
</html>
