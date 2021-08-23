<?php

use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', function () { return view('layout.login'); })->name('login');
Route::post('/validar-usuario','UsuarioController@validarUsuario')->name('validar-usuario');
Route::get('/cerrar-sesion','UsuarioController@cerrarSesion')->name('cerrar-sesion');

Route::group(['middleware' => 'varificarSesion'], function () {
    Route::get('/principal', function () {   return view('principal.index');})->name('principal');

    #Configuracion general
    Route::group(['prefix' => 'configuracion-general'], function () {
        Route::get('/usuarios', function(){return view('configuracion_general.usuarios.index'); })->name('usuarios');
        Route::get('/perfiles', function(){return view('configuracion_general.perfiles.index'); })->name('perfiles');
        Route::get('/ldap', function(){return view('configuracion_general.ldap.index'); })->name('ldap');
    });

    #Configuracion avanzada
    Route::group(['prefix' => 'configuracion-avanzada'], function () {
        Route::get('/tecnologias', function(){return view('configuracion_avanzada.tecnologias.index'); })->name('tecnologias');
        Route::get('/operadores', function(){return view('configuracion_avanzada.operadores.index'); })->name('operadores');
        Route::get('/equipos', function(){return view('configuracion_avanzada.equipos.index'); })->name('equipos');
        Route::get('/numeros-externos', function(){return view('configuracion_avanzada.numeros_externos.index'); })->name('numeros_externos');
    });

    #Generador de pruebas
    Route::group(['prefix' => 'generador-pruebas'], function () {
        Route::get('/matrices', function(){return view('generador_pruebas.matrices.index'); })->name('matrices');
        Route::get('/lanzador-pruebas', function(){return view('generador_pruebas.lanzador_pruebas.index'); })->name('pruebas');
    });

    #Reportes
    Route::group(['prefix' => 'reportes'], function () {
        Route::get('/reporte-prueba', function(){return view('reportes.reporte_pruebas.index'); })->name('reporte_prueba');
        Route::get('/informe-calidad', function(){return view('reportes.reporte_calidad.index'); })->name('reporte_calidad');
        Route::get('/reporte-disa', function(){return view('reportes.reporte_disa.index'); })->name('reporte_disa');
        //Route::get('/reporte-matriz', function(){return view('reportes.reporte_matriz.index'); })->name('reporte_matriz');
    });

    #Disa
    Route::group(['prefix' => 'disa'], function () {
        Route::get('/registro-clave', function(){return view('disa.registro_clave.index'); })->name('registro_clave');
    });
});
/*Route::get('/usuarios', function () {
    return view('usuarios.index');
});
Route::get('/perfiles', function () {
    return view('perfiles.index');
});
Route::get('/tecnologias', function () {
    return view('tecnologias.index');
});
Route::get('/operadores', function () {
    return view('operadores.index');
});
Route::get('/equipos', function () {
    return view('equipos.index');
});
Route::get('/numeros-externos', function () {
    return view('numeros_externos.index');
});
Route::get('/matrices', function () {
    return view('matrices.index');
});
Route::get('/lanzador-pruebas', function () {
    return view('lanzador_pruebas.index');
});
Route::get('/reporte-pruebas', function () {
    return view('reporte_pruebas.index');
});
Route::get('/reporte-matriz', function () {
    return view('reporte_matriz.index');
});
Route::get('/reporte-disa', function () {
    return view('reporte_disa.index');
});
Route::get('/configuracion-api', function () {
    return view('configuracion_api.index');
});
Route::get('/registro-clave', function () {
    return view('registro_clave.index');
});
*/
