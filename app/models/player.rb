class Player < ActiveRecord::Base
  belongs_to :game, touch: true
end
