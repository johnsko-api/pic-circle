require "rails_helper"

feature "User Creates a Circle", %q(
As an authenticated user
I want to create a circle
So that I can share my pictures within my circle

Acceptance Criteria
[ ] Go to circles/new to fill out form
[ ] User must enter title
[ ] User must enter description
[ ] User can make circle private/public

) do

  context "authenticated user" do
    let(:user){ FactoryGirl.create(:user) }

    before(:each) do
      visit new_user_session_path
      fill_in "user[email]", with: user.email
      fill_in "user[password]", with: user.password
      click_button "Login"
    end

    scenario "user successfully creates a circle and reads circle from root_path" do

      visit new_circle_path
      fill_in "Group Name", with: "Descriptive Title"
      fill_in "Description", with: "this circle is very descriptive"

      click_button "Create Circle"
      expect(page).to have_content("You've successfully created a circle!")
      expect(page).to have_content("Descriptive Title")
      expect(page).to have_content("this circle is very descriptive")

      visit root_path
      expect(page).to have_content("Descriptive Title")
    end
  end

  context "unauthenticated user" do
    scenario "user tries to create a circle when not signed in" do
      visit new_circle_path
      expect(page).to have_content("You need to sign in or sign up before continuing.")
    end
  end
end
