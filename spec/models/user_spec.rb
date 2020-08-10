describe User do
  let(:password) { "Password01" }
  subject { create :user, password: password }

  describe "#valid_password?" do
    it "returns true if correct" do
      expect(subject).to be_valid_password password
    end

    it "returns false if incorrect" do
      expect(subject).not_to be_valid_password "123"
    end
  end

  describe "#password" do
    it "is valid if at least 8-characters long" do
      subject = build :user
      subject.password = subject.confirmation_password = "1234567"
      expect(subject).not_to be_valid

      subject.password = subject.confirmation_password = "12345678"
      expect(subject).to be_valid

      subject.password = subject.confirmation_password = "1" * 10
      expect(subject).to be_valid
    end
  end

  describe "#email" do
    it "is lowercased when saved" do
      expect(subject).to be_valid

      subject.email = "ADAMNOTO@EXAMPLE.org"
      expect(subject.save).to be_truthy
      expect(subject.email).to eq "adamnoto@example.org"
    end

    it "is unique" do
      expect {
        create(:user, email: subject.email.upcase)
      }.to raise_error ActiveRecord::RecordNotUnique
    end

    it { is_expected.not_to allow_value("").for(:email) }
    it { is_expected.not_to allow_value("foo.bar").for(:email) }
    it { is_expected.not_to allow_value("foo.bar#example.org").for(:email) }
    it { is_expected.to allow_value("f.o.o.b.a.r@example.org").for(:email) }
    it { is_expected.to allow_value("foo+bar@example.org").for(:email) }
    it { is_expected.to allow_value("foo.bar@sub.example.co.id").for(:email) }
  end

  describe "#username" do
    context "when new record" do
      it "equals to local part of the email" do
        subject = build :user
        expect(subject).to be_new_record

        local_part = "adam12345_cool"
        email = "#{local_part}@example.org"
        subject.email = email

        subject.save

        expect(subject.username).to eq local_part
      end

      it "tolerates username less than 5 characters long" do
        expect {
          create :user, email: "abcd@example.org"
        }.to change {
          User.find_by_email("abcd@example.org")
        }.from(nil).and change {
          User.find_by_username("abcd")
        }.from(nil)
      end
    end

    context "when not new record" do
      it "enforces length requirement" do
        subject = create :user
        subject.username = "abcd"
        expect(subject).not_to be_valid
        subject.username = "abcde"
        expect(subject).to be_valid
      end
    end
  end
end
