class BB8::VoltosVariables
  def self.call
    new.call
  end

  def call
    Voltos.configuration.api_key = voltos_api_key
    Voltos.load
  end

  private

  def voltos_api_key
    @voltos_api_key ||= File.read('.env')[/VOLTOS_KEY=(\w+)/, 1]
  end
end
