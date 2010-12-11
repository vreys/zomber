# -*- coding: utf-8 -*-
require 'highline'

namespace :user do
  task :invite => [:environment] do
    h = HighLine.new

    email = h.ask("Электопочта получателя: ")
    name = h.ask("Имя получателя: ")

    user = User.invite!(:email => email, :name => name)

    if user.errors.empty?
      puts "Приглашение отправлено по адресу <#{email}> (получатель: #{name})"
    else
      user.errors.full_messages.each do |m|
        puts m
      end
    end
  end
end
