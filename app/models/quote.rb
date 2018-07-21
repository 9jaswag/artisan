class Quote < ApplicationRecord
  belongs_to :client
  belongs_to :task
end
