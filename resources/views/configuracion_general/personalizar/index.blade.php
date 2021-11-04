@extends('layout.principal')
@section('tituloModulo', 'Perzonalizar Web')
@section('contenido')
<div class="row">
    <div class="col-12">

        <section class="content">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-6">
                        <!-- AREA CHART -->
                        <div class="card card-primary">
                            <div class="card-header">
                                <h3 class="card-title">ATRIBUTOS</h3>

                                <div class="card-tools">
                                    <button type="button" class="btn btn-tool" data-card-widget="collapse">
                                        <i class="fas fa-minus"></i>
                                    </button>
                                  
                                </div>
                            </div>
                            <div class="card-body">
                                <div class="chart">
                                    <form id="form_custom">
                                        <!-- <h5>Datos de conexión LDAP</h5> -->
                                        <div class="modal-body">
                                            <input type="hidden" name="id_tecnologia" id="id_tecnologia">
                                            <div class="row">
                                                <label class="col-form-label col-4">Color del panel Izquierdo <span class="text-danger">*</span></label>
                                                <div class="col-8">
                                                    <input type="text" name="color" class="form-control m-b-5" value="">
                                                </div>
                                            </div>
                                            <div class="row">
                                                <label class="col-form-label col-4">Cargar Imagen <span class="text-danger">*</span></label>
                                                <div class="col-8">
                                                    <input type="text" name="logo" class="form-control m-b-5" value="">
                                                </div>
                                            </div>    
                                        
                                        </div>
                                        <div class="modal-footer">
                                            <!-- <button type="button" class="btn btn-info" data-dismiss="modal">Prueba Conexión</button> -->
                                            <button type="submit"   onclick="enviarDatosCustom()" class="btn btn-primary">Guardar</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                            <!-- /.card-body -->
                        </div>
                        <!-- /.card -->

                        <!-- DONUT CHART -->

                        <!-- /.card -->

                        <!-- PIE CHART -->

                        <!-- /.card -->

                    </div>
                    <!-- /.col (LEFT) -->
                    <!-- <div class="col-md-6">
                        <!-- LINE CHART >
                        <div class="card card-info">
                            <div class="card-header">
                                <h3 class="card-title">Configuración de usuarios</h3>

                                <div class="card-tools">
                                    <button type="button" class="btn btn-tool" data-card-widget="collapse">
                                        <i class="fas fa-minus"></i>
                                    </button>
                                 
                                </div>
                            </div>
                            <div class="card-body" style="display: block;">
                                <div class="chart">
                                    <form id="form_tecnologias">
                                        <h5>Tipo de autentificación</h5>
                                        <div class="modal-body">
                                            <input type="hidden" name="id_tecnologia" id="id_tecnologia">
                                           
                                            <div class="form-group">
                                                <div class="form-check">
                                                    <input class="form-check-input" type="radio" name="radio1">
                                                    <label class="form-check-label">Acceso Local</label>
                                                </div>
                                                <div class="form-check">
                                                    <input class="form-check-input" type="radio" name="radio1" checked="">
                                                    <label class="form-check-label">Acceso LDAP</label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="submit" class="btn btn-primary">Guardar</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                            <!-- /.card-body >
                        </div>
                        
                    </div> -->
                    <!-- /.col (RIGHT) -->
                </div>
                <!-- /.row -->
            </div><!-- /.container-fluid -->
        </section>
        <!-- /.card -->
    </div>
    <!-- /.col -->
</div>

<!-- /.modal -->
@endsection
@section('javascript')
<script>
    let id_customs = '';
    // let url_custom = "{{config('app.api_url')}}customs";
    $(document).ready(function() {
        listarCustom();
        $.validator.setDefaults({
            submitHandler: function(form) {
                enviarDatosCustom();
            }
        });
        // $('#form_custom').validate({
        //     ignore: 'input[type=hidden]',
        //     rules: {
        //         color: {
        //             required: true
        //         }
        //     },
        //     messages: {
        //         color: {
        //             required: "Por favor ingrese color."

        //         }
        //     },
        //     errorElement: 'span',
        //     errorPlacement: function(error, element) {
        //         error.addClass('invalid-feedback');
        //         error.insertAfter(element);
        //         //element.closest('.form-group').append(error);
        //     },
        //     highlight: function(element, errorClass, validClass) {
        //         $(element).addClass('is-invalid');
        //     },
        //     unhighlight: function(element, errorClass, validClass) {
        //         $(element).removeClass('is-invalid');
        //     }
        // });
    });
    function listarCustom(){
        // if(id_matriz != 0){
            $.ajax({
                type: "GET",
                url: url_custom+"/"+custom_perfil,
                async: false,
                success: function (response) {
                    console.log("response matriz id: ", response);
                    $('input[name="color"]').val(response.custom.color);
                    $('input[name="logo"]').val(response.custom.logo);
                    id_customs = esponse.custom.id_custom;
                }
            });
        // }
    }
    function enviarDatosCustom(){
        // const id_matriz = $('#id_matriz').val();
        const tipo_envio = "PUT";
        // const url_custom =  url_custom+"/"+1;
        // console.log("id_matriz",id_matriz);
        
        // console.log("url_envio",url_envio);
        // console.log("tipo_envio",tipo_envio);

        const datos_custom = {
            color :  $("input[name='color']").val(),
            logo :  $("input[name='logo']").val(),
            id_perfil :  custom_perfil,

        }
        console.log("datos_custom",datos_custom);
        console.log("url",url_custom+'/'+id_customs);

        $.ajax({
            type: tipo_envio,
            url: url_custom+'/'+id_customs,
            data: JSON.stringify(datos_custom),
            dataType: "json",
            // contentType: "application/json;charset=utf-8",
            success: function (response) {
                toastr.success(response.mensaje);
                console.log("response",response);
                listarCustom();
    
            },
            error: function (request, status, error) {
                //toastr.error(request.responseText);
                toastr.error("No se puede eliminar ya que este registro se esta usando.");
            }
        });
    }
 





</script>
@endsection
