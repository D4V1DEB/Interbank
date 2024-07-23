<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Interbank</title>
    <link rel="stylesheet" type="text/css" href="estilo.css">
    <script language="JavaScript" type="text/javascript" src="teclado.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const claveWebCheckbox = document.getElementById('clave-web');
            const keyboardContainer = document.getElementById('contenedor');
            const cardNumberInput = document.getElementById('card-number');
            const documentTypeInput = document.getElementById('document-type');

            function allowOnlyNumbers(event) {
                const charCode = (event.which) ? event.which : event.keyCode;
                if (charCode > 31 && (charCode < 48 || charCode > 57)) {
                    event.preventDefault();
                }
            }

            cardNumberInput.addEventListener('keypress', allowOnlyNumbers);
            documentTypeInput.addEventListener('keypress', allowOnlyNumbers);

            cardNumberInput.addEventListener('input', function(event) {
                let value = cardNumberInput.value.replace(/\s+/g, '');
                if (value.length > 16) {
                    value = value.substr(0, 16);
                }
                cardNumberInput.value = value.match(/.{1,4}/g)?.join(' ') ?? value;
            });

            document.querySelector('form').addEventListener('submit', function(event) {
                const cardNumberValue = cardNumberInput.value.replace(/\s+/g, '');
                const documentTypeValue = documentTypeInput.value;

                if (cardNumberValue.length !== 16) {
                    event.preventDefault();
                    alert('El número de tarjeta debe tener 16 dígitos.');
                }
                if (documentTypeValue.length !== 8) {
                    event.preventDefault();
                    alert('El DNI debe tener 8 dígitos.');
                }
            });

            claveWebCheckbox.addEventListener('change', function() {
                if (claveWebCheckbox.checked) {
                    marcador('contenedor', 'campo_clave');
                    keyboardContainer.style.display = 'block';
                } else {
                    keyboardContainer.style.display = 'none';
                }
            });
        });
    </script>
</head>
<body>
    <img src="logo.svg" alt="Interbank Logo" id="logo">
    <br>
    <div class="login-container">
        <form class="login-form">
            <br>
            <div class="form-group">
                <input type="text" id="card-number" name="card-number" maxlength="19" required placeholder="Número de tarjeta">
            </div>
            <br>
            <div class="form-group">
                <input type="text" id="document-type" name="document-type" maxlength="8" required placeholder="DNI">
            </div>
            <br>
            <div class="form-group">
                <input type="checkbox" id="clave-web" name="clave-web">
                <input type="password" id="campo_clave" name="campo_clave" style="width:150px" readonly="true" class="caja_secure" placeholder="Clave web" />
            </div>  
            <div id="contenedor" style="display: none;"></div>
            <div class="form-group checkbox-group">
                <input type="checkbox" id="remember" name="remember" checked>
                <label for="remember" class="checkbox-label">Recordar datos</label>
            </div>
            <br>
            <button type="submit" id="submit-button" disabled>Ingresar</button>

        </form>
        <br>
        <br>
        <div>   
            <a href="../Carga/index.jsp">Regístrate</a> |
            <a href="#">Olvidé mi clave web</a> |
            <a href="#">Ayuda</a>
        </div>
    </div>
</body>
</html>
