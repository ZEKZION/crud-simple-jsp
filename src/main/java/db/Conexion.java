package db;

import java.sql.*;

public class Conexion implements Parametros {
    private Connection con;
    public PreparedStatement ps;
    public Statement st;
    public ResultSet rs;

    public Conexion() {
        try {
            Class.forName(driver);
            con = DriverManager.getConnection(url, user, password);
            st = con.createStatement();
        } catch (ClassNotFoundException | SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public Connection getCon() {
        return con;
    }
}
