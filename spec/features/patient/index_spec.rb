require 'rails_helper'

RSpec.describe "the Patient index page" do
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

    visit patients_path
  end

  it 'I see the names of all adult patients (age is greater than 18)' do
    within("#patients_over_18") do
      expect(page).to have_content(@katie.name)
      expect(page).to have_content(@denny.name)
      expect(page).to have_content(@rebecca.name)
      expect(page).to_not have_content(@zola.name)
    end
  end

  it 'And I see the names are in ascending alphabetical order (A - Z)' do
    within("#patients_over_18") do
      expect(@denny.name).to appear_before(@katie.name)
      expect(@katie.name).to appear_before(@rebecca.name)
    end
  end
end