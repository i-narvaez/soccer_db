class MatchDatum < ApplicationRecord
  enum result: [:w, :d, :l]
end
