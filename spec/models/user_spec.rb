require "rails_helper"

RSpec.describe User, type: :model do
  context "associations" do
    it {is_expected.to have_many :orders}
    it {is_expected.to have_many :ratings}
    it {is_expected.to have_many :comments}
    it {is_expected.to have_many :suggests}
  end

  describe "db schema" do
    context "columns" do
      it { should have_db_column(:email).of_type(:string) }
      it { should have_db_column(:name).of_type(:string) }
      it { should have_db_column(:phone).of_type(:string) }
      it { should have_db_column(:address).of_type(:string) }
    end
  end

  describe "validates" do
    context "email" do
      it "can not be blank" do
        is_expected.to validate_presence_of(:email)
        .with_message(I18n.t("activerecord.errors.models.attributes.email.blank"))
      end

      it "name can not be blank" do
        is_expected.to validate_presence_of(:name)
        .with_message(I18n.t("activerecord.errors.models.attributes.email.blank"))
      end

      it "wrong syntax" do
        is_expected.to_not allow_value("wrong_syntax").for(:email)
        .with_message(I18n.t("activerecord.errors.models.attributes.email.wrong_email_syntax"))
      end
    end

    context "password" do
      it "can not be blank" do
        is_expected.to validate_presence_of(:password)
        .with_message(I18n.t("activerecord.errors.models.attributes.password.blank"))
      end

      it "does not match Password" do
        is_expected.to validate_confirmation_of(:password)
        .with_message(I18n.t("activerecord.errors.models.attributes.password.confirmation"))
      end

      it "is too short (minimum is 6 characters)" do
        is_expected.to validate_length_of(:password)
        .is_at_least(Settings.min_pass_length)
        .with_message(I18n.t("activerecord.errors.models.attributes.password.length"))
      end
    end
  end
end
