class Pagarme::CreateBankAccountService
  require 'pagarme'

  PagarMe.api_key        = ENV['PAGARME_API_KEY']
  PagarMe.encryption_key = ENV['PAGARME_ENCRYPTION_KEY']

  def initialize(params)
    @store_bank_account = params[:store_bank_account]
    @profile = params[:profile]
  end
  
  def call
    bank_account = PagarMe::BankAccount.new({
      :bank_code => @store_bank_account.bank_code,
      :agencia => @store_bank_account.agency,
      :agencia_dv => @store_bank_account.agency_dv,
      :conta => @store_bank_account.account,
      :conta_dv => @store_bank_account.account_dv,
      :legal_name => @store_bank_account.legal_name,
      :document_number => @store_bank_account.document_number
    })
    bank_account.create
  end

end
