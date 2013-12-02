include ApplicationHelper

# Utilities for the Static Pages

def click_links
  visit root_path
  click_link "About"
  expect(page).to have_title(full_title('About Us'))
  click_link "Help"
  expect(page).to have_title(full_title('Help'))
  click_link "Contact"
  expect(page).to have_title(full_title('Contact'))
  click_link "Home"
  click_link "Sign up now!"
  expect(page).to have_title(full_title('Sign up'))
  click_link "sample app"
  expect(page).to have_title(full_title(''))
end