# frozen_string_literal: true

class Event < ApplicationRecord
  validates :employee_id, :kind, :timestamp, presence: true
  enum kind: { in: 0, out: 1 }
end
