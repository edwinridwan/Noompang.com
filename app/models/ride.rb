# == Schema Information
#
# Table name: rides
#
#  id                 :integer         not null, primary key
#  user_id            :integer         not null
#  start_address      :string(255)     not null
#  end_address        :string(255)     not null
#  start_lat          :float
#  start_long         :float
#  end_lat            :float
#  end_long           :float
#  start_time         :datetime        not null
#  end_time           :datetime        not null
#  distance_in_meters :integer
#  created_at         :datetime        not null
#  updated_at         :datetime        not null
#  no_seats           :integer
#  start_date         :date
#  end_date           :date
#  price              :decimal(4, 2)
#  start_country      :string(255)
#  end_country        :string(255)
#  start_post_code    :string(255)
#  end_post_code      :string(255)
#
# Indexes
#
#  index_rides_on_user_id  (user_id)
#

class Ride < ActiveRecord::Base
  attr_accessible :user_id, :start_address, :end_address, :start_date, 
                  :start_time, :end_date, :end_time, :distance_in_meters, 
                  :start_lat, :start_long, :end_lat, :end_long, :no_seats, :price,
                  :start_country, :end_country, :start_post_code, :end_post_code
  belongs_to :driver, :class_name => "User"
  has_many   :ride_requests, :dependent => :destroy

  # SORTING
  default_scope :order => 'start_time ASC'

  # VALIDATIONS
  validates :no_seats, :numericality => { :greater_than_or_equal_to => 1 }
  validates :price, :numericality => { :greater_than_or_equal_to => 0.00 }
  validate  :check_dates


  private

    def check_dates
      if start_time < Time.now
        errors.add(:start_time)
        errors.add(:start_date)
      end
      #if end_time < Time.now || end_time < start_time
      #  errors.add(:end_time)
      #end
    end

end
