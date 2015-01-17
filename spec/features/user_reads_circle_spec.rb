require "rails_helper"

feature "User Reads a private circle", %q(
As the authenticated user
I want try and go to my private circle
So that I can see my private groups chat and picture

Acceptance Criteria
[ ] Go to circles/[:id]

) do

  let(:circle) { FactoryGirl.create(:circle, is_private: true) }
  context "authenticated user" do

    scenario "authenticated user reads my private circle" do

      visit new_user_session_path
      fill_in "user[email]", with: circle.user.email
      fill_in "user[password]", with: circle.user.password

      click_button "Login"
      visit circle_path(circle)

      expect(page).to have_content("Round circle")
      expect(page).to have_content("This circle is the best")
    end
  end

  context "authenticated user" do
    scenario "authenticated user who is not part of the group" do

      unauth_user = FactoryGirl.create(:user)
      visit new_user_session_path
      fill_in "user[email]", with: unauth_user.email
      fill_in "user[password]", with: unauth_user.password

      click_button "Login"
      visit circle_path(circle)

      expect(page).to have_content("You do not have access to that circle!")
    end
  end

  context "unauthorized user" do
    scenario "user tries to read a private group user is not part of" do
      visit circle_path(circle)

      expect(page).to have_content("You do not have access to that circle!")
    end
  end
end
