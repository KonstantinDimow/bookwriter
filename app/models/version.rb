class Version < ActiveRecord::Base
  attr_accessible :id, :item_id, :item_type, :whodunnit, :object, :created_at

end