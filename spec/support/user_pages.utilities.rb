include ApplicationHelper

# Utilities for the User Pages

def valid_signup
  fill_in "Name",             with: "Example User"
  fill_in "Email",            with: "user@example.com"
  fill_in "Password",         with: "foobar"
  fill_in "Confirm Password", with: "foobar"
end

def valid_edit
  fill_in "Name",             with: new_name
  fill_in "Email",            with: new_email
  fill_in "Password",         with: user.password
  fill_in "Confirm Password", with: user.password
  click_button "Save changes"
end

def invalid_short_password
  fill_in "Name",             with: "name"
  fill_in "Email",            with: "user@example.com"
  fill_in "Password",         with: "foo"
  fill_in "Confirm Password", with: "foo"
  click_button submit
end

def invalid_email
  fill_in "Name",             with: "FooBar"
  fill_in "Email",            with: "example.com"
  fill_in "Password",         with: "FooBar"
  fill_in "Confirm Password", with: "FooBar"
  click_button submit
end

def blank_password
  fill_in "Name",             with: "FooBar"
  fill_in "Email",            with: "email@example.com"
  fill_in "Password",         with: ""
  fill_in "Confirm Password", with: ""
  click_button submit
end

def long_name
  fill_in "Name",             with: "foobarfoobarfoobarfoobarfoobarfoobarfoobarfoobarfoo"
  fill_in "Email",            with: "email@example.com"
  fill_in "Password",         with: "FooBar"
  fill_in "Confirm Password", with: "FooBar"
  click_button submit
end

def invalid_password_confirmation
  fill_in "Name",             with: "foobar"
  fill_in "Email",            with: "email@example.com"
  fill_in "Password",         with: "FooBar"
  fill_in "Confirm Password", with: "BarFoo"
  click_button submit
end