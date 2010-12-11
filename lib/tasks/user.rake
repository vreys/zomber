# -*- coding: utf-8 -*-
require 'highline'

namespace :user do
  task :invite => [:environment] do
    h = HighLine.new

    email = h.ask("Электопочта получателя: ")
    name = h.ask("Имя получателя: ")

    user = User.invite!(:email => email, :name => name)

    if user.errors.empty?
      puts "Приглашение отправлено по адресу <#{user.email}> (получатель: #{user.name})"

      if Rails.env.development?
        puts "Invitation token: #{user.invitation_token}"
      end
    else
      user.errors.full_messages.each do |m|
        puts m
      end
    end
  end

  task :destroy => [:environment] do
    h = HighLine.new

    email = h.ask("Кого удалить (email)? ")

    user = User.find_by_email(email)

    if user
      name = user.name
      user.destroy

      puts "#{name} теперь ходит мимо!"
    else
      puts "Таких не знаем -_-"
    end
  end
end
