class BandLink < ActiveRecord::Base
  belongs_to :band
  # for the possibly multiple links each band has
end