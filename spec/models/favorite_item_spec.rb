require 'rails_helper'

RSpec.describe FavoriteItem, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:item) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:user_id) }
    it { is_expected.to validate_presence_of(:item_id) }
  end

  describe 'scopes' do
    before :each do
      @user = FactoryBot.create(:user)
      @item = @user.items.create!(name: 'Example', description: 'Example desx', price: 55.35, usedFor: 'Example use')
      @favorite_item = @user.favorite_items.create!(item_id: @item.id)
    end

    it 'can be created by user' do
      expect(FavoriteItem.first).to eq(@favorite_item)
    end

    it 'can be accessed by the user' do
      expect(@user.favorite_items.first).to eq(@favorite_item)
    end

    it 'can be accessed by the item' do
      expect(@item.favorite_items.first).to eq(@favorite_item)
    end
  end
end
