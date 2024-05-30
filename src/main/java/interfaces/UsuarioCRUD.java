package interfaces;

import model.dto.UsuarioDTO;

import java.util.ArrayList;
import java.util.List;

public interface UsuarioCRUD {
    public ArrayList<UsuarioDTO> getUsuarios();
    public UsuarioDTO getUsuario(String id);
    public boolean addUsuario(UsuarioDTO usuario);
    public boolean updateUsuario(UsuarioDTO usuario);
    public boolean deleteUsuario(String id);;
}
