<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>

<%
    // Obtener parámetros del formulario de inicio de sesión
    String cardNumber = request.getParameter("card-number").replaceAll("\\s", "");
    String dni = request.getParameter("document-type");
    String claveWeb = request.getParameter("campo_clave");

    // Configuración de la base de datos
    String host = "localhost"; // Cambia según tu configuración
    String usua = "root";      // Cambia según tu configuración
    String pass = "123456";    // Cambia según tu configuración
    String bd = "interbank";   // Cambia según tu configuración

    Connection conexion = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        // Cargar el driver de MariaDB
        Class.forName("org.mariadb.jdbc.Driver");
        // Establecer la conexión con la base de datos
        conexion = DriverManager.getConnection("jdbc:mariadb://" + host + "/" + bd, usua, pass);

        // Consultar los datos del cliente
        String sql = "SELECT * FROM clientes WHERE dni = ? AND card_number = ? AND claveweb = ?";
        ps = conexion.prepareStatement(sql);
        ps.setString(1, dni);
        ps.setString(2, cardNumber);
        ps.setString(3, claveWeb);

        rs = ps.executeQuery();

        if (rs.next()) {
            // Datos correctos, guardar el DNI en la sesión y redirigir a la página de cuenta
            session.setAttribute("dni", dni);
            response.sendRedirect("Cuenta/cuenta.jsp?dni=" + dni);
        } else {
            // Datos incorrectos, mostrar mensaje de error
            response.getWriter().println("<html><body><script>alert('Datos incorrectos. Por favor, inténtelo de nuevo.'); window.history.back();</script></body></html>");
        }
    } catch (SQLException | ClassNotFoundException ex) {
        // Manejar excepciones
        response.getWriter().println("<html><body><script>alert('Error de conexión a la base de datos: " + ex.getMessage() + "'); window.history.back();</script></body></html>");
    } finally {
        // Cerrar recursos
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
