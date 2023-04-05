class SubdomainConstraint
  def self.matches?(request)
    subdomains = %w[www admin]
    request.subdomain.present? && subdomains.exclude?(request.subdomain)
  end
end
