#encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# Spree::Core::Engine.load_seed if defined?(Spree::Core)
# Spree::Auth::Engine.load_seed if defined?(Spree::Auth)
payments = PaymentType.create([{:name => "Наличный расчёт"}, {:name => "Банковской картой"}, {:name => "Электронные деньги"}]) #unless PaymentType.first.nil?
delivers = DeliveryType.create([{:name => "Доставка по Москве(в пределах МКАД)"},{:name => "Доставка по области за пределы Москвы(МКАД)"},{:name => "Самовывоз"}]) #unless DeliveryType.first.nil?