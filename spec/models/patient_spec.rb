require 'rails_helper'

RSpec.describe Patient do
  before(:each) do
    @grey = Hospital.create!(name: 'Grey Sloan Memorial Hospital')
    @seaside = Hospital.create!(name: 'Seaside Health & Wellness Center')

    @meredith = Doctor.create!(name: 'Meredith Gray', specialty: 'General Surgery', university: 'Harvard University', hospital_id: @grey.id)
    @alex = Doctor.create!(name: 'Alex Karev', specialty: 'Pediatric Surgery', university: 'Johns Hopkins University', hospital_id: @grey.id)
    @miranda = Doctor.create!(name: 'Miranda Bailey', specialty: 'General Surgery', university: 'Stanford University', hospital_id: @seaside.id)
    @derek = Doctor.create!(name: 'Derek McDreamy', specialty: 'Attending Surgeon', university: 'University of Pennsylvania', hospital_id: @seaside.id)

    @katie = Patient.create!(name: 'Katie Bryce', age: 24)
    @denny = Patient.create!(name: 'Denny Duquette', age: 39)
    @rebecca = Patient.create!(name: 'Rebecca Pope', age: 32)
    @zola = Patient.create!(name: 'Zola Shepherd', age: 2)

    DoctorPatient.create!(doctor_id: @meredith.id, patient_id: @katie.id)
    DoctorPatient.create!(doctor_id: @meredith.id, patient_id: @denny.id)
    DoctorPatient.create!(doctor_id: @alex.id, patient_id: @denny.id)
    DoctorPatient.create!(doctor_id: @alex.id, patient_id: @rebecca.id)
    DoctorPatient.create!(doctor_id: @derek.id, patient_id: @zola.id)
  end

  it {should have_many :doctor_patients}
  it {should have_many(:doctors).through(:doctor_patients)}

  describe '#alphabetical' do
    it 'returns names in ascending alphabetical order (A - Z)' do
      expect(Patient.alphabetical).to eq([@denny, @katie, @rebecca, @zola])
    end
  end

  describe '#over_18' do
    it 'returns patients that are over the age of 18' do
      expect(Patient.over_18.sort).to eq([@denny, @katie, @rebecca].sort)
    end
  end
end
