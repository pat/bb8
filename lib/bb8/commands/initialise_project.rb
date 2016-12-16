class BB8::Commands::InitialiseProject
  def self.call(path)
    new(path).call
  end

  def initialize(path)
    @path = File.expand_path path
  end

  def call
    FileUtils.mkdir_p path

    `git init #{path}` unless git_present?
    add_gitignore      unless gitignore_present?
  end

  private

  attr_reader :path

  def add_gitignore
    File.write gitignore_path, <<-INPUT
.env
*/.env
*.tfvars
*/*.tfvars
*.tfstate
*.tfstate.backup
*/*.tfstate
*/*.tfstate.backup
    INPUT
  end

  def gitignore_path
    File.join(path, '.gitignore')
  end

  def git_present?
    File.exist? File.join(path, '.git')
  end

  def gitignore_present?
    File.exist? gitignore_path
  end
end
