require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:favorite_items) }
    it { should have_many(:favorited_by) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:price) }
    it { is_expected.to validate_presence_of(:usedFor) }

    it do
      should validate_length_of(:name).is_at_least(2).is_at_most(40)
    end   
    it do
      should validate_length_of(:usedFor).is_at_least(2).is_at_most(60)
    end
    it do
      should validate_length_of(:description).is_at_least(6).is_at_most(50_000)
    end
  end

  describe 'scopes' do
    before :each do
      @user = FactoryBot.create(:user)
      @item = @user.items.create!(name: 'Example',description: 'Example desx', price: 55.35, usedFor: 'Example use')
    end

    it 'can be created by user' do
      expect(Item.first).to eq(@item)
    end

    it 'can be accessed by the author' do
      expect(@user.items.first).to eq(@item)
    end
  end
end
