class DoctorsController < ApplicationController
  def show
    @doctor = Doctor.find(params[:id])
  end
  
  def update
    @doctor = Doctor.find(params[:id])
    @remove_relaysh = @doctor.doctor_patients.find_by(patient_id: params[:patient_id])
    @remove_relaysh.delete
    redirect_to doctor_path(@doctor)
  end
end