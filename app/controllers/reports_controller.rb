# frozen_string_literal: true

class ReportsController < ApplicationController
  # TODO: implement report generation endpoint - it should delegate to ReportGenerator
  def get
    report = ReportGenerator.generate(report_params)
    render json: report , status: :ok
  end

  def report_params
    {
      employee_id: params[:employee_id],
      from: params[:from],
      to: params[:to]
    }
  end
end
