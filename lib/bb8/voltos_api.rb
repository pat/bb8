class BB8::VoltosAPI
  DOMAIN   = 'https://api.voltos.io'
  VERSION  = 'v1'
  ENDPOINT = "#{DOMAIN}/#{VERSION}"

  def bundles
    JSON.parse Curl.get("#{ENDPOINT}/bundles") { |http|
      http.headers['User-Agent']    = "BB8/#{BB8::VERSION}"
      http.headers['Authorization'] = "Token token=#{token}"
    }.body_str
  end

  def create_bundle(name)
    JSON.parse Curl.post("#{ENDPOINT}/bundles", {
      :name       => name,
      :token_name => 'BB8'
    }) { |http|
      http.headers['User-Agent']    = "BB8/#{BB8::VERSION}"
      http.headers['Authorization'] = "Token token=#{token}"
    }.body_str
  end

  private

  def configuration
    @configuration ||= JSON.parse(
      File.read(File.expand_path('~/.voltos/config.json'))
    )
  end

  def token
    configuration['auths']["#{ENDPOINT}"]['auth']
  end
end
