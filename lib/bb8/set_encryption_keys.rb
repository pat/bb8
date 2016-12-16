class BB8::SetEncryptionKeys
  def self.call
    new.call
  end

  def call
    return if variables['BB8_SECRET_KEY']

    cipher.encrypt

    `voltos set BB8_SECRET_KEY=#{cipher.random_key}`
    `voltos set BB8_SECRET_IV=#{cipher.random_iv}`
  end

  private

  def cipher
    @cipher ||= OpenSSL::Cipher.new('aes-256-cbc')
  end

  def variables
    @variables ||= BB8::VoltosVariables.call
  end
end
