class Pagarme::UpdateRecipientService
  require 'pagarme'

  PagarMe.api_key        = ENV['PAGARME_API_KEY']
  PagarMe.encryption_key = ENV['PAGARME_ENCRYPTION_KEY']

  def initialize(params)
    @profile = params[:profile]
  end

  def call
    recipient_id = @profile.recipient_id;
    recipient = PagarMe::Recipient.find_by_id(recipient_id)
    recipient.bank_account_id = @profile.bank_account.bank_id
    recipient.save
  end

end
