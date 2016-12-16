class BB8::Decrypt
  def self.call(path)
    new(path).call
  end

  def initialize(path)
    @path = path
  end

  def call
    cipher.decrypt
    cipher.key = variables['BB8_SECRET_KEY']
    cipher.iv  = variables['BB8_SECRET_IV']

    buffer = ""
    File.open(path.gsub('.enc', ''), "wb") do |output|
      File.open(path, "rb") do |input|
        while input.read(4096, buffer)
          output << cipher.update(buffer)
        end
        output << cipher.final
      end
    end
  end

  private

  attr_reader :path

  def cipher
    @cipher ||= OpenSSL::Cipher.new('aes-256-cbc')
  end

  def variables
    @variables ||= BB8::VoltosVariables.call
  end
end
