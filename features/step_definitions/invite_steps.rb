# -*- coding: utf-8 -*-
When /^я запускаю программу приглашения$/ do
  When %Q{I run "rake user:invite RAILS_ENV=test" interactively}
end

Then /^вывод должен содержать "([^\"]*)"$/ do |text|
  Then %Q{the output should contain "#{text}"}
end

When /^я ввожу "([^\"]*)"$/ do |text|
  When %Q{I type "#{text}"}
end

Then /^на email "([^\"]*)" должно прийти приглашение$/ do |recipient|
  mail = deliveries_for(recipient).select { |d| d.subject == "Приглашение на zomber.tv" }.first

  mail.should_not be_nil
  mail.body.to_s.should match(/Вы приглашены на (.+)zomber.tv(.+)/i)
end

Given /^мне отправлено приглашение$/ do
  Given %Q{отправлено приглашение по адресу "#{user_email}"}
end

When /^я прохожу по ссылке "([^\"]*)" в письме "([^\"]*)"$/ do |link_text, mail_title|
  When %Q{я прохожу по ссылке "#{link_text}" в письме "#{mail_title}" отправленном по адресу "#{user_email}"}
end

When /^я прохожу по ссылке "([^\"]*)" в письме "([^\"]*)" отправленном по адресу "([^\"]*)"$/ do |link_text, mail_title, email|
  mail = deliveries_for(email).select{ |d| d.subject == mail_title  }.first

  mail_body = Nokogiri::HTML(mail.body.to_s)

  href = mail_body.xpath(%Q{//a[text()="#{link_text}"]}).first['href']

  visit(href)
end

Given /^отправлено приглашение по адресу "([^\"]*)"$/ do |email|
  When %Q{я запускаю программу приглашения}
  When %Q{я ввожу "#{email}"}
  Then %Q{вывод должен содержать "Приглашение отправлено по адресу <#{email}>"}
  Then %Q{на email "#{email}" должно прийти приглашение}
end

Given /^я зарегистрирован по приглашению$/ do
  Given %Q{мне отправлено приглашение}
  When %Q{я прохожу по ссылке "Регистрация по приглашению" в письме "Приглашение на zomber.tv"}
  When %Q{я ввожу свой логин в поле "Логин"}
  When %Q{я ввожу свой пароль в поле "Пароль"}
  When %Q{я нажимаю "Зарегистрироваться"}
  When %Q{я прохожу по ссылке "Выход"}
end

Given /^есть зарегестрированный пользователь "([^\"]*)" с email "([^\"]*)"$/ do |login, email|
  Given %Q{отправлено приглашение по адресу "#{email}"}
  When %Q{я прохожу по ссылке "Регистрация по приглашению" в письме "Приглашение на zomber.tv" отправленном по адресу "#{email}"}
  When %Q{я ввожу "#{login}" в поле "Логин"}
  When %Q{я ввожу "foobarbaz" в поле "Пароль"}
  When %Q{я нажимаю "Зарегистрироваться"}
  When %Q{я прохожу по ссылке "Выход"}
end
