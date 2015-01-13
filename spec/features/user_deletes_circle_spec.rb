require "rails_helper"

feature "User Deletes a Circle", %q(
As the authenticated user that created the buddy
I want to delete the circle
So that I can delete the circle

Acceptance Criteria
[ ] Go to circles/:id
[ ] User can delete circle

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

      click_link "Delete"
      expect(page).to have_content("You've successfully deleted a circle!")

    end
  end
end
