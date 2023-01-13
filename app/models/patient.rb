class Patient < ApplicationRecord
  has_many :doctor_patients
  has_many :doctors, through: :doctor_patients

  def self.alphabetical
    self.order(:name)
  end

  def self.over_18
    self.where('age >= 18')
  end
end
