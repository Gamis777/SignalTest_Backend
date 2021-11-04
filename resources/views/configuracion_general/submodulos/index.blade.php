@extends('layout.principal')
@section('tituloModulo', 'Submodulos')
@section('contenido')
<div class="row">
    <div class="col-12">
      <div class="card">
        <!-- /.card-header -->
        <div class="card-body">
            <div class="table-responsive">
                <table id="tabla_usuarios" class="table table-bordered table-striped">
                    <thead>
                        <tr>
                            <th>Nombre</th>
                            <th>Ruta</th>
                            <th>Icono</th>
                            <th>Modulo</th>
                            <th>Opciones</th>
                        </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
        </div>
        <!-- /.card-body -->
      </div>
      <!-- /.card -->
    </div>
    <!-- /.col -->
</div>
<div class="modal fade" id="modal-default">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h2 class="modal-title" id="titulo_modal"></h2>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <form id="form_usuarios" >
            <div class="modal-body">
                <input type="hidden" name="id_usuario" id="id_usuario">
 
                <div class="form-group row">
                    <label class="col-form-label col-4">Nombre <span class="text-danger">*</span></label>
                    <div class="col-8">
                        <input type="text" name="nombre" class="form-control m-b-5">
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-form-label col-4">Ruta <span class="text-danger">*</span></label>
                    <div class="col-8">
                        <input type="text" name="ruta" class="form-control m-b-5">
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-form-label col-4">Icono <span class="text-danger">*</span></label>
                    <div class="col-8">
                        <input type="text" name="icono" id="clave" class="form-control m-b-5">
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-form-label col-4">Modulo <span class="text-danger">*</span></label>
                    <div class="col-8">
                        <select class="form-control" name="id_modulo" >
                        </select>
                    </div>
                </div>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-dismiss="modal">Cerrar</button>
                <button type="submit" class="btn btn-primary">Guardar</button>
            </div>
        </form>
      </div>
      <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<!-- /.modal -->
