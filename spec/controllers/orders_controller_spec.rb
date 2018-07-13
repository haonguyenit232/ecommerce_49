require "rails_helper"
describe OrdersController, type: :controller do

  describe "before action" do
    context "order must" do
      it {is_expected.to use_before_action(:find_order)}
      it {is_expected.to use_before_action(:load_orders)}
      it {is_expected.to use_before_action(:check_cart_empty)}
      it {is_expected.to use_before_action(:current_cart)}
      it {is_expected.to use_before_action(:authenticate_user!)}
    end
  end
end
