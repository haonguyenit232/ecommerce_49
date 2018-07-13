require "rails_helper"

RSpec.describe Product, type: :model do
  context "associations" do
    it {is_expected.to belong_to :category}
  end

  context "validates" do
    it "quantity can not be blank"do
      is_expected.to validate_presence_of(:quantity)
      .with_message(I18n.t("activerecord.errors.models.attributes.quantity.blank"))
    end
    it "quantity is not a number" do
      is_expected.not_to allow_value(Faker::Lorem.word).for(:quantity)
      .with_message(I18n.t("activerecord.errors.models.attributes.quantity.not_a_number"))
    end
    it "quantity must be an integer" do
      is_expected.not_to allow_value(Faker::Number.decimal(1)).for(:quantity)
      .with_message(I18n.t("activerecord.errors.models.attributes.quantity.must_an_integer"))
    end
    it "quantity must be greater than or equal to 1" do
      is_expected.not_to allow_value(Settings.not_to_allow_less_1)
      .for(:quantity)
      .with_message(I18n.t("activerecord.errors.models.attributes.quantity.gt_or_eq"))
    end
  end
end
