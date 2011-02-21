# language: ru
Функционал: Страница сериала
  Чтобы любителям сериалов нравилось использовать наш ресурс
  Я как пользователь хочу видеть хорошо оформленную страницу сериала

  Предыстория:
  Допустим я залогинен

  Сценарий: Пользователь видит страницу сериала
    Допустим есть такой сериал:
    | название              | Доктор Хаус               |
    | описание              | Сериал про клевого чувака |
    | оригинальное название | House M.D                 |
    | 1 сезон               | 18 эпизодов               |
    | 2 сезон               | 23 эпизода                |
    | 3 сезон               | 1 эпизод                  |
    Когда я захожу на страницу сериала "Доктор Хаус"
    То я должен увидеть "Доктор Хаус"
    И я должен увидеть "House M.D"
    И я должен увидеть "Сериал про клевого чувака"
    И я должен увидеть постер
    И я должен увидеть такой список сезонов:
    | 1 сезон | 18 эпизодов |
    | 2 сезон | 23 эпизода  |
    | 3 сезон | 1 эпизод    |

  Сценарий: Пользователь выбирает эпизод для просмотра
   Допустим есть такой сериал:
   | название | Доктор Хаус               |
   | описание | Сериал про клевого чувака |
   | 1 сезон  | 18 эпизодов               |
   | 2 сезон  | 17 эпизодов               |
   Когда я захожу на страницу сериала "Доктор Хаус"
   И я перехожу по ссылке "5 эпизод" во 2 сезоне
   То я должен оказаться на странице 5 эпизода во 2 сезоне сериала "Доктор Хаус"