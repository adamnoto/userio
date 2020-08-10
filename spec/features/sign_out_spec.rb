describe "Sign out" do
  scenario "Signing out after signing up: succeed" do
    visit sessions_sign_up_path
    fill_in "Email", with: "adam@example.org"
    fill_in "Password", with: "Password01"
    fill_in "Confirmation password", with: "Password01"
    click_on "Sign up"

    expect(current_path).to eq profile_path
    click_on "Sign out"

    visit profile_path
    expect(current_path).not_to eq profile_path
  end
end
