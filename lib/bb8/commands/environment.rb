class BB8::Commands::Environment
  def self.call(environment, command, *arguments)
    case command
    when 'init'
      BB8::Commands::InitialiseEnvironment.call(environment, *arguments)
    else
      BB8::Commands::Terraform.call(environment, command, *arguments)
    end
  end
end
