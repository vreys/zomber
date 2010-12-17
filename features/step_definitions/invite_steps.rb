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
  When %Q{я запускаю программу приглашения}
  When %Q{я ввожу "#{user_email}"}
  When %Q{я ввожу "#{user_name}"}
  Then %Q{вывод должен содержать "Приглашение отправлено по адресу <#{user_email}> (получатель: #{user_name})"}
  Then %Q{на email "#{user_email}" должно прийти приглашение}
end

When /^я прохожу по ссылке "([^\"]*)" в письме "([^\"]*)"$/ do |link_text, mail_title|
  mail = deliveries_for(user_email).select{ |d| d.subject == mail_title  }.first

  mail_body = Nokogiri::HTML(mail.body.to_s)

  href = mail_body.xpath(%Q{//a[text()="#{link_text}"]}).first['href']

  visit(href)
end

Given /^я зарегистрирован по приглашению$/ do
  Given %Q{мне отправлено приглашение}
  When %Q{я прохожу по ссылке "Регистрация по приглашению" в письме "Приглашение на zomber.tv"}
  When %Q{я ввожу свой пароль в поле "Пароль"}
  When %Q{я нажимаю "Зарегистрироваться"}
  When %Q{я прохожу по ссылке "Выход"}
end
