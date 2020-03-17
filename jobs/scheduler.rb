BASE_URI = 'http://0.0.0.0:3000/'

proc_kings = Proc.new do
  kings = JSON.parse(HTTP.get("#{BASE_URI}/analysises/kings").body, symbolize_names: true)
  send_event('kings', kings)
end

proc_monthlyactive = Proc.new do
  monthlyactive = JSON.parse(HTTP.get("#{BASE_URI}/analysises/monthlyactive").body, symbolize_names: true)
  send_event('monthlyactive', monthlyactive)
end

proc_houlyactive = Proc.new do
  hourlyactive = JSON.parse(HTTP.get("#{BASE_URI}/analysises/hourlyactive").body, symbolize_names: true)
  send_event('hourlyactive', hourlyactive)
end

proc_records = Proc.new do
  records = JSON.parse(HTTP.get("#{BASE_URI}/analysises/records").body, symbolize_names: true)
  send_event('records',records)
end

SCHEDULER.cron '0 6 * * *', proc_kings
SCHEDULER.cron '0 6 * * *', proc_monthlyactive
SCHEDULER.cron '0 6 * * *', proc_houlyactive
SCHEDULER.every '30s', proc_records

SCHEDULER.in '0s', proc_kings
SCHEDULER.in '0s', proc_monthlyactive
SCHEDULER.in '0s', proc_houlyactive
SCHEDULER.in '0s', proc_records
