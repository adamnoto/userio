describe "Reset password" do
  let(:user) { create :user }

  scenario "Requesting the link to reset password for an exist account: succeed" do
    visit sessions_reset_token_path
    fill_in "Email", with: user.email
    click_on "Send me reset password instruction"

    expect(ActionMailer::Base.deliveries.map(&:subject)).to eq ["Reset password request"]
    expect(current_path).to eq sessions_sign_in_path
  end

  scenario "Requesting the link for non-existent account: ignored " do
    visit sessions_reset_token_path
    fill_in "Email", with: "not#{user.email}"
    click_on "Send me reset password instruction"

    expect(ActionMailer::Base.deliveries).to be_blank
    expect(current_path).to eq sessions_sign_in_path
  end
end
