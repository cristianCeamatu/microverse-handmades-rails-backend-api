require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:items) }
    it { should have_many(:favorites) }
    it { should have_many(:favorite_items) }
  end

  describe 'validations' do

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:nickname) }
    it { is_expected.to validate_presence_of(:email) }

    # it { is_expected.to validate_content_type_of(:photo).allowing('image/png', 'image/jpeg') }
    # it { is_expected.to validate_content_type_of(:photo).rejecting('text/plain', 'text/xml') }
    # it { is_expected.to validate_size_of(:photo).less_than(3.megabytes) }

    # it { is_expected.to validate_content_type_of(:cover_image).allowing('image/png', 'image/jpeg') }
    # it { is_expected.to validate_content_type_of(:cover_image).rejecting('text/plain', 'text/xml') }
    # it { is_expected.to validate_size_of(:cover_image).less_than(4.megabytes) }
  end

  describe 'scopes' do
    before :each do
      @user = User.create!(name: 'Marshall', email: 'uimarshall@gmail.com', password: '12345678', nickname: 'crisBros')
    end

    it 'can be created and accesed' do
      expect(User.first).to eq(@user)
    end

    # it 'can upload an avatar' do
    #   file = File.open(Rails.root.join('app', 'assets', 'images', 'avatar.jpg'))
    #   attached = @user1.photo.attach(io: file, filename: 'avatar.jpg', content_type: 'image/jpg')
    #   expect(attached).to eq(true)
    # end

    # it 'can upload a cover image' do
    #   file = File.open(Rails.root.join('app', 'assets', 'images', 'placeholder.jpg'))
    #   attached = @user1.cover_image.attach(io: file, filename: 'placeholder.jpg', content_type: 'image/jpg')
    #   expect(attached).to eq(true)
    # end
  end
end
