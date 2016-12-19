require 'spec_helper'

RSpec.describe BB8::Decrypt do
  let(:path)      { File.expand_path './rspec-test' }
  let(:encrypted) { "#{path}.enc" }
  let(:cipher)    { OpenSSL::Cipher.new('aes-256-cbc') }
  let(:bundle)    { double :variables => variables }
  let(:variables) {
    {
      'BB8_SECRET_KEY' => SecureRandom.hex(16),
      'BB8_SECRET_IV'  => SecureRandom.hex(8)
    }
  }

  before :each do
    allow(BB8::Voltos).to receive(:current_bundle).and_return(bundle)

    cipher.encrypt
    cipher.key = variables['BB8_SECRET_KEY']
    cipher.iv  = variables['BB8_SECRET_IV']
  end

  after :each do
    File.delete path      if File.exist?(path)
    File.delete encrypted if File.exist?(encrypted)
  end

  it 'decrypts an encrypted file' do
    buffer = ""
    input  = StringIO.new('storing the secrets of the rebellion')

    File.open(encrypted, "wb") do |output|
      while input.read(4096, buffer)
        output << cipher.update(buffer)
      end
      output << cipher.final
    end

    BB8::Decrypt.call encrypted

    expect(File.read(path)).to eq('storing the secrets of the rebellion')
  end
end
