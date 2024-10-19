# frozen_string_literal: true

class ReportGenerator
  def self.generate(params)
    report = Report.new(params)
    events = fetch_events(params[:employee_id], params[:from], params[:to])

    generate_report(events).merge({from: params[:from], to: params[:to]})
  end

  private

  def self.fetch_events(employee_id, from, to)
    from = DateTime.parse(from)
    to = DateTime.parse(to).end_of_day
    Event.where(employee_id: employee_id).where("timestamp >= ? AND timestamp <= ?", from, to).order(:timestamp)
  end

  def self.generate_report(events)
    worktime_hrs = 0
    problematic_dates = []
    last_in = nil
    events.each do |event|
      datetime = event.timestamp
      if event.kind == 'in'
        if last_in.nil?
          last_in = datetime # or event.timestamp, depending on the data
        else
          problematic_dates << last_in.to_date
          last_in = datetime 
        end
      elsif event.kind == 'out'
        if last_in.nil?
          problematic_dates << datetime.to_date
        else
          if last_in.to_date == datetime.to_date
            worktime_hrs += (datetime - last_in) / 3600.0
            last_in = nil
          else
            problematic_dates << last_in.to_date
            problematic_dates << datetime.to_date
          end
        end
      end
    end
    problematic_dates << events.last.to_date if last_in && events.last.kind == "in"

    build_report(events, worktime_hrs, problematic_dates)
  end

  def self.build_report(events, worktime_hrs, problematic_dates)
    {
      employee_id: events.first.employee_id,
      worktime_hrs: worktime_hrs.round(2),
      problematic_dates: problematic_dates
    }
  end
end
