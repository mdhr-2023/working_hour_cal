# frozen_string_literal: true

class Report
  include ActiveModel::Validations
  # TODO: represents the actual report, validate data and implement report methods
  attr_accessor :from, :to, :employee_id
  validates :from, :to, :employee_id, presence: true

  validates_each :from, :to do |record, attr, value|
    record.errors.add attr, "invalid date" unless date_valid?(value)
  end
  # validate :valid_date_format
  validate :valid_start_date_and_end_date
  validates :employee_id, numericality: { only_integer: true }

  def initialize(attributes = {})
    attributes.each do |name, value|
      public_send("#{name}=", value)
    end
    raise ActiveModel::ValidationError, self unless valid?
  end

  def self.date_valid?(date)
    Date.parse(date)
    true
  rescue ArgumentError
    false
  end

  def valid_start_date_and_end_date
    if from.present? && to.present?
      errors.add(:base, "'From' date should be earlier than 'To' date") if from > to
    end
  end
end
