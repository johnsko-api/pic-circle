require "rails_helper"

feature "User Gets accepted to a Private Circle", %q(
As the authenticated user
I want to accept a user to a private circle
So that I can view and share privately

Acceptance Criteria
[ ] Go to a private circles/[:id]/pending
[ ] Approve a pending invitation

) do

  let(:circle) { FactoryGirl.create(:circle, is_private: true) }
  let(:user){ FactoryGirl.create(:user) }
  context "authenticated user" do

    scenario "accept pending inviation" do

      visit new_user_session_path
      fill_in "user[email]", with: user.email
      fill_in "user[password]", with: user.password

      click_button "Login"
      visit circle_path(circle)
      click_link "Join Group"
      click_link "Logout"

      visit new_user_session_path
      fill_in "user[email]", with: circle.user.email
      fill_in "user[password]", with: circle.user.password

      click_button "Login"
      visit circle_path(circle)
      click_link "Pending"
      expect(page).to have_content("display name - #{user.email} Approve")
      click_link "Approve"
      expect(page).to have_content("display name - #{user.email}")
    end
  end
end
