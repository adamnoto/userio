describe User do
  let(:password) { "Password01" }
  let(:user) { create :user, password: password }

  describe "#valid_password?" do
    it "returns true if correct" do
      expect(user).to be_valid_password password
    end

    it "returns false if incorrect" do
      expect(user).not_to be_valid_password "123"
    end
  end
end
