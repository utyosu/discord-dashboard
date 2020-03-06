BASE_URI = 'http://0.0.0.0:3000/'

SCHEDULER.cron '0 6 * * *' do
  kings = JSON.parse(HTTP.get("#{BASE_URI}/analysises/kings").body, symbolize_names: true)
  send_event('kings', kings)
end

SCHEDULER.cron '0 6 * * *' do
  hourlyactive = JSON.parse(HTTP.get("#{BASE_URI}/analysises/hourlyactive").body, symbolize_names: true)
  send_event('hourlyactive', hourlyactive)
end

SCHEDULER.cron '0 6 * * *' do
  monthlyactive = JSON.parse(HTTP.get("#{BASE_URI}/analysises/monthlyactive").body, symbolize_names: true)
  send_event('monthlyactive', monthlyactive)
end

SCHEDULER.every '30s' do
  records = JSON.parse(HTTP.get("#{BASE_URI}/analysises/records").body, symbolize_names: true)
  send_event('records',records)
end
