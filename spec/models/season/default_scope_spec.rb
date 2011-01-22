require "spec_helper"

describe Season, "#default_scope" do
  subject { Season.criteria.options }
  
  it do
    pending
    # should eql(:sort => [[:index_number, :asc]])
  end
end
