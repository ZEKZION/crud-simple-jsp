<%--
  Created by IntelliJ IDEA.
  User: ZEKZION
  Date: 29/05/2024
  Time: 03:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>

<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Lista de Usuario</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</head>
<body>
    <div class="container">
        <h1>CRUD Usuarios</h1>

        <!-- boton que abre el modal de agregar usuario cuando se hace click en el -->
        <button type="button" class="btn btn-primary mb-3" data-bs-toggle="modal" data-bs-target="#agregarUsuarioModal">
            Agregar Usuario
        </button>

        <!-- Modal para agregar nuevo usuario -->
        <div class="modal fade" id="agregarUsuarioModal" tabindex="-1" aria-labelledby="laberlModalAgregar" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="laberlModalAgregar">Agregar Usuario</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form id="formAgregarUsuario">
                            <div class="mb-3">
                                <label for="id" class="form-label">ID Usuario</label>
                                <input type="text" class="form-control" id="id" name="id" required>
                            </div>
                            <div class="mb-3">
                                <label for="nombre" class="form-label">Nombre</label>
                                <input type="text" class="form-control" id="nombre" name="nombre" required>
                            </div>
                            <div class="mb-3">
                                <label for="apellido" class="form-label">Apellido</label>
                                <input type="text" class="form-control" id="apellido" name="apellido" required>
                            </div>
                            <div class="mb-3">
                                <label for="email" class="form-label">Email</label>
                                <input type="email" class="form-control" id="email" name="email" required>
                            </div>
                            <button type="submit" class="btn btn-primary">Agregar</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <h2>Lista de Usuarios</h2>
        <table class="table table-responsive">
            <thead>
                <tr>
                    <th>ID Usuario</th>
                    <th>Nombres</th>
                    <th>Apellidos</th>
                    <th>Email</th>
                    <th>Acciones</th>
                </tr>
            </thead>
            <tbody id="bodyTablaUsuarios">
                <!-- registros generados dinamicamente desde la base de datos usando jstl -->
                <c:forEach items="${listaUsuarios}" var="usuario">
                    <tr data-id="${usuario.getId()}" data-nombre="${usuario.getNombre()}" data-apellido="${usuario.getApellido()}" data-email="${usuario.getEmail()}">
                        <td>${usuario.getId()}</td>
                        <td>${usuario.getNombre()}</td>
                        <td>${usuario.getApellido()}</td>
                        <td>${usuario.getEmail()}</td>
                        <td>
                            <!-- boton editar usario-->
                            <button class="botonEditar btn btn-warning btn-sm" data-id="${usuario.getId()}">Editar</button>

                            <!-- boton eliminar usuario -->
                            <button class="botonEliminar btn btn-danger btn-sm" data-id="${usuario.getId()}">Eliminar</button>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <!-- Modal para la editar usuario, se cargan los datos existentes en el formulario/modal -->
    <div class="modal fade" id="modal-editar" tabindex="-1" aria-labelledby="label-modal-editar" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="label-modal-editar">Editar Usuario</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="form-editar-usuario">
                        <input type="hidden" id="edit-id">
                        <div class="mb-3">
                            <label for="edit-nombre" class="form-label">Nombre</label>
                            <input type="text" class="form-control" id="edit-nombre" name="nombre" required>
                        </div>
                        <div class="mb-3">
                            <label for="edit-apellido" class="form-label">Apellido</label>
                            <input type="text" class="form-control" id="edit-apellido" name="apellido" required>
                        </div>
                        <div class="mb-3">
                            <label for="edit-email" class="form-label">Email</label>
                            <input type="email" class="form-control" id="edit-email" name="email" required>
                        </div>
                        <button type="submit" class="btn btn-primary">Guardar cambios</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal para confirmar eliminación -->
    <div class="modal fade" id="modal-confirmar-eliminacion" tabindex="-1" aria-labelledby="label-modal-confirmar-eliminacion" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="label-modal-confirmar-eliminacion">Confirmar Eliminación</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    ¿Estás seguro de que deseas eliminar este usuario?
                    <p><strong>ID:</strong> <span id="eliminar-id"></span></p>
                    <p><strong>Nombre:</strong> <span id="eliminar-nombre"></span></p>
                    <p><strong>Apellido:</strong> <span id="eliminar-apellido"></span></p>
                    <p><strong>Email:</strong> <span id="eliminar-email"></span></p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                    <button id="btnConfirmarEliminar" type="button" class="btn btn-danger">Eliminar</button>
                </div>
            </div>
        </div>
    </div>


    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

    <script>
        // funcion que se ejecuta cuando la pagina esta completamente cargada
        $(document).ready(function () {
            // accion para el formulario de registrar usuario
            //capturar el formulario con el evento submit
            $("#formAgregarUsuario").submit(function (event) {
                event.preventDefault();
                // obtener los datos de los inputs
                let id = $("#id").val();
                let nombre = $("#nombre").val();
                let apellido = $("#apellido").val();
                let email = $("#email").val();

                // realizar la accion de registro (add) y enviar al servlet
                $.ajax({
                    url: "UsuarioServlet?accion=add",
                    type: "POST",
                    // datos del usuario enviados al servlet
                    data: {
                        id: id,
                        nombre: nombre,
                        apellido: apellido,
                        email: email
                    },
                    // mensaje de exito que envia el servlet
                    success: function (response) {
                        // crear una nueva fila en el body de la tabla con los atributos data-*
                        // las celdas td incluyen los datos del usuario
                        // alfinal se agregan losbotones de edicion con sus atributos de data-* para el usuario
                        // response contiene los datos enviados desde servlet (datos del usuario)
                        let newFila = "<tr data-id='" +
                                        response.id + "' data-nombre='" +
                                        response.nombre + "' data-apellido='" +
                                        response.apellido + "' data-email='" +
                                        response.email + "'>" +
                            "<td>" + response.id + "</td>" +
                            "<td>" + response.nombre + "</td>" +
                            "<td>" + response.apellido + "</td>" +
                            "<td>" + response.email + "</td>" +
                            "<td>" +
                            "<button class='btn btn-warning botonEditar btn-sm' data-id='" + response.id + "'>Editar</button> " +
                            "<button class='btn btn-danger botonEliminar btn-sm' data-id='" + response.id + "'>Eliminar</button>" +
                            "</td>" +
                            "</tr>";

                        // agregar la fila con el nuevo usuario al prinpicio de la tabla
                        $("#bodyTablaUsuarios").prepend(newFila);
                        // resetear el formulario de registro de usuario
                        $("#formAgregarUsuario")[0].reset();
                        // cerrar el modal de registro de usuario
                        $("#agregarUsuarioModal").modal("hide");
                    },
                    error: function (xhr, status, error) {
                        console.error(xhr.responseText);
                    }
                });
            });

            /*
            mostrar modal con los datos del usuario para confirmar la eliminacion y
            capturar el elemento con la clase .botonEliminar junto con el evento de click
            */
            $("#bodyTablaUsuarios").on("click", ".botonEliminar", function () {
                // obtener el id del usuario desde data-id del boton eliminar
                let idUsuario = $(this).data("id");

                // obtener la fila (tr) donde se encuentra el boton de eliminar
                let row = $(this).closest("tr");

                // extraer los datos del atributo data-nombre del tr (fila del usarlo en la tabla)
                let nombre = row.data("nombre");
                // extraer los datos del atributo data-apellido del tr
                let apellido = row.data("apellido");
                // extraer los datos del atributo data-email del tr
                let email = row.data("email");

                // mostrar datos en el cuerpo del modal
                $("#eliminar-id").text(idUsuario);
                $("#eliminar-nombre").text(nombre);
                $("#eliminar-apellido").text(apellido);
                $("#eliminar-email").text(email);

                // mostrar modal de confirmacion
                $("#modal-confirmar-eliminacion").modal("show");

                // guardar id usuario que sera eliminado
                $("#btnConfirmarEliminar").data("id", idUsuario);
            });


            // confirmar eliminacion y enviarlo  al servlet
            $("#btnConfirmarEliminar").click(function () {
                // recuperar el id del usuario a eliminar que se guardo en el mismo boton
                let idUsuario = $(this).data("id");

                // enviar solicitud al servlet Usuario
                $.ajax({
                    url: "UsuarioServlet?accion=eliminar&id=" + idUsuario,
                    type: "GET",
                    // repuesta de exito del servlet
                    success: function (response) {
                        // ocultar modal de eliminacion
                        $("#modal-confirmar-eliminacion").modal("hide");
                        // eliminar fila (tr) del usuario eliminado
                        $("#bodyTablaUsuarios").find("[data-id='" + idUsuario + "']").closest("tr").remove();
                    },
                    error: function (xhr, status, error) {
                        console.error(xhr.responseText);
                    }
                });
            });

            // evento para cuando se da click en el boton editar
            // aqui se cargara el modal con la informacion del usuario a editar
            $("#bodyTablaUsuarios").on("click", ".botonEditar", function () {
                // obtiene el id del usuario que ese encuentra en data-* en el boton editar
                let usuarioId = $(this).data("id");

                // solicita los datos del usuario con id al servlet usando el metodo get
                $.ajax({
                    url: "UsuarioServlet?accion=get&id=" + usuarioId,
                    type: "GET",
                    success: function (response) {
                        // recibe los datos del servlet de un usuario los muestra en el cuerpo del modal
                        // en las respectivas etiqutas html
                        $("#edit-id").val(response.id);     // id de usuario
                        $("#edit-nombre").val(response.nombre); // nombre de usuario
                        $("#edit-apellido").val(response.apellido); // apellido del usuario
                        $("#edit-email").val(response.email);   // email del u suario

                        // mostrar modal de editar usuario
                        $("#modal-editar").modal("show");
                    },
                    error: function (xhr, status, error) {
                        console.error(xhr.responseText);    // manejo de errores
                    }
                });
            });

            // evento para enviar los datos editados del usuario en el modal
            // obtener el boton y usar el evento submit
            $("#form-editar-usuario").submit(function (event) {
                event.preventDefault();

                // obtiene los valores de los campos del usuario
                let id = $("#edit-id").val();       // nuevo id
                let nombre = $("#edit-nombre").val();   // nuevo nombre
                let apellido = $("#edit-apellido").val();   // nuevo apellido
                let email = $("#edit-email").val(); // nuevo email

                // enviar los datos al servlet del usuario
                $.ajax({
                    url: "UsuarioServlet?accion=update",
                    type: "POST",
                    // datos a enviar al servlet
                    data: {
                        id: id,
                        nombre: nombre,
                        apellido: apellido,
                        email: email
                    },
                    // respuesta de exito del servlet
                    success: function (response) {
                        // cerrar modal de editar
                        $("#modal-editar").modal("hide");

                        //acutalizar fila del cuerpo de la tabla con el usuario id
                        let row = $("#bodyTablaUsuarios").find("[data-id='" + id + "']");
                        // actualizar la columna nombre (1), apellido (2) y email (3)
                        row.find("td:eq(1)").text(nombre);
                        row.find("td:eq(2)").text(apellido);
                        row.find("td:eq(3)").text(email);

                        // actualizar los atributos data-* del usuario editado
                        row.data("nombre", nombre);
                        row.data("apellido", apellido);
                        row.data("email", email);
                    },
                    error: function (xhr, status, error) {
                        console.error("Error al actualizar al usuario. " + error);
                    }
                });
            });
        });
    </script>
</body>
</html>