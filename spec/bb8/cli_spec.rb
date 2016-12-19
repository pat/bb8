require 'spec_helper'

RSpec.describe BB8::CLI do
  before :each do
    allow(Dir).to receive(:[]).and_return([])
  end

  it 'understands the init command' do
    expect(BB8::Commands::InitialiseProject).to receive(:call).with('mydir')

    BB8::CLI.call 'init', 'mydir'
  end

  it 'understands the version command' do
    expect(BB8::Commands::Version).to receive(:call)

    BB8::CLI.call 'version'
  end

  it 'understands the help command' do
    expect(BB8::Commands::Help).to receive(:call)

    BB8::CLI.call 'help'
  end

  it 'defaults to the help command' do
    expect(BB8::Commands::Help).to receive(:call)

    BB8::CLI.call
  end

  it 'defaults to the help command for non-existent commands/environments' do
    expect(BB8::Commands::Help).to receive(:call)

    BB8::CLI.call 'preview'
  end

  it 'understands the environment command' do
    expect(BB8::Commands::InitialiseEnvironment).to receive(:call).with(
      'staging', 'my-bundle'
    )

    BB8::CLI.call 'environment', 'staging', 'my-bundle'
  end

  it 'delegates environment commands to Terraform' do
    allow(Dir).to receive(:[]).and_return(['staging'])
    allow(File).to receive(:directory?).and_return(true)

    expect(BB8::Commands::Terraform).to receive(:call).with('staging', 'apply')

    BB8::CLI.call 'staging', 'apply'
  end
end
