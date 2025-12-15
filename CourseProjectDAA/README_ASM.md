# Компиляция и запуск ASM файлов

## Быстрый старт

1. **Сгенерируйте ASM файл** запустив компилятор:
   ```
   CourseProject.exe -in:in.txt
   ```
   Это создаст файл `in.txt.asm` (обычно в папке `Debug\` или `CourseProject\`)

2. **Запустите скрипт компиляции и запуска**:
   ```
   build_and_run.bat
   ```
   Или для конкретного файла:
   ```
   build_and_run.bat in.txt
   ```

## Автоматическая компиляция и запуск

### Способ 1: Использование готового скрипта
1. Запустите `build_and_run.bat` - скрипт автоматически:
   - Найдет ASM файл в `Debug\` или `CourseProject\`
   - Скомпилирует ASM файл в OBJ
   - Соберет исполняемый файл (EXE)
   - Запустит программу и покажет вывод

### Способ 2: Только запуск (если уже скомпилировано)
1. Запустите `run_asm.bat` - скрипт запустит уже скомпилированный файл

## Ручная компиляция

Если нужно скомпилировать вручную:

### Шаг 1: Компиляция ASM в OBJ
```batch
ml.exe /c /nologo /Zi /Fo"Debug\in.txt.obj" /W3 /errorReport:prompt /Ta"Debug\in.txt.asm"
```

### Шаг 2: Линковка OBJ в EXE
```batch
link.exe /OUT:"Debug\in.txt.exe" /NOLOGO kernel32.lib user32.lib libucrt.lib "Debug\CourseProject_LIB.lib" "Debug\in.txt.obj" /SUBSYSTEM:CONSOLE /MACHINE:X86
```

### Шаг 3: Запуск
```batch
Debug\in.txt.exe
```

## Требования

- Microsoft Visual Studio (для ml.exe и link.exe)
- Собранная библиотека `Debug\CourseProject_LIB.lib`
- Сгенерированный ASM файл `Debug\in.txt.asm`

## Примечания

- ASM файл генерируется автоматически при запуске компилятора с параметром `-in:in.txt`
- Если нужно изменить имя входного файла, используйте: `-in:имя_файла.txt -out:имя_файла.asm`
- Все файлы по умолчанию создаются в папке `Debug\`

