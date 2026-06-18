require "rails_helper"

RSpec.describe User, type: :model do
  # Validations
  describe "validations" do
    context "when email is not preset" do
      it "is not valid" do
        user = build(:user, email: nil)
        expect(user).not_to be_valid
      end
    end

    context "when email format is invalid" do
      it "is not valid" do
        user = build(:user, email: "not-valid-email")
        expect(user).not_to be_valid
      end
    end

    context "when email already exists" do
      it "is not valid" do
        email = "sample@email.com"
        create(:user, email: email)
        user = build(:user, email: email)
        expect(user).not_to be_valid
      end
    end

    context "when role is not in the list" do
      it "is not valid" do
        user = build(:user, role: "notallowedrole")
        expect(user).not_to be_valid
      end
    end

    context "when all attributes are valid" do
      it "is valid" do
        user = build(:user)
        expect(user).to be_valid
      end
    end
  end

  # Callbacks
  # For callbacks, reload is needed
  describe "#downcase_email" do
    context "when email has uppercase" do
      it "set to downcase before validating" do
        user = create(:user, email: "Sample@email.com")
        expect(user.reload.email).to eq("sample@email.com")
      end
    end

    context "when email has trailing space" do
      it "strip the whitespace" do
        user = create(:user, email: "   sample@email.com    ")
        expect(user.reload.email).to eq("sample@email.com")
      end
    end
  end

  # Instace methods
  describe "#admin?" do
    context "when role is admin" do
      it "returns true" do
        user = build(:user, :admin)
        expect(user.admin?).to be true
      end
    end

    context "when role is customer" do
      it "returns false" do
        user = build(:user, role: "customer")
        expect(user.admin?).to be false
      end
    end
  end

  describe "#customer?" do
    context "when role is customer" do
      it "returns true" do
        user = build(:user)
        expect(user.customer?).to be true
      end
    end

    context "when role is admin" do
      it "returns false" do
        user = build(:user, :admin)
        expect(user.customer?).to be false
      end
    end
  end
end
