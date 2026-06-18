require "rails_helper"

RSpec.describe CartItem, type: :model do
  # Associations
  describe "associations" do
    it { should belong_to(:cart) }
    it { should belong_to(:product) }
  end

  # Validations
  describe "validations" do
    context "when cart_id is not present" do
      it "is not valid" do
        cart_item = build(:cart_item, cart_id: nil)
        expect(cart_item).not_to be_valid
      end
    end

    context "when product_id is not present" do
      it "is not valid" do
        cart_item = build(:cart_item, product_id: nil)
        expect(cart_item).not_to be_valid
      end
    end

    context "when quantity is not greater than 0" do
      it "is not valid" do
        cart_item = build(:cart_item, quantity: 0)
        expect(cart_item).not_to be_valid
      end
    end

    context "when unit_price_in_cents is not greater than 0" do
      it "is not valid" do
        cart_item = build(:cart_item, unit_price_in_cents: 0)
        expect(cart_item).not_to be_valid
      end
    end

    context "when total_price_in_cents is not greater than 0" do
      it "is not valid" do
        cart_item = build(:cart_item, total_price_in_cents: 0)
        expect(cart_item).not_to be_valid
      end
    end
  end

  # Callback
  describe "#calculate_total_price" do
    it "sets total_price_in_cents before saving" do
      cart_item = create(:cart_item, quantity: 2, unit_price_in_cents: 1_000)
      expect(cart_item.total_price_in_cents).to eq(2_000)
    end
  end
end
