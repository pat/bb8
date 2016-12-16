class BB8::Commands::Terraform
  def self.call(environment, command, *arguments)
    new(environment, command, *arguments).call
  end

  def initialize(environment, command, *arguments)
    @environment, @command, @arguments = environment, command, arguments
  end

  def call
    `git pull origin`

    Dir.chdir environment

    BB8::SetEncryptionKeys.call

    `cp ../common.tf common.tf` if File.exist?('../common.tf')
    Dir['*.enc'].each { |path| BB8::Decrypt.call path }

    system "terraform #{command} #{arguments.join(' ')}"

    Dir['*.tfvars'].each         { |path| BB8::Encrypt.call path }
    Dir['*.tfstate'].each        { |path| BB8::Encrypt.call path }
    Dir['*.tfstate.backup'].each { |path| BB8::Encrypt.call path }

    Dir.chdir '..'
    `git add .`
    `git commit -m "[bb8] Update Terraform files after running #{command}"`
    `git push origin`
  end

  private

  attr_reader :environment, :command, :arguments

  def voltos_bundle
    @voltos_bundle ||= File.read('.bb8_bundle')
  end
end
