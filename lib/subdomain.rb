class Subdomain
  def self.matches?(request)
    request.subdomain.present? && request.host.include?('.organizations')
  end
end