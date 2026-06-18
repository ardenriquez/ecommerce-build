require "rails_helper"

RSpec.describe Shop, type: :model do
  # Associations
  describe "associations" do
    it { should have_many(:products).dependent(:destroy) }
  end

  # Validations
  describe "validations" do
    context "when name is not preset" do
      it "is not valid" do
        shop = build(:shop, name: nil)
        expect(shop).not_to be_valid
      end
    end

    context "when status is not in the list" do
      it "is not valid" do
        shop = build(:shop, status: "notallowedstatus")
        expect(shop).not_to be_valid
      end
    end
  end

  # Callbacks
  # For callbacks, reload is needed
  describe "#strip_name" do
    context "when name has trailing space" do
      it "strips the whitespace" do
        shop = create(:shop, name: "   Sample Shop    ")
        expect(shop.reload.name).to eq("Sample Shop")
      end
    end
  end

  # Scopes
  describe "scopes" do
    let!(:open_shop) { create(:shop, :open) }
    let!(:closed_shop) { create(:shop, :closed) }
    let!(:suspended_shop) { create(:shop, :suspended) }

    describe ".open" do
      it "returns only open shops" do
        expect(Shop.open).to eq([open_shop])
      end
    end

    describe ".closed" do
      it "returns only closed shops" do
        expect(Shop.closed).to eq([closed_shop])
      end
    end

    describe ".suspended" do
      it "returns only suspended shops" do
        expect(Shop.suspended).to eq([suspended_shop])
      end
    end
  end

  # Instace methods
  describe "#open?" do
    context "when status is open" do
      it "returns true" do
        shop = build(:shop, :open)
        expect(shop.open?).to be true
      end
    end

    context "when status is not open" do
      it "returns false" do
        shop = build(:shop, :closed)
        expect(shop.open?).to be false
      end
    end
  end

  describe "#suspended?" do
    context "when status is suspended" do
      it "returns true" do
        shop = build(:shop, :suspended)
        expect(shop.suspended?).to be true
      end
    end

    context "when status is not suspended" do
      it "returns false" do
        shop = build(:shop, :open)
        expect(shop.suspended?).to be false
      end
    end
  end
end
