@echo off
chcp 65001 >nul
echo ========================================
echo Запуск скомпилированного ASM файла
echo ========================================
echo.

REM Можно указать имя файла как параметр: run_asm.bat имя_файла
if "%1"=="" (
    set ASM_NAME=in.txt
) else (
    set ASM_NAME=%~n1
)

set EXE_FILE=CourseProject\%ASM_NAME%.exe

if not exist "%EXE_FILE%" (
    echo Ошибка: Файл %EXE_FILE% не найден!
    echo Сначала запустите build_and_run.bat для компиляции.
    pause
    exit /b 1
)

echo Запуск программы...
echo.

"%EXE_FILE%"

echo.
echo ========================================
echo Программа завершена.
echo ========================================
pause


