class PatientsController < ApplicationController
  def index
    @patients = Patient.alphabetical.over_18
  end
end