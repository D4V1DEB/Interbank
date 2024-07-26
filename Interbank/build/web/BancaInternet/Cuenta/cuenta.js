function cargarPerfil(dni) {
    const xhr = new XMLHttpRequest();
    xhr.open('GET', `perfil.jsp?dni=${dni}`, true);
    xhr.onload = function() {
        if (this.status === 200) {
            document.getElementById('contenido').innerHTML = this.responseText;
        } else {
            console.error('Error al cargar el perfil.');
        }
    };
    xhr.send();
}

function transferir() {
    const dniDestinatario = document.getElementById('dni-real-destinatario').value;
    const monto = document.getElementById('monto').value;

    if (!dniDestinatario || !monto) {
        alert('Por favor, complete todos los campos.');
        return;
    }

    const xhr = new XMLHttpRequest();
    xhr.open('POST', 'transferir.jsp', true);
    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    xhr.onload = function() {
        if (this.status === 200) {
            alert(this.responseText);
            location.reload();
        } else {
            console.error('Error en la transferencia.');
        }
    };
    xhr.send(`dni=${encodeURIComponent(dniDestinatario)}&monto=${encodeURIComponent(monto)}`);
}


function iniciarPagoRecarga() {
    const formData = new FormData(document.getElementById('pagoRecargaForm'));
    const pagoSeleccionado = document.querySelector('input[name="pago"]:checked');

    if (pagoSeleccionado) {
        let monto;
        switch (pagoSeleccionado.value) {
            case 'servicios':
                monto = 50;
                break;
            case 'instituciones':
                monto = 100;
                break;
            case 'tarjetas':
                monto = 100;
                break;
            case 'prestamos':
                monto = 50;
                break;
            case 'sunat':
                monto = 125;
                break;
            case 'celular':
                monto = 10;
                break;
            case 'billetera':
                monto = 10;
                break;
            case 'donacion':
                monto = 25;
                break;
            default:
                monto = 0;
                break;
        }

        const xhr = new XMLHttpRequest();
        xhr.open('POST', 'pagoRecarga.jsp', true);
        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        xhr.onload = function() {
            if (this.status === 200) {
                alert(this.responseText);
                location.reload();
            } else {
                console.error('Error en el pago/recarga.');
            }
        };
        xhr.send(`pago=${pagoSeleccionado.value}&monto=${monto}`);
    }
}

function buscarCuenta() {
    const dniDestinatario = document.getElementById('dni-destinatario').value;
    const xhr = new XMLHttpRequest();
    xhr.open('GET', `buscarCuenta.jsp?dni=${dniDestinatario}`, true);
    xhr.onload = function() {
        if (this.status === 200) {
            const resultado = JSON.parse(this.responseText);
            if (resultado.numeroCuenta) {
                document.getElementById('cuenta-destino').value = resultado.numeroCuenta;
                document.getElementById('dni-real-destinatario').value = dniDestinatario; // Guardar el DNI del destinatario real
            } else if (resultado.error) {
                alert(resultado.error);
                document.getElementById('cuenta-destino').value = '';
            }
        } else {
            console.error('Error al buscar la cuenta.');
        }
    };
    xhr.send();
}