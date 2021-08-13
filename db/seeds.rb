# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Category.create(title: "Livros")
Subcategory.create(title: "Livros Nacionais", category_id: Category.first.id)

Client.create(name: 'Morpheus Fishburne', cpf_number: '30621143049', email: 'gabrielras100@gmail.com', password: '123456')

@store = Store.create(name: 'Gabriel', surname:'Rocha' , title: 'Loja Teste', cpf_number: '30621143049', cnpj_number: '01.863.190/0001-33',
phone_number: '85988634662', email: 'gabrielras100@gmail.com', password: '123456')

@profile = Profile.create(recipient_id: 're_ckc2lkljw04lih56d8k1nkaxw', store_id: @store.id, installment: 2)

BankAccount.create(bank_code: '237', agency: '1935', account: '23398', agency_dv: '9', account_dv: '9',
account_type: 0, legal_name:'API BANK ACCOUNT', document_number: '26268738888', bank_id: '18308691', profile_id: @profile.id)

Shipping.create(number_cep: '60182160', state: 'ce', city: 'fortaleza', neighborhood: 'vicent pizon', street: 'rua miguel calmon',
number_residence: '123', default_price: 0.12e3, default_delivery_time: 23, store_id: @store.id)
