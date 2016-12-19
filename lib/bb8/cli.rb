class BB8::CLI
  def self.call(*arguments)
    environments = Dir['*'].select { |file| File.directory? file }

    case arguments.first
    when 'init'
      BB8::Commands::InitialiseProject.call arguments[1]
    when 'version'
      BB8::Commands::Version.call
    when 'environment'
      BB8::Commands::InitialiseEnvironment.call arguments[1], arguments[2]
    when *environments
      BB8::Commands::Terraform.call(*arguments)
    else
      BB8::Commands::Help.call
    end
  end
end
