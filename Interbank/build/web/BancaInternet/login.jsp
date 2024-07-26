<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>

<%
    String cardNumber = request.getParameter("card-number").replaceAll("\\s", "");
    String dni = request.getParameter("document-type");
    String claveWeb = request.getParameter("campo_clave");

    String host = "localhost"; // Cambia según tu configuración
    String usua = "root";      // Cambia según tu configuración
    String pass = "123456";    // Cambia según tu configuración
    String bd = "interbank";   // Cambia según tu configuración

    Connection conexion = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        Class.forName("org.mariadb.jdbc.Driver");
        conexion = DriverManager.getConnection("jdbc:mariadb://" + host + "/" + bd, usua, pass);

        String sql = "SELECT * FROM clientes WHERE dni = ? AND card_number = ? AND claveweb = ?";
        ps = conexion.prepareStatement(sql);
        ps.setString(1, dni);
        ps.setString(2, cardNumber);
        ps.setString(3, claveWeb);

        rs = ps.executeQuery();

        if (rs.next()) {
            // Datos correctos, redirigir a la página de cuenta
            response.sendRedirect("Cuenta/cuenta.jsp?dni=" + dni);
        } else {
            // Datos incorrectos, mostrar mensaje de error
            response.getWriter().println("<html><body><script>alert('Datos incorrectos. Por favor, inténtelo de nuevo.'); window.history.back();</script></body></html>");
        }
    } catch (SQLException | ClassNotFoundException ex) {
        response.getWriter().println("<html><body><script>alert('Error de conexión a la base de datos: " + ex.getMessage() + "'); window.history.back();</script></body></html>");
    } finally {
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
