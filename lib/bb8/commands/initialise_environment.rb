class BB8::Commands::InitialiseEnvironment
  VOLTOS_CONFIGURATION = File.expand_path("~/.voltos/config.json")

  def self.call(name, voltos_bundle, *arguments)
    new(name, voltos_bundle).call
  end

  def initialize(name, voltos_bundle)
    @name, @voltos_bundle = name, voltos_bundle
  end

  def call
    FileUtils.mkdir_p name
    Dir.chdir name

    `voltos create #{voltos_bundle}`
    `voltos use #{voltos_bundle}`
    BB8::SetEncryptionKeys.call

    File.write '.bb8_bundle', voltos_bundle
  end

  private

  attr_reader :name, :voltos_bundle
end
