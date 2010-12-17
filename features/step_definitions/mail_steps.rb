# -*- coding: utf-8 -*-
def deliveries_for(recipient)
  emails_file_path = File.join(ActionMailer::Base.file_settings[:location], recipient)

  raw_mails = []
  raw_mails = File.read(emails_file_path).split("\nDate:") if File.exists?(emails_file_path)

  deliveries = []
  
  raw_mails.each do |m|
    m = "Date:" + m

    deliveries << Mail.new(m)
  end
  
  deliveries
end

Then /^на мой email должно прийти письмо "([^\"]*)"$/ do |mail_title|
  deliveries_for(user_email).map { |d| d.subject }.should include(mail_title)  
end
