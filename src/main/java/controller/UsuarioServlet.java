/*
    Archivo:  Servlet.java
    Fecha:    29/05/2024
    IDE:      IntelliJ IDEA
    Proyecto: crud-ajax-jsp
    Desarrollado por: ZEKZION
*/

package controller;

import com.google.gson.JsonObject;
import model.dao.UsuarioDAO;
import model.dto.UsuarioDTO;
import com.google.gson.Gson;

import org.json.JSONObject;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.ArrayList;

@WebServlet(name = "UsuarioServlet", value = "/UsuarioServlet")
public class UsuarioServlet extends HttpServlet {

    UsuarioDTO usuario = new UsuarioDTO();

    UsuarioDAO usuarioDAO = new UsuarioDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // accion que vendra de las vistas / formularios
        String action = request.getParameter("accion");

        // decicion de la accion
        if(action != null) {
            // switch para verificar la accion que se recibio
            switch (action) {
                case "listar": // mostrar lista de usuario
                    // crear lista de usuarios
                    ArrayList<UsuarioDTO> listaUsuarios = usuarioDAO.getUsuarios();

                    // establecer atributo request con la lista de objetos usuarios
                    request.setAttribute("listaUsuarios", listaUsuarios);
                    // redirigir a lista-usuario.jsp para procesar la lista de usuarios
                    request.getRequestDispatcher("views/lista-usuario.jsp").forward(request, response);
                    break;
                case "add": // agregar nuevo usuario
                    // obtener datos del formulario
                    String id = request.getParameter("id");
                    String nombre = request.getParameter("nombre");
                    String apellido = request.getParameter("apellido");
                    String email = request.getParameter("email");

                    // asignar los datos al objeto usuario
                    usuario.setId(id);
                    usuario.setNombre(nombre);
                    usuario.setApellido(apellido);
                    usuario.setEmail(email);

                    // agregar a la base de datos
                    usuarioDAO.addUsuario(usuario);

                    // crear objeto json con los datos del usuario
                    JSONObject nuevoUsuarioJson = new JSONObject();

                    // colocar los datos del usuario al objeto json usando put(clave, valor)
                    nuevoUsuarioJson.put("id", id);
                    nuevoUsuarioJson.put("nombre", nombre);
                    nuevoUsuarioJson.put("apellido", apellido);
                    nuevoUsuarioJson.put("email", email);

                    // configurar y enviar respuesta al cliente
                    response.setContentType("application/json");    // formato json
                    response.setCharacterEncoding("UTF-8");         // codificacion
                    response.getWriter().write(nuevoUsuarioJson.toString()); // enviar el objeto json al cliente
                    break;
                case "get":
                    // obtener el parametro enviado del cliente
                    String usuarioID = request.getParameter("id");

                    // crear objeto usuario con la informacion de la base de datos
                    usuario = usuarioDAO.getUsuario(usuarioID);

                    // crear objeto json para enviar al cliente, contiene los datos del usuario
                    JSONObject usuarioJson = new JSONObject();

                    // asignacion de claves y valores al obeto usuario json
                    usuarioJson.put("id", usuarioID);
                    usuarioJson.put("nombre", usuario.getNombre());
                    usuarioJson.put("apellido", usuario.getApellido());
                    usuarioJson.put("email", usuario.getEmail());

                    // configurar y enviar respuesta al cliente
                    response.setContentType("application/json");    // formato json
                    response.setCharacterEncoding("UTF-8"); // codificacion
                    response.getWriter().write(usuarioJson.toString()); // objeto json enviado al cliente
                    break;
                case "update":
                    // capturar los datos enviados desde el cliente y asignarlos en un objeto usuario
                    usuario.setNombre(request.getParameter("nombre"));
                    usuario.setApellido(request.getParameter("apellido"));
                    usuario.setEmail(request.getParameter("email"));

                    // insertar datos actualizados del usuario a la base de datos
                    usuarioDAO.updateUsuario(usuario);

                    // configurar y enviar respuesta al cliente
                    response.setContentType("text/plain");      //  texto plano
                    response.setCharacterEncoding("UTF-8");     // codificacion
                    response.getWriter().write("success");   // mensaje simple
                    break;
                case "eliminar":
                    // obtener id de usuario
                    String idUsuario = request.getParameter("id");

                    // eliminar usuario de la bd
                    usuarioDAO.deleteUsuario(idUsuario);

                    // configurar y enviar respuesta al cliente
                    response.setContentType("text/plain"); // texto plano
                    response.setCharacterEncoding("UTF-8"); // codificacion de caracteres
                    response.getWriter().write("success"); // mensaje enviado "success" representa exito
                    break;
            }
        } else {
            // redireccionar a la lista
            response.sendRedirect("UsuarioServlet?accion=listar");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }
}