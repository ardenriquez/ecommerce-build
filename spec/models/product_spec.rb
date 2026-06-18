require "rails_helper"

RSpec.describe Product, type: :model do
  # Associations
  describe "associations" do
    it { should belong_to(:shop) }
  end

  # Validations
  describe "validations" do
    context "when name is not preset" do
      it "is not valid" do
        product = build(:product, name: nil)
        expect(product).not_to be_valid
      end
    end

    context "when sku is not preset" do
      it "is not valid" do
        product = build(:product, sku: nil)
        expect(product).not_to be_valid
      end
    end

    context "when price_in_cents is not preset" do
      it "is not valid" do
        product = build(:product, price_in_cents: nil)
        expect(product).not_to be_valid
      end
    end

    context "when stock_quantity is not preset" do
      it "is not valid" do
        product = build(:product, stock_quantity: nil)
        expect(product).not_to be_valid
      end
    end

    context "when status is not in the list" do
      it "is not valid" do
        product = build(:product, status: "notallowedstatus")
        expect(product).not_to be_valid
      end
    end

    context "when sku already exists for the same shop" do
      it "is not valid" do
        product = create(:product)
        product2 = build(:product, shop: product.shop, sku: product.sku)
        expect(product2).not_to be_valid
      end
    end
  end

  # Callbacks
  # For callbacks, reload is needed
  describe "#strip_name" do
    context "when name has trailing space" do
      it "strips the whitespace" do
        product = create(:product, name: "   Sample Product    ")
        expect(product.reload.name).to eq("Sample Product")
      end
    end
  end

  # Scopes
  describe "scopes" do
    let!(:available_product) { create(:product, :available) }
    let!(:discontinued_product) { create(:product, :discontinued) }
    let!(:out_of_stock_product) { create(:product, :out_of_stock) }

    describe ".available" do
      it "returns only available products" do
        expect(Product.available).to eq([available_product])
      end
    end

    describe ".out_of_stock" do
      it "returns only out of stock products" do
        expect(Product.out_of_stock).to eq([out_of_stock_product])
      end
    end

    describe ".discontinued" do
      it "returns only discontinued products" do
        expect(Product.discontinued).to eq([discontinued_product])
      end
    end
  end

  # Instance methods
  describe "#in_stock?" do
    it "returns true when stock_quantity is greater than 0" do
      product = build(:product, stock_quantity: 5)
      expect(product.in_stock?).to be true
    end

    it "returns false when stock_quantity is 0" do
      product = build(:product, stock_quantity: 0)
      expect(product.in_stock?).to be false
    end
  end

  describe "#available?" do
    it "returns true when status is 'available' and in_stock?" do
      product = build(:product, :available, stock_quantity: 5)
      expect(product.available?).to be true
    end

    it "returns false when status is 'available' but not in_stock?" do
      product = build(:product, :available, stock_quantity: 0)
      expect(product.available?).to be false
    end

    it "returns false when status is not 'available'" do
      product = build(:product, :out_of_stock, stock_quantity: 5)
      expect(product.available?).to be false
    end
  end

  describe "#price" do
    it "returns the price in pesos" do
      product = build(:product, price_in_cents: 1000)
      expect(product.price).to eq(10.0)
    end
  end
end
