def delivery_for(recipient)
  emails_file = File.join(ActionMailer::Base.file_settings[:location], recipient)

  Mail.new(File.read(emails_file)) if File.exists?(emails_file)
end
