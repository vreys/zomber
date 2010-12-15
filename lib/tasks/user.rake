# -*- coding: utf-8 -*-
require 'highline'
require "highline/import"

require 'hirb'

extend Hirb::Console

ft = HighLine::ColorScheme.new do |cs|
  cs[:headline]        = [ :bold, :blue ]
  cs[:horizontal_line] = [ :bold, :white ]
  cs[:error]           = [ :red ]
  cs[:success]         = [ :green ]
end

HighLine.color_scheme = ft

namespace :user do
  task :invite => [:environment] do
    email = ask("Электопочта получателя: ")
    name = ask("Имя получателя: ")

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
    email = ask("Кого удалить (email)? ")

    user = User.find_by_email(email)

    if user
      name = user.name
      user.destroy

      puts "#{name} теперь ходит мимо!"
    else
      puts "Таких не знаем -_-"
    end
  end

  task :list => [:environment] do
    table(User.all, :fields => [:name, :email, :invitation_sent_at, :created_at, :invitation_token, :invited?])
  end

  task :add => [:environment] do
    render_header("Новый пользователь")
    
    user = User.new
    
    user.email    = ask(" Электоропочта: ")
    user.name     = ask("           Имя: ")
    user.password = ask("        Пароль: ") {|p| p.echo = false}

    user.save

    puts ""

    if user.errors.empty?
      say(" <%= color('Пользователь сохранен', :success) %>")
    else
      user.errors.full_messages.each do |m|
        say(" <%= color('#{m}', :error) %>")
      end
    end
  end

  def render_header(text)
    say(" <%= color('Новый пользователь', :headline) %>")
    puts ""
  end

end
