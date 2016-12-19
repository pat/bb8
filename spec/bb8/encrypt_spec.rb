require 'spec_helper'

RSpec.describe BB8::Encrypt do
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

    cipher.decrypt
    cipher.key = variables['BB8_SECRET_KEY']
    cipher.iv  = variables['BB8_SECRET_IV']
  end

  after :each do
    File.delete path      if File.exist?(path)
    File.delete encrypted if File.exist?(encrypted)
  end

  it 'decrypts an encrypted file' do
    File.write path, 'storing the secrets of the rebellion'

    BB8::Encrypt.call path

    buffer = ""
    output = StringIO.new

    File.open(encrypted, "rb") do |input|
      while input.read(4096, buffer)
        output << cipher.update(buffer)
      end
      output << cipher.final
    end

    output.rewind
    expect(output.read).to eq('storing the secrets of the rebellion')
  end
end
