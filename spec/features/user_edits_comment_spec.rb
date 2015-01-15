require "rails_helper"

feature "User Edits a Comment on a Circle", %q(
As the authenticated user
I want to edit a comment I already posted
So that I can share my edited thoughts within the circle

Acceptance Criteria
[ ] Go to circles/[:id]
[ ] User edits a comment

) do

  let(:circle) { FactoryGirl.create(:circle) }
  context "authenticated user" do

    scenario "authenticated user submits a comment" do

      visit new_user_session_path
      fill_in "user[email]", with: circle.user.email
      fill_in "user[password]", with: circle.user.password

      click_button "Login"
      visit circle_path(circle)
      fill_in "Chat away!", with: "This is cool"

      click_button "Submit"
      expect(page).to have_content("This is cool")

    end
  end

  context "unauthenticated user" do
    scenario "user tries to comment on circle when not signed in" do
      visit circle_path(circle)

      fill_in "Chat away!", with: "This is so not cool"
      click_button "Submit"
      expect(page).to have_content("You need to sign in or sign up before continuing.")
    end
  end
end
