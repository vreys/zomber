class Season
  include Mongoid::Document

  field :index, :type => Integer

  embedded_in :serial, :inverse_of => :seasons
end
