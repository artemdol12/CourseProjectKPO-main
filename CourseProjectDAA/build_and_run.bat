@echo off
chcp 65001 >nul
echo ========================================
echo Компиляция и запуск ASM файла
echo ========================================
echo.

REM ----------------------------------------
REM Инициализация среды Visual C++ (ml.exe, link.exe)
REM Попытка автоматически подключить инструменты VS 2022 Community для x86
REM Если у тебя другая версия/путь, поправь строку ниже под свой vcvarsall.bat
if exist "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvarsall.bat" (
    call "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvarsall.bat" x86 >nul
) else (
    echo [ВНИМАНИЕ] Не найден vcvarsall.bat по пути VS 2022 Community.
    echo Если получишь ошибки 'ml.exe is not recognized' или 'link.exe is not recognized',
    echo запусти build_and_run.bat из "Developer Command Prompt for VS" или
    echo укажи правильный путь к vcvarsall.bat в самом начале build_and_run.bat.
    echo.
)

REM Можно указать имя файла как параметр: build_and_run.bat имя_файла
if "%1"=="" (
    set ASM_NAME=in.txt
) else (
    set ASM_NAME=%~n1
)

REM Ищем asm файл ТОЛЬКО в папке CourseProject
set ASM_FILE=
set WORK_DIR=CourseProject
if exist "%WORK_DIR%\%ASM_NAME%.asm" (
    set ASM_FILE=%WORK_DIR%\%ASM_NAME%.asm
) else (
    echo Ошибка: Файл %ASM_NAME%.asm не найден!
    echo Ожидался путь: %WORK_DIR%\%ASM_NAME%.asm
    echo Сначала запустите компилятор для генерации ASM файла.
    echo Использование: build_and_run.bat [имя_файла]
    echo Пример: build_and_run.bat in.txt
    pause
    exit /b 1
)

set OBJ_FILE=%WORK_DIR%\%ASM_NAME%.obj
set EXE_FILE=%WORK_DIR%\%ASM_NAME%.exe
set LIB_FILE=Debug\CourseProject_LIB.lib

echo Найден ASM файл: %ASM_FILE%
echo Рабочая директория: %WORK_DIR%
echo Путь к библиотеке: %LIB_FILE%
echo.

REM Проверяем существование библиотеки
if not exist "%LIB_FILE%" (
    echo Ошибка: Библиотека %LIB_FILE% не найдена!
    echo Сначала соберите проект CourseProject_LIB.
    pause
    exit /b 1
)

echo Шаг 1: Компиляция ASM файла...
cd %WORK_DIR%
ml.exe /c /nologo /Zi /Fo"%ASM_NAME%.obj" /W3 /errorReport:prompt /Ta"%ASM_NAME%.asm"
cd ..

if errorlevel 1 (
    echo Ошибка при компиляции ASM файла!
    pause
    exit /b 1
)

echo Шаг 2: Линковка...
cd %WORK_DIR%
link.exe /ERRORREPORT:PROMPT /OUT:"%ASM_NAME%.exe" /INCREMENTAL /NOLOGO kernel32.lib user32.lib libucrt.lib "..\%LIB_FILE%" "%ASM_NAME%.obj" /SUBSYSTEM:CONSOLE /MACHINE:X86
cd ..

if errorlevel 1 (
    echo Ошибка при линковке!
    pause
    exit /b 1
)

echo.
echo ========================================
echo Компиляция успешна!
echo ========================================
echo.
echo Запуск программы...
echo.

"%WORK_DIR%\%ASM_NAME%.exe"

echo.
echo ========================================
echo Программа завершена.
echo ========================================
pause

