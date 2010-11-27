# -*- coding: utf-8 -*-
Given /^есть (\d+) разных сериалов$/ do |count_serials|
  count_serials.to_i.times { SerialRepoFactory.create }

  Repository.index!
end

Then /^я должен увидеть список из (\d+) сериалов$/ do |count_serials|
  all('#serials_list li').count.should eql(count_serials.to_i)
end

Given /^есть сериал "([^\"]*)"$/ do |serial_title|
  SerialRepoFactory.create(:title => serial_title)
  
  Repository.index!
end

Then /^я не должен увидеть список сериалов$/ do
  page.should have_no_css('#serials_list')
end

Given /^есть следующие сериалы:$/ do |serials|
  KEY_ALIASES = {'название' => :title, 'описание' => :description}

  serials.hashes.each do |options|
    attrs = {}

    options.each do |key, value|
      attrs[KEY_ALIASES[key]] = value
    end

    SerialRepoFactory.create(attrs)
  end

  Repository.index!
end

When /^я захожу на страницу сериала "([^\"]*)"$/ do |serial_title|
  When %Q{я захожу в раздел сериалов}
  When %Q{я иду по ссылке "#{serial_title}"}
end

Then /^я должен увидеть постер$/ do
  page.should have_css('#poster.serial[src]')
end
