describe "Sign in" do
  let(:password) { "Password01" }
  let(:user) { create :user, password: password }

  scenario "Signing in with correct credential: succeed" do
    visit sessions_sign_in_path
    fill_in "Email", with: user.email
    fill_in "Password", with: password
    click_on "Sign in"

    expect(current_path).to eq profile_path
    expect(page).to have_content "successfully"
  end

  scenario "Signing in with incorrect credential: failed" do
    visit sessions_sign_in_path
    fill_in "Email", with: user.email
    fill_in "Password", with: "#{password}WRONG"
    click_on "Sign in"

    expect(current_path).not_to eq profile_path
    expect(current_path).to eq sessions_sign_in_path
    expect(page).to have_content "Invalid credentials"
  end
end
