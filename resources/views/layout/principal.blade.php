<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>Proyecto | Signal</title>
  <link rel="shortcut icon" href="dist/img/entel-logo.png" type="image/x-icon">
  <!-- Tell the browser to be responsive to screen width -->
  <meta name="viewport" content="width=device-width, initial-scale=1">

  <!-- Font Awesome -->
  <link rel="stylesheet" href="{{ asset('plugins/fontawesome-free/css/all.min.css')}}">
  <!-- Ionicons -->
  <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
  <!-- Toastr -->
  <link rel="stylesheet" href="{{ asset('plugins/toastr/toastr.min.css')}}">
  <!-- SweetAlert2 -->
  <link rel="stylesheet" href="{{ asset('plugins/sweetalert2/sweetalert2.min.css')}}">

    <!-- Graphzs -->
    <link rel="stylesheet" href="{{ asset('plugins/graphz/style.css')}}">

  <!-- DataTables -->
  <link rel="stylesheet" href="{{ asset('plugins/datatables-bs4/css/dataTables.bootstrap4.min.css')}}">
  <link rel="stylesheet" href="{{ asset('plugins/datatables-responsive/css/responsive.bootstrap4.min.css')}}">
  <link rel="stylesheet" href="{{ asset('plugins/datatables-buttons/css/buttons.bootstrap4.min.css')}}">
  <link rel="stylesheet" href="{{ asset('plugins/datatables-rowgroup/css/rowGroup.bootstrap4.min.css')}}">
  <link rel="stylesheet" href="{{ asset('plugins/datatables-select/css/select.dataTables.min.css')}}">
  <!-- Theme style -->
  <link rel="stylesheet" href="{{ asset('dist/css/adminlte.min.css')}}">
  <!-- Google Font: Source Sans Pro -->
  <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700" rel="stylesheet">
  @yield('css')
