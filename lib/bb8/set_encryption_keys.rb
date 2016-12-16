class BB8::SetEncryptionKeys
  def self.call
    new.call
  end

  def call
    return if variables['BB8_SECRET_KEY']

    `voltos set BB8_SECRET_KEY=#{SecureRandom.hex(16)}`
    `voltos set BB8_SECRET_IV=#{SecureRandom.hex(8)}`
  end

  private

  def variables
    @variables ||= BB8::VoltosVariables.call
  end
end
