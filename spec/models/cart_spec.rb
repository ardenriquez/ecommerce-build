require "rails_helper"

RSpec.describe Cart, type: :model do
  # Associations
  describe "associations" do
    it { should belong_to(:user) }
  end

  # Validations
  describe "validations" do
    context "when expires_at is not preset" do
      it "is not valid" do
        cart = build(:cart, expires_at: nil)
        expect(cart).not_to be_valid
      end
    end

    context "when status is not in the list" do
      it "is not valid" do
        cart = build(:cart, status: "notallowedstatus")
        expect(cart).not_to be_valid
      end
    end

    context "when user is not unique for active cart" do
      it "is not valid" do
        user = create(:user)
        create(:cart, user: user, status: "active")
        cart = build(:cart, user: user, status: "active")
        expect(cart).not_to be_valid
      end
    end

    context "when user already has a checked_out cart" do
      it "is valid" do
        user = create(:user)
        create(:cart, user: user, status: "checked_out")
        cart = build(:cart, user: user, status: "checked_out")
        expect(cart).to be_valid
      end
    end
  end

  # Scopes
  describe "scopes" do
    let!(:active_cart) { create(:cart, :active) }
    let!(:checked_out_cart) { create(:cart, :checked_out) }

    describe ".active" do
      it "returns only active carts" do
        expect(Cart.active).to eq([active_cart])
      end
    end

    describe ".checked_out" do
      it "returns only checked out carts" do
        expect(Cart.checked_out).to eq([checked_out_cart])
      end
    end
  end

  # Instance method
  describe "#active?" do
    it "returns true when status is 'active'" do
      cart = build(:cart, status: "active")
      expect(cart.active?).to be true
    end

    it "returns false when status is not 'active'" do
      cart = build(:cart, status: "checked_out")
      expect(cart.active?).to be false
    end
  end

  describe "#expired?" do
    it "returns true when expires_at is in the past" do
      cart = build(:cart, expires_at: 1.week.ago)
      expect(cart.expired?).to be true
    end

    it "returns false when expires_at is in the future" do
      cart = build(:cart, expires_at: 1.week.from_now)
      expect(cart.expired?).to be false
    end
  end

  describe "#checkout!" do
    it "updates the status to 'checked_out'" do
      cart = create(:cart, :active)
      cart.checkout!
      expect(cart.reload.status).to eq("checked_out")
    end
  end
end
