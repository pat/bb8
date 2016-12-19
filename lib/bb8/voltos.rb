class BB8::Voltos
  def self.bundles
    api = Voltos::API.new
    api.get("bundles").collect { |hash|
      BB8::Voltos::Bundle.new hash['name'], api
    }
  end

  def self.current_bundle
    BB8::Voltos::Bundle.new File.read('.bb8_bundle')
  end
end

require 'bb8/voltos/api'
require 'bb8/voltos/bundle'
