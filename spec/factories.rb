# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { 'password' }
  end

  factory :task do
    name { 'Sample Task' }
    amount { 3000 }
    author_id { User.first.id }
  end

  factory :group do
    name { 'Sample Group 1' }
    user_id { User.first.id }
  end
end
