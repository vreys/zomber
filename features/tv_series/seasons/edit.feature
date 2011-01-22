# language: ru
Функционал: Редактирование эпизода
  Для того чтобы исправлять неточности и ошибки допущенные при добавлении сезона
  Нужен функционал редактирования сезонов
  Чтобы пользователи получали максимально качественный контент

  Предыстория:
  Допустим есть такой сериал:
  | Название на русском | Доктор Хаус |
  | 1 сезон             | 3 эпизода   |
  | 2 сезон             | 5 эпизодов  |
  И я на странице сериала "Доктор Хаус"

  Сценарий: Понижение номера эпизода
    Когда я нажимаю кнопку понижения номера 2-го сезона
    То я должен увидеть "2-й и 1-й сезоны поменяны местами"
    И я должен увидеть 5 эпизодов в 1-м сезоне
    И я должен увидеть 3 эпизода во 2-м сезоне
