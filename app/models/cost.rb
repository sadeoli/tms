class Cost < ApplicationRecord
    enum category: {weight: 2, distance:6}
    belongs_to :transportation_modal 
end
