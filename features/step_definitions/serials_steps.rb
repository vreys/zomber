# -*- coding: utf-8 -*-
Given /^есть (\d+) разных сериалов$/ do |count_serials|
  count_serials.to_i.times { SerialRepoFactory.create }

  Repository.index!
end

Then /^я должен увидеть список из (\d+) сериалов$/ do |count_serials|
  all('#serials_list li').count.should eql(count_serials.to_i)
end

Given /^есть сериал "([^\"]*)"$/ do |serial_title|
  SerialRepoFactory.create(serial_title)
  
  Repository.index!
end

Then /^я не должен увидеть список сериалов$/ do
  page.should have_no_css('#serials_list')
end
