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

  describe "#password" do
    it "is valid if at least 8-characters long" do
      user = build :user
      user.password = user.confirmation_password = "1234567"
      expect(user).not_to be_valid

      user.password = user.confirmation_password = "12345678"
      expect(user).to be_valid

      user.password = user.confirmation_password = "1" * 10
      expect(user).to be_valid
    end
  end

  describe "#email" do
    it "is lowercased when saved" do
      expect(user).to be_valid

      user.email = "ADAMNOTO@EXAMPLE.org"
      expect(user.save).to be_truthy
      expect(user.email).to eq "adamnoto@example.org"
    end

    it "is unique" do
      expect {
        create(:user, email: user.email.upcase)
      }.to raise_error ActiveRecord::RecordNotUnique
    end

    it { is_expected.not_to allow_value("").for(:email) }
    it { is_expected.not_to allow_value("foo.bar").for(:email) }
    it { is_expected.not_to allow_value("foo.bar#example.org").for(:email) }
    it { is_expected.to allow_value("f.o.o.b.a.r@example.org").for(:email) }
    it { is_expected.to allow_value("foo+bar@example.org").for(:email) }
    it { is_expected.to allow_value("foo.bar@sub.example.co.id").for(:email) }
  end

end
