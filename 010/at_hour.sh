#!/bin/sh
# Функция получения предыдущего часа в формате %d/%b/%Y:%H, который необходим для
# осуществления выборки из лог-файла с датой указанного формата
# Как использовать:
#
#         #!/bin/sh
#         . ./at_hour.sh
#         at_hour=$(hour)
#         echo $at_hour
hour() {
    # local d=$(LANG=en_EN date -d '1 hour ago' +%d/%b/%Y:%H)
    # Так как необходимо производить выборку за предыдущий час из лога,
    # то производится -d '1 hour ago'
    # При этом локаль принудительно LANG=en_EN, иначе генерирует дату в текущей локали
    # Поскольку в тестовом файле априори нет сведений за прошлый час 2021 года,
    # а только за 14-15 августа 2019 г., то искусственно перенесемся в то время,
    # вычев еще необходимо количество часов, для 8 июля 2021 г. - это еще минус 15913 часов
    #
    corrective=16008
    formatted_hour=$(LANG=en_EN date -d "$corrective hour ago" +%d/%b/%Y:%H) #
    echo $formatted_hour
}