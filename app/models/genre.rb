class Genre < ApplicationRecord
  has_and_belongs_to_many :books

  # probaby should have a
  # validation on name
end
