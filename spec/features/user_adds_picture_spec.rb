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
      expect(page).to have_selector("img src="http://images6.fanpop.com/image/photos/33000000/pikachu-pikachu-33005706-895-1000.png"")
    end
  end

  # context "unauthenticated user" do
  #   scenario "user tries to comment on circle when not signed in" do
  #     visit circle_path(circle)
  #
  #     fill_in "Chat away!", with: "This is so not cool"
  #     click_button "Submit"
  #     expect(page).to have_content("You need to sign in or sign up before continuing.")
  #   end
  # end
end
