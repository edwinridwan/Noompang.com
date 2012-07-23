# == Schema Information
#
# Table name: ride_requests
#
#  id                   :integer         not null, primary key
#  ride_id              :integer         not null
#  user_id              :integer         not null
#  start_time           :datetime
#  end_time             :datetime
#  start_address        :string(255)
#  end_address          :string(255)
#  start_lat            :float
#  start_long           :float
#  end_lat              :float
#  end_long             :float
#  request_code         :string(255)
#  created_at           :datetime        not null
#  updated_at           :datetime        not null
#  status               :string(255)     default("pending"), not null
#  start_date           :date
#  end_date             :date
#  driver_score         :float
#  driver_score_date    :datetime
#  passenger_score      :float
#  passenger_score_date :datetime
#  start_country        :string(255)
#  end_country          :string(255)
#  start_post_code      :string(255)
#  end_post_code        :string(255)
#
# Indexes
#
#  index_ride_requests_on_request_code  (request_code)
#

class RideRequest < ActiveRecord::Base
  #attr_accessible :title, :body
  belongs_to :ride
  belongs_to :user

  # SORTING
  default_scope :order => 'created_at DESC'
end
