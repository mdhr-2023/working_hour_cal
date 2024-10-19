# frozen_string_literal: true

class EventsController < ApplicationController
  # TODO: implement the event saving endpoint
  def save
    event = Event.new(event_params)
    
    if event.save
      render json: { event: event }, status: :created
    else
      render json: { errors: event.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def event_params
    {
      employee_id: params[:employee_id],
      kind: params[:kind],
      timestamp: Time.at(params[:timestamp].to_i).to_datetime
    }
  end
end
