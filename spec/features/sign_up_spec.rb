describe "Sign up" do
  scenario "Signing up incorrectly: error messages displayed in the page" do
    visit sessions_sign_up_path
    expect(page).not_to have_content "Email must be a valid email address"
    expect(page).not_to have_content "Password too short"
    expect(page).not_to have_content "Confirmation password does not match"

    fill_in "Confirmation password", with: "ABC"
    click_on "Sign up"

    expect(page).to have_content "Email must be a valid email address"
    expect(page).to have_content "Password too short"
    expect(page).to have_content "Confirmation password does not match"
  end

  scenario "Signing up correctly: see profile page and expect to receive email" do
    expect(ActionMailer::Base.deliveries).to be_blank
    visit sessions_sign_up_path

    fill_in "Email", with: "adam@example.org"
    fill_in "Password", with: "Password01"
    fill_in "Confirmation password", with: "Password01"
    click_on "Sign up"

    expect(current_path).to eq profile_path
    expect(page).to have_content "Sign out"

    expect(ActionMailer::Base.deliveries.map(&:subject)).to eq ["Welcome to UserIO"]
  end
end
