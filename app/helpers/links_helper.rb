module LinksHelper
  def safe_link_url(url)
    # Ensure the URL is properly escaped for HTML attributes
    # The model already validates that it's a valid HTTP/HTTPS URL
    CGI.escapeHTML(url.to_s)
  end
end
