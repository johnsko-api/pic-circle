require "rails_helper"

feature "User Submits a picture on a Circle", %q(
As the authenticated user
I want to post a picture
So that I can share my picture within the circle

Acceptance Criteria
[ ] Go to circles/[:id]
[ ] User submits a picture

) do

  let(:circle) { FactoryGirl.create(:circle) }
  context "authenticated user" do

    scenario "authenticated user submits a picture" do

      visit new_user_session_path
      fill_in "user[email]", with: circle.user.email
      fill_in "user[password]", with: circle.user.password

      click_button "Login"
      visit circle_path(circle)

      fill_in "Image", with: "http://wallfon.com/walls/cars/porsche-carrera-gt.jpg"
      click_button "Upload"
      expect(page).to have_css("img[src*='http://wallfon.com/walls/cars/porsche-carrera-gt.jpg']")
    end
  end

  context "unauthenticated user" do
    scenario "user tries to add a picture when not signed in" do
      visit circle_path(circle)

      fill_in "Image", with: "http://img2.wikia.nocookie.net/__cb20131213083222/pokemon/images/1/10/006Charizard_OS_anime.png"
      click_button "Upload"
      expect(page).to have_content("You need to sign in or sign up before continuing.")
    end
  end
end
