# language: ru
Функционал: Регистрация по приглашению
  После того как пользователю отправлено приглашение
  Он должен пройти регистрацию
  Чтобы затем он мог пройти аутентификацию по паролю

  Предыстория:
  И мне отправлено приглашение
  Когда я прохожу по ссылке "Регистрация по приглашению" в письме "Приглашение на zomber.tv"

  Сценарий: Василий Пупкин получает приглашение и регистрируется
    То я должен увидеть текстовое поле со своим именем
    И я должен увидеть текстовое поле со своим email
    Когда я ввожу свой пароль в поле "Пароль"
    И я нажимаю "Зарегистрироваться"
    То я должен увидеть "Вы зарегистрированы, спасибо"
    И я должен увидеть список сериалов

  Сценарий: Хитрожопый Василий пытается зарегистрироваться с неправильным паролем
    Когда я ввожу "" в поле "Пароль"
    И я нажимаю "Зарегистрироваться"
    То я должен увидеть "Пароль не должен быть пустым"
    Если я ввожу "123" в поле "Пароль"
    И я нажимаю "Зарегистрироваться"
    То я должен увидеть "Длина пароля должна быть не менее"
    Если я ввожу "ниибаццакакдлинныйпарольблеать" в поле "Пароль"
    И я нажимаю "Зарегистрироваться"
    То я должен увидеть "Длина пароля должна быть не более"

  Сценарий: Хитрожопый Василий пытается зарегистрироваться с пустым именем
    Если я ввожу "" в поле "Ваше имя"
    И я ввожу свой пароль в поле "Пароль"
    И я нажимаю "Зарегистрироваться"
    То я должен увидеть "Имя не должно быть пустым"

  Сценарий: Хитрожопый Василий пытается зарегистрироваться с неправильным email'ом
    Если я ввожу "" в поле "Ваш email"
    И я ввожу свой пароль в поле "Пароль"
    И я нажимаю "Зарегистрироваться"
    То я должен увидеть "Email не должен быть пустым"
    Если я ввожу "хуйню, а не имэйл" в поле "Ваш email"
    И я ввожу свой пароль в поле "Пароль"
    И я нажимаю "Зарегистрироваться"
    То я должен увидеть "Email должен выглядеть как email"

  Сценарий: Хитрожопый Василий пытается зарегистрироваться с уже существующим email'ом
    Допустим есть зарегестрированный пользователь с email "pat@example.com"
    Когда я прохожу по ссылке "Регистрация по приглашению" в письме "Приглашение на zomber.tv"
    Если я ввожу "pat@example.com" в поле "Ваш email"
    И я ввожу свой пароль в поле "Пароль"
    И я нажимаю "Зарегистрироваться"
    То я должен увидеть "Пользователь с таким email уже зарегистрирован"
