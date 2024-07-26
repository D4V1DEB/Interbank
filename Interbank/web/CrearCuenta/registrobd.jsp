<%@ page import="java.io.*, java.sql.*" %>
<%
    // Configura los par�metros de la base de datos
    String host = "localhost"; // Cambia seg�n tu configuraci�n
    String usua = "root";      // Cambia seg�n tu configuraci�n
    String pass = "123456";    // Cambia seg�n tu configuraci�n
    String bd = "interbank";   // Cambia seg�n tu configuraci�n

    Connection conexion = null;
    PreparedStatement ps = null;

    try {
        // Obtener los datos del formulario
        String dni = request.getParameter("dni");
        String correo = request.getParameter("correo");
        String nombre = request.getParameter("nombre");
        String celular = request.getParameter("celular");
        String claveweb = request.getParameter("claveweb");
        String cardNumber = request.getParameter("cardNumber");

        // Establecer la conexi�n a la base de datos
        Class.forName("org.mariadb.jdbc.Driver");
        conexion = DriverManager.getConnection("jdbc:mariadb://" + host + "/" + bd, usua, pass);

        // Preparar la consulta SQL para insertar los datos
        String sql = "INSERT INTO clientes (dni, correo, nombre, celular, claveweb, card_number, saldo) VALUES (?, ?, ?, ?, ?, ?, 1000)";
        ps = conexion.prepareStatement(sql);
        ps.setString(1, dni);
        ps.setString(2, correo);
        ps.setString(3, nombre);
        ps.setString(4, celular);
        ps.setString(5, claveweb);
        ps.setString(6, cardNumber);

        // Ejecutar la consulta
        int rowsAffected = ps.executeUpdate();

        // Comprobar si la inserci�n fue exitosa
        if (rowsAffected > 0) {
            response.setContentType("text/html");
            response.getWriter().println("<html><body><script>alert('Datos registrados correctamente:\\nDNI: " + dni + "\\nCorreo: " + correo + "\\nNombre: " + nombre + "\\nCelular: " + celular + "\\nClave Web: " + claveweb + "\\nN�mero de Tarjeta: " + cardNumber + "'); window.location.href = '../BancaInternet/index.jsp';</script></body></html>");
        } else {
            response.getWriter().println("<html><body><script>alert('Error al registrar los datos'); window.history.back();</script></body></html>");
        }
    } catch (SQLException | ClassNotFoundException ex) {
        response.getWriter().println("<html><body><script>alert('Error de conexi�n a la base de datos: " + ex.getMessage() + "'); window.history.back();</script></body></html>");
    } finally {
        if (ps != null) {
            try { ps.close(); } catch (SQLException ignore) {}
        }
        if (conexion != null) {
            try { conexion.close(); } catch (SQLException ignore) {}
        }
    }
%>
