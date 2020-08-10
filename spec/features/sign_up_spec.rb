describe "Sign up" do
  scenario "Signing up incorrectly: error messages displayed in the page" do
    visit sessions_sign_up_path
    expect(page).not_to have_content "Email must be a valid email address"
    expect(page).not_to have_content "Password too short"
    expect(page).not_to have_content "Confirmation password does not match"

    click_on "Sign up"

    expect(page).to have_content "Email must be a valid email address"
    expect(page).to have_content "Password too short"
    expect(page).to have_content "Confirmation password does not match"
  end
end