@endsection
@section('javascript')
    <script>
        let id_submodulo_ = 0;
        $(document).ready(function () {
            listarSubmodulos();
            $.validator.setDefaults({
                submitHandler: function (form) {
                    enviarDatosSubmodulos();
                }
            });
            $('#form_usuarios').validate({
                ignore: 'input[type=hidden]',
                rules: {
                    nombre : {
                        required: true,
                    },
                    ruta : {
                        required: true
                    },
                    icono : {
                        required: true
                    },
                    id_modulo : {
                        required: true
                    }
                },
                messages: {
                    nombre : {
                        required: "Por favor ingrese nombre."
                    },
                    ruta : {
                        required: "Por favor ingrese ruta."
                    },
                    icono : {
                        required: "Por favor ingrese icono."
                    },
                    id_modulo : {
                        required: "Por favor seleccione modulo."
                    }
                },
                errorElement: 'span',
                errorPlacement: function (error, element) {
                    error.addClass('invalid-feedback');
                    error.insertAfter(element);
                    //element.closest('.form-group').append(error);
                },
                highlight: function (element, errorClass, validClass) {
                    $(element).addClass('is-invalid');
                },
                unhighlight: function (element, errorClass, validClass) {
                    $(element).removeClass('is-invalid');
                }
            });
            // $("#tabla_usuarios").on('change','.custom-control-input',function(){
            //     const id_usuario = $(this).attr('id').replace("switchAcceso","");
            //     const acceso = ($(this).prop('checked'))?'A':'D';
            //     $.ajax({
            //         type: "PUT",
            //         url: url_submodulos+"/"+id_usuario,
            //         data: {
            //             acceso : acceso
            //         },
            //         success: function (response) {
            //             toastr.success(response.mensaje);
            //         },
            //         error: function (request, status, error) {
            //             //toastr.error(request.responseText);
            //             toastr.error("Error al actualizar el usuario.");
            //         }
            //     });
            // });
        });
        function listarSubmodulos() {
            $('#tabla_usuarios').DataTable().clear().destroy();
            var table =$("#tabla_usuarios").DataTable({
                responsive: true,
                autoWidth: false,
                pageLength: 25,
                lengthChange: false,
                language: {
                    url: 'https://cdn.datatables.net/plug-ins/1.10.21/i18n/Spanish.json'
                },
                buttons: [
                    {
                        text: 'Agregar Submodulo',
                        className: 'btn btn-success',
                        action: function ( e, dt, node, config ) {
                            abrirModal();
                        }
                    }
                ],
                initComplete: function () {
                    setTimeout( function () {
                        table.buttons().container().appendTo( '#tabla_usuarios_wrapper .col-md-6:eq(0)' );
                    }, 10 );
                },
                ajax: {
                    url: url_submodulos,
                    dataSrc: "submodulo"
                },
                columns: [
                    { data: "nombre" },
                    { data: "ruta" },
                    { data: "icono" },
                    { data: "id_modulo" },
               
                    {
                        render: function ( data, type, row ) {
                            return '<button class="btn btn-primary btn-sm" onClick="abrirModal('+row.id_submodulo+')"><i class="fas fa-edit"></i> Editar</button> <button class="btn btn-danger btn-sm" onClick="eliminarSubmodulo('+row.id_submodulo+')"><i class="fas fa-times"></i> Eliminar</button>';
                        },
                        targets: 5
                    }
                ],
                order: [[0, 'asc']]
            });
        }
        function abrirModal(id_submodulo = 0) {
            const titulo_modal = id_submodulo == 0 ? 'Crear Submodulo' : 'Actualizar Submodulo';
            $('#titulo_modal').text(titulo_modal);
            console.log("id_sub: ",id_submodulo);
            $('#id_usuario').val(id_submodulo);
            console.log("id_sub: ",$('#id_usuario').val());

            limpiarFormulario('form_usuarios');
            llenarOpcionModulo();
            if(id_submodulo != 0){
                $.ajax({
                    type: "GET",
                    url: url_submodulos+"/"+id_submodulo,
                    async: false,
                    success: function (response) {
                        console.log(response)
                        $('input[name="nombre"]').val(response.submodulo.nombre);
                        $('input[name="ruta"]').val(response.submodulo.ruta);
                        $('input[name="icono"]').val(response.submodulo.icono);
                        $('select[name="id_modulo"]').val(response.submodulo.id_modulo);
                    }
                });
            }
            $('#modal-default').modal('show');
        }
        function enviarDatosSubmodulos(){
            console.log("enviar Datos");
            console.log("id_submodulo",$('#id_submodulo').val());
            const id_submodulo = $('#id_usuario').val();
            const tipo_envio = id_submodulo == 0 ? "POST" : "PUT";
            const url_envio = id_submodulo == 0 ? url_submodulos : url_submodulos+"/"+id_submodulo;
            $.ajax({
                type: tipo_envio,
                url: url_envio,
                data: $('#form_usuarios').serialize(),
                success: function (response) {
                    console.log(response)
                    toastr.success(response.mensaje);
                    listarSubmodulos();
                    limpiarFormulario('form_usuarios');
                    $('#modal-default').modal('hide');
                },
                error: function (request, status, error) {
                    //toastr.error(request.responseText);
                    toastr.error("No se puede enviar ya que este registro.");
                }
            });
        }
        function llenarOpcionModulo() {
            let modulos = $('select[name="id_modulo"]');
            $.ajax({
                type: "GET",
                url: url_modulos,
                async: false,
                success: function (response) {
                    modulos.find('option').remove();
                    modulos.append('<option value="">Seleccione</option>');
                    $(response.modulos).each(function(i, v){
                        modulos.append('<option value="' + v.id_modulo + '">' + v.nombre + '</option>');
                    })
                },
                error: function (request, status, error) {
                    //toastr.error(request.responseText);
                    toastr.error("Error al obtener los datos.");
                }
            });
        }
        function eliminarSubmodulo(id_submodulo){
            Swal.fire({
                title: '¿Estas seguro de eliminar el usuario seleccionado?',
                //text: "You won't be able to revert this!",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                cancelButtonText: 'No',
                confirmButtonText: 'Si'
            }).then((result) => {
                if (result.value) {
                    $.ajax({
                        url: url_submodulos+"/"+id_submodulo,
                        type: 'DELETE',
                        success: function (response) {
                            toastr.success(response.mensaje);
                            listarSubmodulos();
                        },
                        error: function (request, status, error) {
                            //toastr.error(request.responseText);
                            toastr.error("Error al eliminar : Este registro esta siendo utilizado.");
                        }
                    });
                }
            })
        }
    </script>
@endsection
