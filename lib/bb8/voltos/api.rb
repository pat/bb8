class BB8::Voltos::API
  DOMAIN   = 'https://api.voltos.io'
  VERSION  = 'v1'
  ENDPOINT = "#{DOMAIN}/#{VERSION}"

  def get(path)
    JSON.parse connection.get("#{VERSION}/#{path}").body
  end

  def put(path, params)
    JSON.parse connection.put("#{VERSION}/#{path}", params).body
  end

  def post(path, params)
    JSON.parse connection.post("#{VERSION}/#{path}", params).body
  end

  def create_bundle(name)
    JSON.parse connection.post("#{VERSION}/bundles", {
      :name       => name,
      :token_name => 'BB8'
    }).body
  end

  private

  def configuration
    @configuration ||= JSON.parse(
      File.read(File.expand_path('~/.voltos/config.json'))
    )
  end

  def connection
    @connection ||= Faraday.new(:url => DOMAIN) do |faraday|
      faraday.adapter Faraday.default_adapter
      faraday.request :url_encoded

      faraday.headers['User-Agent']    = "BB8/#{BB8::VERSION}"
      faraday.headers['Authorization'] = "Token token=#{token}"
    end
  end

  def token
    configuration['auths']["#{ENDPOINT}"]['auth']
  end
end
