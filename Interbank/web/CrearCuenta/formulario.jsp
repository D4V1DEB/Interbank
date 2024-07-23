<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Abre tu Cuenta Simple - Interbank</title>
    <link rel="stylesheet" href="formulario.css">
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
                <form>
                    <label for="dni">DNI</label>
                    <input type="text" id="dni" name="dni" required pattern="[0-8]{8}">
                    <br><br/>
                    <label for="correo">Correo</label>
                    <input type="email" id="correo" name="correo" required>
                    <br><br/>
                    <label for="celular">Celular</label>
                    <input type="tel" id="celular" name="celular" required pattern="[0-9]{9}" placeholder="000000000">
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
