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
  mail = nil

  emails_file = File.join(ActionMailer::Base.file_settings[:location], recipient)

  mail = Mail.new(File.read(emails_file)) if File.exists?(emails_file)
  
  mail.should_not be_nil
  mail.subject.should match(/Приглашение на zomber.tv/i)
  mail.body.to_s.should match(/Вы приглашены на (.+)zomber.tv(.+)/i)
end
