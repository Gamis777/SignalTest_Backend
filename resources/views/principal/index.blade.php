@extends('layout.principal')
@section('tituloModulo', 'Principal')
@section('contenido')
<div class="container-fluid">
    <div class="row">
        <div class="col-lg-3 col-6">
            <div class="card">
                <div class="card-header">
                  <strong>Configuración General</strong>
                </div>
                <div class="card-body">
                  <!--<h5 class="card-title">Special title treatment</h5>
                  <p class="card-text">With supporting text below as a natural lead-in to additional content.</p>
                  <a href="#" class="btn btn-primary">Go somewhere</a>-->
                  <a href="{{ route('usuarios') }}" class="card-text">Gestión de usuarios</a><br>
                  <a href="{{ route('perfiles') }}" class="card-text">Gestión de perfiles</a>
                </div>
            </div>
        </div>
        <div class="col-lg-3 col-6">
            <!-- small box -->
            <div class="card">
                <div class="card-header">
                    <strong>Configuraciones</strong>
                </div>
                <div class="card-body">
                    <a href="{{ route('tecnologias') }}" class="card-text">Tecnologias</a><br>
                    <a href="{{ route('operadores') }}" class="card-text">Operadores Telefónicos</a><br>
                    <a href="{{ route('equipos') }}" class="card-text">Equipos</a><br>
                    <a href="{{ route('numeros_externos') }}" class="card-text">Numeros externos</a><br>
                </div>
            </div>
        </div>
        <!-- ./col -->
        <div class="col-lg-3 col-6">
            <div class="card">
                <div class="card-header">
                    <strong>Generador de pruebas</strong>
                </div>
                <div class="card-body">
                    <a href="{{ route('matrices') }}" class="card-text">Matrices</a><br>
                    <a href="{{ route('pruebas') }}" class="card-text">Lanzador de Pruebas</a><br>
                </div>
            </div>
        </div>
        <div class="col-lg-3 col-6">
            <div class="card">
                <div class="card-header">
                    <strong>Reportes</strong>
                </div>
                <div class="card-body">
                    <a href="{{route('reporte_prueba')}}" class="card-text">Reporte de Prueba</a><br>
                    <a href="{{route('reporte_disa')}}" class="card-text">Reporte DISA</a><br>
                    <!-- <a href="#" class="card-text">Informe de Calidad</a><br> -->
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-3 col-6">
            <div class="card">
                <div class="card-header">
                  <strong>DISA</strong>
                </div>
                <div class="card-body">
                  <a href="{{ route('registro_clave') }}" class="card-text">Registro de clave</a><br>
                </div>
            </div>
        </div>
    </div>
</div>
@endsection

