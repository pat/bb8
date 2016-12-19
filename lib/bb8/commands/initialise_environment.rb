class BB8::Commands::InitialiseEnvironment
  def self.call(name, voltos_bundle, *arguments)
    new(name, voltos_bundle).call
  end

  def initialize(name, voltos_bundle)
    @name, @voltos_bundle = name, voltos_bundle
  end

  def call
    FileUtils.mkdir_p name
    Dir.chdir name

    api.create_bundle voltos_bundle unless bundles.include? voltos_bundle
    `voltos use #{voltos_bundle}`   unless set_bundle?
    BB8::SetEncryptionKeys.call

    File.write '.bb8_bundle', voltos_bundle
  end

  private

  attr_reader :name, :voltos_bundle

  def api
    @api ||= BB8::VoltosAPI.new
  end

  def bundles
    api.bundles.collect { |bundle| bundle['name'] }
  end

  def set_bundle?
    File.exist?('.env') && File.read('.env')[/^VOLTOS_KEY=(\w+)/]
  end
end
