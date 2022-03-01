namespace :dev do
  desc "Configura o ambiente de desenvolvimento" # descrição
  task setup: :environment do
    puts "Resetando o BD..."
    %x(rails db:drop db:create db:migrate)

    puts "Criando tipos de contatos..."

    kinds = ["Amigo", "Comercial", "Conhecido"]
    kinds.each do |kind|
      Kind.create!(
        description: kind
      )
    end
    
    puts "Tipos de contatos cadastrados com sucesso!"
    
    #########################################################
    puts "Criando os contatos..."

    100.times do |i| # Criar 100 contatos
      Contact.create!( # ! Força exibição do erro(caso ocorra) em tela
        name: Faker::Name.name, # Usando a gem faker
        email: Faker::Internet.email,
        birthdate: Faker::Date.birthday(min_age: 18, max_age: 65),
        kind: Kind.all.sample
      )
    end

    puts "Contatos criados com sucesso!"

    #########################################################
    puts "Criando os telefones..."

    Contact.all.each do |contact|
      Phone.create!(
        number: Faker::PhoneNumber.phone_number,
        contact: contact
      )
    end

    puts "Telefones criados com sucesso!"

    #########################################################
    puts "Cadastrando os endereços..."

    Contact.all.each do |contact|
      Address.create(
        street: Faker::Address.street_address,
        city: Faker::Address.city,
        contact: contact
      )
    end

    puts "Endereços criados com sucesso!"

  end
end
