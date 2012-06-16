class Notification < ActiveRecord::Base
  attr_accessible :subject_id, :target_id, :type, :verb
  
  after_initialize :init

  validates :subject_id, presence: true
  validates :verb, presence: true
  validates :type, presence: true
end
