<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException"%>

<%
class base_datos {
    private String host;
    private String usua;
    private String pass;
    private String bd;
    public Connection conexion;
    
    public base_datos(String host, String usua, String pass, String bd) {
        this.host = host;
        this.usua = usua;
        this.pass = pass;
        this.bd = bd;
    }
    
    public boolean conectar() throws SQLException, ClassNotFoundException {
        try {
            Class.forName("org.mariadb.jdbc.Driver");
            this.conexion = DriverManager.getConnection("jdbc:mariadb://" + host + "/" + bd, usua, pass);
            if (this.conexion == null) {
                return false;
            }
        } catch (SQLException ex) {
            return false;
        }
        return true;
    }
    
    public ResultSet getClientes() throws SQLException {
        try {
            PreparedStatement ps = this.conexion.prepareStatement("SELECT * FROM clientes");
            ResultSet rs = ps.executeQuery();
            return rs;
        } catch (SQLException ex) {
            return null;
        }
    }
    
    public boolean insClientes(String dni, String correo, String nombre, String celular, String claveweb, String cardNumber) throws SQLException {
        try {
            PreparedStatement ps = this.conexion.prepareStatement("INSERT INTO clientes (dni, correo, nombre, celular, claveweb, card_number, saldo) VALUES (?, ?, ?, ?, ?, ?, 0)");
            ps.setString(1, dni);
            ps.setString(2, correo);
            ps.setString(3, nombre);
            ps.setString(4, celular);
            ps.setString(5, claveweb);
            ps.setString(6, cardNumber);
            ps.executeUpdate();
        } catch (SQLException ex) {
            return false;
        }
        return true;
    }
    
    public void cerrar() throws SQLException {
        if (this.conexion != null && !this.conexion.isClosed()) {
            this.conexion.close();
        }
    }
}
%>
