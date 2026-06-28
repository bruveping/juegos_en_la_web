
@echo off
title Servidor Portable carrera ciber punk
set PORT=8000

:: --- CONFIGURACIÓN MANUAL ---
:: Pegá acá la ruta a la CARPETA donde está tu python.exe portable
set "PYTHON_PATH=D:\misDocumentos20180227\Programas\python\pPython3\WPy64-31290\python"
:: ----------------------------

set "PY_EXE=%PYTHON_PATH%\python.exe"

:: Verificar si el ejecutable existe
if not exist "%PY_EXE%" (
    echo [ERROR] No se encontro python.exe en: 
    echo %PYTHON_PATH%
    pause
    exit
)

echo [OK] Iniciando servidor en puerto %PORT%...

:: Iniciar el servidor y capturar su Process ID (PID)
:: Usamos "start /b" para correrlo en la misma ventana pero en segundo plano
start /b "" "%PY_EXE%" -m http.server %PORT% > nul 2>&1

:: Abrir el navegador con el visor
start http://localhost:%PORT%/visor_3D_rapido.html
echo.
echo ======================================================
echo   SERVIDOR ACTIVO EN: http://localhost:%PORT%
echo ======================================================
echo.
echo  [!] PARA CERRAR EL SERVIDOR: Presiona cualquier tecla 
echo      en ESTA VENTANA o simplemente cerrala.
echo.

:: Pausa el script aquí. Al presionar una tecla, sigue a la siguiente línea.
pause > nul

:: --- LIMPIEZA AL SALIR ---
echo Cerrando procesos de Python en el puerto %PORT%...
for /f "tokens=5" %%a in ('netstat -aon ^| findstr :%PORT% ^| findstr LISTENING') do taskkill /f /pid %%a > nul 2>&1

echo [OK] Servidor cerrado correctamente.
timeout /t 2 > nul
exit
