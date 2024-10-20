# frozen_string_literal: true

class ApplicationController < ActionController::API
  rescue_from ActionController::ParameterMissing, ActiveModel::ValidationError, ArgumentError do
    render nothing: true, status: :bad_request
  end
end
