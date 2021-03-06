# language: ru
Функционал: Раздел сериалов
  Для того чтобы привлечь любителей сериалов на наш ресурс
  Нужно показать им выбор среди того что у нас есть

  Предыстория:
  Допустим я залогинен

  Сценарий: Пользователь просматривает список сериалов
    Допустим есть такие сериалы:
    | название               | оригинальное название |
    | Доктор Хаус            | House M.D             |
    | Декстер                | Dexter                |
    | Отчаенные домохозяйки  | Desperate Housewives  |
    | Лост                   | Lost                  |
    | Теория большого взрыва | The big bang theory   |
    Когда я захожу в раздел сериалов
    То я должен увидеть список сериалов в таком порядке:
    | Декстер                |
    | Доктор Хаус            |
    | Лост                   |
    | Отчаенные домохозяйки  |
    | Теория большого взрыва |
    И я должен увидеть 5 иконок
    К тому же я должен увидеть "House M.D"
    И я должен увидеть "Dexter"
    И я должен увидеть "Desperate Housewives"
    И я должен увидеть "Lost"
    И я должен увидеть "The big bang theory"

  Сценарий: Пользователь выбирает сериал
    Допустим есть сериал "Доктор Хаус"
    Когда я захожу в раздел сериалов
    И я иду по ссылке "Доктор Хаус"
    То я должен быть на странице сериала "Доктор Хаус"
