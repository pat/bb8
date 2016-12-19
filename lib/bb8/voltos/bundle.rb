class BB8::Voltos::Bundle
  attr_reader :name

  def self.create(name, api = nil)
    api    ||= BB8::Voltos::API.new
    response = api.post("bundles", {
      :name       => name,
      :token_name => 'BB8'
    })

    new name, api, response['token']
  end

  def initialize(name, api = nil, token = nil)
    @name  = name
    @api   = api || BB8::Voltos::API.new
    @token = token
  end

  def set(key, value)
    api.put "/bundles/#{name}", "#{key}=#{value}"
  end

  def token
    @token || new_token
  end

  def variables
    @variables ||= api.get "/bundles/#{name}"
  end

  private

  attr_reader :api

  def new_token
    api.post("/bundles/#{name}/token", :name => name)['token']
  end
end
