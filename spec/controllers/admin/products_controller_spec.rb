require "rails_helper"

describe Admin::ProductsController do
  let(:category) {create :category}

  describe "admin access" do

    it "checks admin user" do
      is_expected.to use_before_action :is_admin
    end

    describe "before action" do
      context "product must" do
        it {is_expected.to use_before_action(:load_product)}
        it {is_expected.to use_before_action(:find_product)}
      end
    end

    describe "GET new" do
      it "assigns a blank product to the view" do
        get :new
        expect(assigns(:product)).to be_a_new(Product)
      end
    end
  end
end
