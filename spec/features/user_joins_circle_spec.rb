require "rails_helper"

feature "User Join a private circle", %q(
As the authenticated user
I want join a private circle
So that I can share my pictures and thoughts within the circle privately

Acceptance Criteria
[ ] Go to circles/[:id]
[ ] Join group

) do

  let(:circle) { FactoryGirl.create(:circle, is_private: true) }
  context "authenticated user" do

    scenario "authenticated user who is not part of the group" do

      unauth_user = FactoryGirl.create(:user)
      visit new_user_session_path
      fill_in "user[email]", with: unauth_user.email
      fill_in "user[password]", with: unauth_user.password

      click_button "Login"
      visit circle_path(circle)

      click_link "Join Group"
      expect(page).to have_content("You must now wait for approval!")
    end
  end

end
