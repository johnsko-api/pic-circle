require "rails_helper"

feature "User Edits a Circle", %q(
As the authenticated user that created the circle
I want to edit the circle
So that I can share my update within my circle

Acceptance Criteria
[ ] Go to circles/edit to fill out form
[ ] User can update title
[ ] User can update description

) do

  let(:circle) { FactoryGirl.create(:circle) }
  context "authenticated user" do

    scenario "author of circle successfully edits circle" do

      visit new_user_session_path
      fill_in "user[email]", with: circle.user.email
      fill_in "user[password]", with: circle.user.password

      click_button "Log in"
      visit circle_path(circle)

      click_link "Edit"
      fill_in "Title", with: "New Better Title"
      fill_in "Description", with: "New Better Description"

      click_button "Update Circle"
      expect(page).to have_content("You've successfully updated a circle!")

    end
  end

  scenario "not the author of circle tries to edit circle" do
    user2 = FactoryGirl.create(:user)
    visit new_user_session_path
    fill_in "user[email]", with: user2.email
    fill_in "user[password]", with: user2.password
    click_button "Log in"
    
    expect { visit edit_circle_path(circle) }.to raise_error(ActiveRecord::RecordNotFound)

  end

  context "unauthenticated user" do
    scenario "user tries to edit circle when not signed in" do
      visit circle_path(circle)

      visit edit_circle_path(circle)
      expect(page).to have_content("You need to sign in or sign up before continuing.")
    end
  end
end
