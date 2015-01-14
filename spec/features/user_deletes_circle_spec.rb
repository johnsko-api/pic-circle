require "rails_helper"

feature "User Deletes a Circle", %q(
As the authenticated user that created the buddy
I want to delete the circle
So that I can delete the circle

Acceptance Criteria
[ ] Go to circles/:id
[ ] User can delete circle

) do

  # let(:user){ FactoryGirl.create(:user) }
  let(:circle) { FactoryGirl.create(:circle) }
  context "authenticated user" do

    scenario "author of buddy successfully deletes circle" do

      visit new_user_session_path
      fill_in "user[email]", with: circle.user.email
      fill_in "user[password]", with: circle.user.password

      click_button "Login"
      visit circle_path(circle)

      click_link "Delete"
      expect(page).to have_content("You've successfully deleted a circle!")

    end
  end
  scenario "not the author of circle tries to delete circle" do
    user2 = FactoryGirl.create(:user)
    visit new_user_session_path
    fill_in "user[email]", with: user2.email
    fill_in "user[password]", with: user2.password
    click_button "Login"

    visit circle_path(circle)
    click_link "Delete"
    expect(page).to have_content("You are not the owner of that circle!")
  end

  context "unauthenticated user" do
    scenario "user tries to delete circle when not signed in" do
      visit circle_path(circle)

      click_link "Delete"
      expect(page).to have_content("You need to sign in or sign up before continuing.")
    end
  end
end
