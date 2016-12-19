class BB8::Commands::Help
  def self.call
    puts <<-MESSAGE
BB-8 Version #{BB8::VERSION}

Usage:

  bb8 init .                                Set up a directory as a git
                                            repository.
  bb8 environment staging my-voltos-bundle  Set up a directory for a specific
                                            environment.
  bb8 ENVIRONMENT [show|apply|destroy|...]  Run a Terraform command within a
                                            specific environment's context.
  bb8 version                               Outputs BB8's version.
  bb8 help                                  Outputs this information.
    MESSAGE
  end
end
