# -*- coding: utf-8 -*-
Given /^есть (\d+) разных сериалов$/ do |count_serials|
  count_serials.to_i.times { make_serial }

  Repository.index!
end

When /^я захожу в раздел сериалов$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^я должен увидеть (\d+) названий сериалов с иконками$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end
