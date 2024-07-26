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
    const formData = new FormData(document.getElementById('transferForm'));
    fetch('cuenta.jsp', {
        method: 'POST',
        body: formData
    }).then(response => response.text())
      .then(data => document.write(data))
      .catch(error => console.error('Error:', error));
}

function iniciarPagoRecarga() {
    const formData = new FormData(document.getElementById('pagoRecargaForm'));
    const pagoSeleccionado = document.querySelector('input[name="pago"]:checked');
    
    if (pagoSeleccionado) {
        let monto;
        switch (pagoSeleccionado.value) {
            case 'servicios':
            case 'instituciones':
            case 'tarjetas':
            case 'prestamos':
            case 'sunat':
                monto = 50;
                break;
            default:
                monto = 0;
                break;
        }

        formData.append('monto', monto);
    }
    
    fetch('cuenta.jsp', {
        method: 'POST',
        body: formData
    }).then(response => response.text())
      .then(data => document.write(data))
      .catch(error => console.error('Error:', error));
}