</head>
<body class="hold-transition sidebar-mini text-sm">
<div class="wrapper">
  <!-- Navbar -->
  <nav class="main-header navbar navbar-expand navbar-white navbar-light">
    <!-- Left navbar links -->
    <ul class="navbar-nav">
      <li class="nav-item">
        <a class="nav-link" data-widget="pushmenu" href="#" role="button"><i class="fas fa-bars"></i></a>
      </li>
    </ul>
    <ul class="navbar-nav ml-auto">
        <a href="{{route('cerrar-sesion')}}" >
            <i class="fas fa-power-off mr-2"></i> Cerrar sesión
        </a>
    </ul>
  </nav>
  <!-- /.navbar -->

  <!-- Main Sidebar Container -->
  <aside class="main-sidebar sidebar-dark-primary elevation-4" id="color-change">
    <!-- Brand Logo -->
    <a href="" class="brand-link navbar-primary"> 
      <img src="{{ asset('dist/img/entel-logo.png')}}"
           alt="AdminLTE Logo"
           class="brand-image img-circle elevation-3"
           >
      <span class="brand-text font-weight-light">Entel</span>
    </a>

    <!-- Sidebar -->
    <div class="sidebar">
      <!-- Sidebar user (optional) -->
      <div class="user-panel mt-3 pb-3 mb-3 d-flex">
        <div class="image">
          <img src="{{ asset('dist/img/user2-160x160.jpg')}}" class="img-circle elevation-2" alt="User Image">
        </div>
        <div class="info">
          <a class="d-block">{{Session::get('datos_usuario')['nombres']}} {{Session::get('datos_usuario')['apellidos']}} </a>
          <p id="sesion_perfil"  >{{Session::get('datos_usuario')['id_perfil']}}</p> 
        </div>
      </div>

      <!-- Sidebar Menu -->
      <nav class="mt-2">
        <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
          <!-- Add icons to the links using the .nav-icon class
               with font-awesome or any other icon font library -->
            <li class="nav-item ">
                <a href="{{route('principal')}}" class="nav-link">
                    <i class="fas fa-desktop nav-icon"></i>
                    <p>Principal</p>
                </a>
            </li>
            @foreach(Session::get('datos_usuario')['accesos'] as $modulo)
                <li class="nav-item has-treeview {{ Request::is($modulo['ruta']."/*") ? 'menu-open' : '' }}">
                    <a href="#" class="nav-link {{ Request::is($modulo['ruta']."/*") ? 'active' : '' }}">
                        <!--<i class="fas fa-circle nav-icon"></i>-->
                        <i class="{{$modulo['icono']}} nav-icon"></i>
                        <p>
                            {{$modulo['nombre']}}
                            <i class="right fas fa-angle-left"></i>
                        </p>
                    </a>
                    <ul class="nav nav-treeview">
                        @foreach($modulo['submodulos'] as $submodulo)
                            <li class="nav-item">
                                <a href="{{url('')}}/{{$modulo['ruta']}}/{{$submodulo['ruta']}}" class="nav-link {{ Request::is($modulo['ruta']."/".$submodulo['ruta']) ? 'active' : '' }}">
                                    <i class="far fa-circle nav-icon"></i>
                                    <p>{{$submodulo['nombre']}}</p>
                                </a>
                            </li>
                        @endforeach
                    </ul>
                </li>
            @endforeach
        </ul>
      </nav>
      <!-- /.sidebar-menu -->
    </div>
    <!-- /.sidebar -->
  </aside>

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1>@yield('tituloModulo')</h1>
          </div>
          <!--<div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="#">Home</a></li>
              <li class="breadcrumb-item active">DataTables</li>
            </ol>
          </div>-->
        </div>
      </div><!-- /.container-fluid -->
    </section>

    <!-- Main content -->
    <section class="content">
        @yield('contenido')
    </section>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->
  <footer class="main-footer">
    <div class="float-right d-none d-sm-block">
      <b>Version</b> 3.0.3
    </div>
    <strong>Copyright &copy; 2021 <a href="http://wpnis.newip.pe">NEW IP SOLUTIONS</a>.</strong> Todos los derechos reservados
  </footer>

  <!-- Control Sidebar -->
  <aside class="control-sidebar control-sidebar-dark">
    <!-- Control sidebar content goes here -->
  </aside>
  <!-- /.control-sidebar -->
</div>
<!-- ./wrapper -->

<!-- jQuery -->
<script src="{{ asset('plugins/jquery/jquery.min.js')}}"></script>
<!-- Bootstrap 4 -->
<script src="{{ asset('plugins/bootstrap/js/bootstrap.bundle.min.js')}}"></script>
<!-- DataTables -->
<script src="{{ asset('plugins/datatables/jquery.dataTables.min.js')}}"></script>
<script src="{{ asset('plugins/datatables-bs4/js/dataTables.bootstrap4.min.js')}}"></script>
<script src="{{ asset('plugins/datatables-responsive/js/dataTables.responsive.min.js')}}"></script>
<script src="{{ asset('plugins/datatables-responsive/js/responsive.bootstrap4.min.js')}}"></script>
<script src="{{ asset('plugins/datatables-buttons/js/dataTables.buttons.min.js')}}"></script>
<script src="{{ asset('plugins/datatables-buttons/js/buttons.bootstrap4.min.js')}}"></script>
<script src="{{ asset('plugins/jszip/jszip.min.js')}}"></script>
<script src="{{ asset('plugins/pdfmake/pdfmake.min.js')}}"></script>
<script src="{{ asset('plugins/pdfmake/vfs_fonts.js')}}"></script>
<script src="{{ asset('plugins/datatables-buttons/js/buttons.html5.min.js')}}"></script>
<script src="{{ asset('plugins/datatables-buttons/js/buttons.print.js')}}"></script>
<script src="{{ asset('plugins/datatables-buttons/js/buttons.colVis.min.js')}}"></script>
<script src="{{ asset('plugins/datatables-rowgroup/js/dataTables.rowGroup.min.js')}}"></script>
<script src="{{ asset('plugins/datatables-select/js/dataTables.select.min.js')}}"></script>
<!-- Toastr -->
<script src="{{ asset('plugins/toastr/toastr.min.js')}}"></script>
<!-- Bootstrap Switch -->
<script src="{{ asset('plugins/bootstrap-switch/js/bootstrap-switch.min.js')}}"></script>
<!-- jquery-validation -->
<script src="{{ asset('plugins/jquery-validation/jquery.validate.min.js') }}"></script>
<script src="{{ asset('plugins/jquery-validation/additional-methods.min.js') }}"></script>
<!-- SweetAlert2 -->
<script src="{{ asset('plugins/sweetalert2/sweetalert2.min.js')}}"></script>
<!-- AdminLTE App -->
<script src="{{ asset('dist/js/adminlte.min.js')}}"></script>
<!-- FLOT CHARTS -->
<script src="{{ asset('plugins/flot-old/jquery.flot.js') }}"></script>
<!-- FLOT RESIZE PLUGIN - allows the chart to redraw when the window is resized -->
<script src="{{ asset('plugins/flot-old/jquery.flot.resize.js') }}"></script>
<!-- FLOT PIE PLUGIN - also used to draw donut charts -->
<script src="{{ asset('plugins/flot-old/jquery.flot.pie.js') }}"></script>
<!-- AdminLTE for demo purposes -->
<script src="{{ asset('dist/js/demo.js')}}"></script>
<!-- Datos de api -->
<script src="{{ asset('plugins/pdf/jspdf.min.js') }}"></script>
<script src="{{ asset('plugins/pdf/jspdf.plugin.autotable.min.js') }}"></script>


<!-- <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.js"></script> -->
<script src="{{ asset('plugins/bootstrap/js/moment.min.js') }}"></script>
<!-- <script src="//cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.js"></script> -->
<script src="{{ asset('plugins/bootstrap/js//bootstrap-datetimepicker.min.js') }}"></script>


<script>
    var url_perfiles = "{{config('app.api_url')}}perfiles";
    var url_modulos = "{{config('app.api_url')}}modulos";
    var url_submodulos = "{{config('app.api_url')}}submodulos";
    var url_usuarios = "{{config('app.api_url')}}usuarios";
    var url_tecnologias = "{{config('app.api_url')}}tecnologias";
    var url_operadores = "{{config('app.api_url')}}operadores-telefonicos";
    var url_externos = "{{config('app.api_url')}}numeros-externos";
    var url_equipos = "{{config('app.api_url')}}equipos";
    var url_matrices = "{{config('app.api_url')}}matrices";
    var url_pruebas = "{{config('app.api_url')}}pruebas";
    var url_registro_clave = "{{config('app.api_url')}}registro-clave";
    var url_canales = "{{config('app.api_url')}}canales";
    var url_sedes = "{{config('app.api_url')}}sedes";
    var url_ejecuciones = "{{config('app.api_url')}}ejecuciones";
    var url_pdf = "{{config('app.api_url')}}ejecuciones/test_pdf";
    var url_custom = "{{config('app.api_url')}}customs";
    var custom_perfil = '';
    function limpiarFormulario(nombreForm) {
        $("#"+nombreForm).validate().resetForm();
        $("#"+nombreForm)[0].reset();
    }

    function obtener_custom(){
        // console.log("idEjecucion: ",id);
        let id_custom = document.getElementById('sesion_perfil');
        custom_perfil = id_custom.innerText;
        console.log(id_custom.innerText);
        $.ajax({
            url: url_custom+"/"+id_custom.innerText,
            method: 'get',
            dataType: 'json',
            async: false,
            success: function (data){
                // console.log("id prueba ajax url_pruebas ",id);
                // console.log("id ejecu url_pruebas ",data.prueba.ejecuciones[0].id_ejecucion);
              console.log(data.custom.color);
              $("#color-change").css("background-color",data.custom.color);

            }
        });
        
    }
    obtener_custom();
</script>
@yield('javascript')
</body>
</html>
