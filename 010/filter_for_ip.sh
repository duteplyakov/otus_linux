#!/bin/sh
# Внимание: разработано для лог-файлов строго определенной структуры!
#
# фильтр для выборки IP-адресов
filter_for_ip() {
    awk '{ print $1 }'
}
