# -*- coding: utf-8 -*-
Given /^никаких писем не отправлено$/ do
  mails_dir = ActionMailer::Base.file_settings[:location]
  
  FileUtils.rm_r(mails_dir) if File.exists?(mails_dir)
end

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
  mail = delivery_for(recipient)

  mail.should_not be_nil
  mail.subject.should match(/Приглашение на zomber.tv/i)
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
  mail = delivery_for(user_email)

  mail_body = Nokogiri::HTML(mail.body.to_s)

  href = mail_body.xpath(%Q{//a[text()="#{link_text}"]}).first['href']

  visit(href)
end

Given /^я зарегистрирован по приглашению$/ do
  Given %Q{никаких писем не отправлено}
  Given %Q{мне отправлено приглашение}
  When %Q{я прохожу по ссылке "Регистрация по приглашению" в письме "Приглашение на zomber.tv"}
  When %Q{я ввожу свой пароль в поле "Пароль"}
  When %Q{я нажимаю "Зарегистрироваться"}
  When %Q{я прохожу по ссылке "Выход"}
end
