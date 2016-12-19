class BB8::SetEncryptionKeys
  def self.call
    new.call
  end

  def call
    return if bundle.variables['BB8_SECRET_KEY']

    bundle.set 'BB8_SECRET_KEY', SecureRandom.hex(16)
    bundle.set 'BB8_SECRET_IV',  SecureRandom.hex(8)
  end

  private

  def bundle
    @bundle ||= BB8::Voltos.current_bundle
  end
end
