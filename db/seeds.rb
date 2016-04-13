# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'ffaker'

100.times { 
  User.create(
    open_id: FFaker::Guid.guid,
    cell: FFaker::PhoneNumberCU.e164_mobile_phone_number,
    name: FFaker::NameCN.name,
    email: FFaker::Internet.email,
    id_type: User::ID_TYPES.sample,
    nickname: FFaker::Name.first_name,
    gender: User::GENDER_TYPES.sample,
    address: FFaker::Address.street_address,
    card_type: Individual::ID_TYPES.sample,
    card_no: FFaker::Guid.guid,
    card_front: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, 'spec/fixtures/rails.png'))),
    card_back: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, 'spec/fixtures/rails.png'))),
    remark: FFaker::LoremCN.sentence,
    number: FFaker::Guid.guid,
    state: User::STATES.sample
  )
}
100.times {
  Fund.create(
    name: FFaker::LoremCN.words,
    desc: FFaker::LoremCN.sentence,
    title1: FFaker::LoremCN.word,
    content1: FFaker::LoremCN.sentence,
    title2: FFaker::LoremCN.word,
    content2: FFaker::LoremCN.sentence,
    title3: FFaker::LoremCN.word,
    content3: FFaker::LoremCN.sentence,
    progress_bar: rand(100),
    label: FFaker::LoremCN.word,
    currency: ["人民币", "美元"].sample
    )
}

100.times {
  Individual.create(
    user_id: User.all.sample.id,
    name: FFaker::NameCN.name,
    cell: FFaker::PhoneNumberCU.e164_mobile_phone_number,
    remark_name: FFaker::LoremCN.word,
    id_type: Individual::ID_TYPES.sample,
    id_no: FFaker::Guid.guid,
    id_front: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, 'spec/fixtures/rails.png'))),
    id_back: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, 'spec/fixtures/rails.png'))),
    remark: FFaker::LoremCN.sentence,
    state: ["提交", "确认", "否决"].sample
    )
}