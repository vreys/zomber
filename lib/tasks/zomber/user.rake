# -*- coding: utf-8 -*-
require 'highline'
require "highline/import"

require 'hirb'

ft = HighLine::ColorScheme.new do |cs|
  cs[:headline]        = [ :bold, :blue ]
  cs[:horizontal_line] = [ :bold, :white ]
  cs[:notice]          = [ :yellow ]
  cs[:error]           = [ :red ]
  cs[:success]         = [ :green ]
end

HighLine.color_scheme = ft

namespace :user do
  USER_INVITE_ARG_NAMES = [:name, :email]
  
  task :invite, [:name, :email] => :environment do |t, args|
    render_header("Приглашение пользователя")
    
    email = args[:name]  ||  ask(" Электопочта получателя: ")

    begin
      user = User.invite!(:email => email)

      puts "" unless args[:name] && args[:email]

      if user.errors.empty?
        say(" <%= color('Приглашение отправлено по адресу <#{user.email}>', :success) %>")

        if Rails.env.development?

          user.login = ''
          until user.valid?
            login = ask("Логин пользователя:")
            user.login = login
            user.valid?

            say(" <%= color('#{user.errors.full_messages}', :notice) %>")
          end

          user.password = ''
          until user.valid?
            password = ask("Пароль пользователя:")
            user.password = password
            user.valid?

            say(" <%= color('#{user.errors.full_messages}', :notice) %>")
          end

          User.accept_invitation!(:invitation_token => user.invitation_token, :password => password, :login => login)
          say(" <%= color('И автоматически принято(можно сразу логиниться)', :success) %>")
        end
      else
        user.errors.full_messages.each do |m|
          say(" <%= color('#{m}', :error) %>")
        end
      end
    rescue
      say(" <%= color('#{$!}', :error) %>")
    end
  end

  task :destroy => [:environment] do
    email = ask("Кого удалить (email)? ")

    user = User.find_by_email(email)

    if user
      email = user.email
      user.destroy

      puts "#{email} теперь ходит мимо!"
    else
      puts "Таких не знаем -_-"
    end
  end

  task :list => [:environment] do
    extend Hirb::Console
    
    table(User.all, :fields => [:login, :email, :invitation_sent_at, :created_at, :invitation_token, :invited?])
  end

  task :add => [:environment] do
    render_header("Новый пользователь")
    
    user = User.new
    
    user.email    = ask(" Электоропочта: ")
    user.login    = ask("         Логин: ")
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
