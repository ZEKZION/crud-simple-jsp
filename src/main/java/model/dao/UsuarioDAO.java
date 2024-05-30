package model.dao;

import db.Conexion;
import interfaces.UsuarioCRUD;
import model.dto.UsuarioDTO;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UsuarioDAO extends Conexion implements UsuarioCRUD {
    UsuarioDTO usuario;

    @Override
    public ArrayList<UsuarioDTO> getUsuarios() {
        ArrayList<UsuarioDTO> listaUsuarios = new ArrayList<>();
        String sql = "select * from usuario";
        try {
            rs = st.executeQuery(sql);
            while (rs.next()) {
                usuario = new UsuarioDTO();

                usuario.setId(rs.getString("id"));
                usuario.setNombre(rs.getString("nombre"));
                usuario.setApellido(rs.getString("apellido"));
                usuario.setEmail(rs.getString("email"));

                listaUsuarios.add(usuario);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return listaUsuarios;
    }

    @Override
    public UsuarioDTO getUsuario(String id) {
        String sql = "select * from usuario where id = ?";

        try{
            ps = getCon().prepareStatement(sql);
            ps.setString(1, id);
            rs = ps.executeQuery();

            if(rs.next()) {
                usuario = new UsuarioDTO();
                usuario.setId(rs.getString("id"));
                usuario.setNombre(rs.getString("nombre"));
                usuario.setApellido(rs.getString("apellido"));
                usuario.setEmail(rs.getString("email"));

            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return usuario;
    }

    @Override
    public boolean addUsuario(UsuarioDTO usuario) {
        String sql = "insert into usuario (id, nombre, apellido, email) values (?,?,?,?)";

        try {
            ps = getCon().prepareStatement(sql);

            ps.setString(1, usuario.getId());
            ps.setString(2, usuario.getNombre());
            ps.setString(3, usuario.getApellido());
            ps.setString(4, usuario.getEmail());

            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return false;
    }

    @Override
    public boolean updateUsuario(UsuarioDTO usuario) {
        String sql = "update usuario set nombre = ?, apellido = ?, email = ? where id = ?";

        try {
            ps = getCon().prepareStatement(sql);

            ps.setString(1, usuario.getNombre());
            ps.setString(2, usuario.getApellido());
            ps.setString(3, usuario.getEmail());
            ps.setString(4, usuario.getId());

            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return false;
    }

    @Override
    public boolean deleteUsuario(String id) {
        String sql = "delete from usuario where id = ?";

        try {
            ps = getCon().prepareStatement(sql);
            ps.setString(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return false;
    }
}
