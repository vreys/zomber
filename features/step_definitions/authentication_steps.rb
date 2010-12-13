# -*- coding: utf-8 -*-
Given /^я не залогинен$/ do
  When %Q{я захожу на страницу выхода}
end

Then /^я должен увидеть форму аутентификации$/ do
  Then %Q{я должен увидеть поле "Email"}
  Then %Q{я должен увидеть поле "Пароль"}
  Then %Q{я должен увидеть поле "Запомнить меня"}
  Then %Q{я должен увидеть кнопку "Войти"}
end

When /^я ввожу свой email в поле "([^\"]*)"$/ do |field_label|
  fill_in(field_label, :with => user_email)
end

When /^я ввожу свой пароль в поле "([^\"]*)"$/ do |field_label|
  fill_in(field_label, :with => user_password)
end

Given /^я залогинен$/ do
  Given %Q{я не залогинен}
  Given %Q{я зарегистрирован по приглашению}
  When %Q{я захожу на главную страницу}
  When %Q{я ввожу свой email в поле "Email"}
  When %Q{я ввожу свой пароль в поле "Пароль"}
  When %Q{я нажимаю "Войти"}
end
