describe PasswordResetToken do
  subject! { create :password_reset_token }

  describe "#active?" do
    context "when within 6 hours after creation" do
      it "returns true" do
        expect(subject).to be_active

        travel_to (6.hours - 1.second).from_now do
          expect(subject).to be_active
        end
      end
    end

    context "when outside 6 hours after creation" do
      it "returns false" do
        expect(subject).to be_active

        travel_to (6.hours + 1.second).from_now do
          expect(subject).not_to be_active
        end
      end
    end
  end
end
