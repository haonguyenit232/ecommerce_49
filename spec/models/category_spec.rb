require "rails_helper"

RSpec.describe Category, type: :model do
  context "associations" do
    it {is_expected.to have_many :products}
  end

  context "validates" do
    it "name can not be blank" do
      is_expected.to validate_presence_of(:name)
      .with_message(I18n.t("activerecord.errors.models.attributes.category.name.blank"))
    end

    it "name is invalid" do
      is_expected.to validate_uniqueness_of(:name).case_insensitive
      .with_message(I18n.t("activerecord.errors.models.attributes.category.name.uniqueness"))
    end
  end

  describe ".super" do
    let(:category) {create :category, parent_category: nil}
    let(:category_one) {create :category, parent_category: nil}
    let(:category_two) {create :category, parent_category: Faker::Number.between(1,
      Category.all.count)}
    it "return list categories that do not have parent category" do
      expect(Category.super).to match_array [category, category_one]
    end
  end
end
