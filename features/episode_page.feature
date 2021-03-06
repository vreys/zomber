# language: ru
Функционал: Страница эпизода
  Для того чтобы смотреть сериалы
  Мне как пользователю нужна страница с плеером 
  для каждого эпизода

  Предыстория:
  Допустим я залогинен

  Сценарий: Пользователь смотрит на страницу эпизода
    Допустим есть такой сериал:
    | название              | Доктор Хаус |
    | оригинальное название | House M.D   |
    | 1 сезон               | 12 эпизодов |
    Когда я захожу на страницу 5 эпизода в 1 сезоне сериала "Доктор Хаус"
    То я должен увидеть "Доктор Хаус"
    И я должен увидеть "House M.D"
    И я должен увидеть "1 сезон"
    И я должен увидеть "5 эпизод"
    И я должен увидеть проигрыватель
    И я должен увидеть "Предыдущий эпизод"
    И я должен увидеть "Следующий эпизод"
    Когда я прохожу по ссылке "Предыдущий эпизод"
    То я должен быть на странице 4 эпизода в 1 сезоне сериала "Доктор Хаус"
    Когда я прохожу по ссылке "Следующий эпизод"
    То я должен быть на странице 5 эпизода в 1 сезоне сериала "Доктор Хаус"

  Сценарий: Пользователь находится на странице первого эпизода в сезоне
    Допустим есть такой сериал:
    | название | Доктор Хаус |
    | 1 сезон  | 12 эпизодов |
    Когда я захожу на страницу 1 эпизода в 1 сезоне сериала "Доктор Хаус"
    То я не должен увидеть ссылку "Предыдущий эпизод"
    И я должен увидеть ссылку "Следующий эпизод"

  Сценарий: Пользователь находится на странице последнего эпизода в сезоне
   Допустим есть такой сериал:
   | название | Доктор Хаус |
   | 1 сезон  | 12 эпизодов |
   Когда я захожу на страницу 12 эпизода в 1 сезоне сериала "Доктор Хаус"
   То я должен увидеть ссылку "Предыдущий эпизод"
   И я не должен увидеть ссылку "Следующий эпизод"

