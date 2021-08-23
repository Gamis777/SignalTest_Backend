<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;
use Session;

class UsuarioController extends Controller
{
    //
    public function validarUsuario(Request $request){
        $response = Http::post('http://localhost:8082/api/usuarios/validar-credenciales', [
        //$response = Http::post('http://161.132.121.218:8082/api/usuarios/validar-credenciales', [
            'correo' => $request->input('correo_usuario'),
            'clave' => $request->input('clave_usuario'),
        ])->throw()->json();
        Session::put('logeado',true);
        Session::put('datos_usuario',$response['usuario']);
        return $response['estado'];
    }

    public function cerrarSesion(){
        Session::flush();
        return redirect()->route('login');
    }
}
