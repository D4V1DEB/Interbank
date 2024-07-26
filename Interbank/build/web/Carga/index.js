document.addEventListener("DOMContentLoaded", function() {
    var video = document.getElementById("introVideo");
    video.play();
    video.addEventListener("ended", function() {
    window.location.href = "../CrearCuenta/formulario.jsp";
    });
});