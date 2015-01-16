require "rails_helper"

feature "User deletes their picture on a Circle", %q(
As the authenticated user
I want to delete a picture I put up
So that I can remove my picture within the circle

Acceptance Criteria
[ ] Go to circles/[:id]
[ ] User deletes their pictures

) do

  let(:circle) { FactoryGirl.create(:circle) }
  context "authenticated user" do

    scenario "authenticated user submits a picture" do

      visit new_user_session_path
      fill_in "user[email]", with: circle.user.email
      fill_in "user[password]", with: circle.user.password

      click_button "Login"
      visit circle_path(circle)

      fill_in "Image from Internet", with: "http://wallfon.com/walls/cars/porsche-carrera-gt.jpg"
      click_button "Upload"
      expect(page).to have_css("img[src*='http://wallfon.com/walls/cars/porsche-carrera-gt.jpg']")

      click_link "Delete Picture"
      expect(page).to have_content("You've successfully deleted your picture!")
    end
  end
end
