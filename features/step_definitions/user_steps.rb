# -*- coding: utf-8 -*-
def set_user_name(value)
  @user_name = value
end

def user_name
  @user_name
end

def reset_user_name
  set_user_name('Василий Пупкин')
end

def user_password
  '12345userpass'
end

def set_user_email(value)
  @user_email = value
end

def user_email
  @user_email
end

def reset_user_email
  set_user_email('vasily.pupkin@example.com')
end

def reset_user
  reset_user_name
  reset_user_email
end

Given /^меня зовут "([^\"]*)"$/ do |name|
  set_user_name(name)
end

Given /^у меня такой email: "([^\"]*)"$/ do |email|
  set_user_email(email)
end

Then /^я должен увидеть текстовое поле со своим именем$/ do
  page.should have_xpath(%Q{//input[@value="#{user_name}"]})
end

Then /^я должен увидеть текстовое поле со своим email$/ do
  page.should have_xpath(%Q{//input[@value="#{user_email}"]})
end

Then /^я должен увидеть сво(?:е|ё) имя$/ do
  Then %Q{я должен увидеть "#{user_name}"}
end

Then /^я должен увидеть свой email$/ do
  Then %Q{я должен увидеть "#{user_email}"}
end

Then /^я должен увидеть свой email в поле "([^\"]*)"$/ do |field_label|
  find_field(field_label)['value'].should eql(user_email)
end