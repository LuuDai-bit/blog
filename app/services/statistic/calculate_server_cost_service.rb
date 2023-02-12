require 'net/http'

class Statistic::CalculateServerCostService < BaseService
  DIGITAL_OCEAN_API = 'https://api.digitalocean.com/v2/customers/my/balance'

  def run
    digital_ocean_cost + aws_cost
  end

  private

  def digital_ocean_cost
    uri = URI(DIGITAL_OCEAN_API)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new(uri.path, headers(Rails.application.credentials.dig(:digitalocean, :access_key_id)))
    response = http.request(request)
    JSON.parse(response.body)['month_to_date_balance'].to_f
  end

  def aws_cost
    0.0
  end

  def headers(authorization)
    {
      'Content-Type' => 'application/json',
      'Authorization' => "Bearer #{authorization}"
    }
  end
end
