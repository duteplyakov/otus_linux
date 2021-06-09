#!/bin/sh
# Внимание: разработано для лог-файлов строго определенной структуры!
#
# Функция применит фильтр к записям файла, с целью выборки
# неимеющих HTTP-статуса в емкости 200-299, считая их "ошибками"
filter_rows_with_error_status() {
    awk 'BEGIN { FS = "\" "; OFS= "#"} ; {print $0,$2}' | awk 'BEGIN { FS = "#" }; { if (!(match($2,/2.*/))) { print $1 }}'
}
