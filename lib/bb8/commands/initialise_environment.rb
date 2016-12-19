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
    File.write '.bb8_bundle', voltos_bundle

    BB8::Voltos::Bundle.create voltos_bundle unless bundle_exists?
    append_token unless set_bundle?
    BB8::SetEncryptionKeys.call
  end

  private

  attr_reader :name, :voltos_bundle

  def append_token
    File.open('.env', 'a') do |file|
      file.puts "VOLTOS_KEY=#{bundle.token}"
    end
  end

  def bundle
    @bundle ||= BB8::Voltos.bundles.detect { |bundle|
      bundle.name == voltos_bundle
    } || BB8::Voltos::Bundle.create(voltos_bundle)
  end

  def bundle_exists?
    BB8::Voltos.bundles.collect(&:name).include? voltos_bundle
  end

  def set_bundle?
    File.exist?('.env') && File.read('.env')[/^VOLTOS_KEY=(\w+)/]
  end
end
