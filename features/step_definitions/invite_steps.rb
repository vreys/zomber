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

Given /^меня зовут "([^\"]*)"$/ do |name|
  @my_name = name
end

Given /^у меня такой email: "([^\"]*)"$/ do |email|
  @my_email = email
end

Given /^мне отправлено приглашение$/ do
  When %Q{я запускаю программу приглашения}
  When %Q{я ввожу "#{@my_email}"}
  When %Q{я ввожу "#{@my_name}"}
  Then %Q{вывод должен содержать "Приглашение отправлено по адресу <#{@my_email}> (получатель: #{@my_name})"}
  Then %Q{на email "#{@my_email}" должно прийти приглашение}
end

When /^я прохожу по ссылке "([^\"]*)" в письме "([^\"]*)"$/ do |link_text, mail_title|
  mail = delivery_for(@my_email)

  mail_body = Nokogiri::HTML(mail.body.to_s)

  href = mail_body.xpath(%Q{//a[text()="#{link_text}"]}).first['href']

  visit(href)
end

Then /^я должен увидеть текстовое поле со своим именем$/ do
  page.should have_xpath(%Q{//input[@value="#{@my_name}"]})
end

Then /^я должен увидеть текстовое поле со своим email$/ do
  page.should have_xpath(%Q{//input[@value="#{@my_email}"]})
end

Then /^я должен увидеть свое имя$/ do
  Then %Q{я должен увидеть "#{@my_name}"}
end

Then /^я должен увидеть свой email$/ do
  Then %Q{я должен увидеть "#{@my_email}"}
end
