require "rails_helper"

feature "User Edits a Circle", %q(
As the authenticated user that created the buddy
I want to edit the circle
So that I can share my update within my circle

Acceptance Criteria
[ ] Go to circles/edit to fill out form
[ ] User can update title
[ ] User can update description

) do

  let(:user){ FactoryGirl.create(:user) }
  let(:circle) { FactoryGirl.create(:circle) }
  context "authenticated user" do

    scenario "author of buddy successfully edits circle" do

      visit new_user_session_path
      fill_in "user[email]", with: user.email
      fill_in "user[password]", with: user.password

      click_button "Log in"
      visit circle_path(circle)

      click_link "Edit"
      fill_in "Title", with: "New Better Title"
      fill_in "Description", with: "New Better Description"

      click_button "Update Circle"
      expect(page).to have_content("You've successfully updated a circle!")

    end
  end
end
