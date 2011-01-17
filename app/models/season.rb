class Season
  include Mongoid::Document

  embedded_in :serial, :inverse_of => :seasons
end
