include ApplicationHelper

# Utilities for the User Pages

def valid_signup
  fill_in "Name",         with: "Example User"
  fill_in "Email",        with: "user@example.com"
  fill_in "Password",     with: "foobar"
  fill_in "Confirmation", with: "foobar"
end

def invalid_short_password
  fill_in "Name",         with: "name"
  fill_in "Email",        with: "user@example.com"
  fill_in "Password",     with: "foo"
  fill_in "Confirmation", with: "foo"
  click_button submit
end

def invalid_email
  fill_in "Name",         with: "FooBar"
  fill_in "Email",        with: "example.com"
  fill_in "Password",     with: "FooBar"
  fill_in "Confirmation", with: "FooBar"
  click_button submit
end

def blank_password
  fill_in "Name",         with: "FooBar"
  fill_in "Email",        with: "email@example.com"
  fill_in "Password",     with: ""
  fill_in "Confirmation", with: ""
  click_button submit
end

def long_name
  fill_in "Name",         with: "foobarfoobarfoobarfoobarfoobarfoobarfoobarfoobarfoo"
  fill_in "Email",        with: "email@example.com"
  fill_in "Password",     with: "FooBar"
  fill_in "Confirmation", with: "FooBar"
  click_button submit
end

def invalid_password_confirmation
  fill_in "Name",         with: "foobar"
  fill_in "Email",        with: "email@example.com"
  fill_in "Password",     with: "FooBar"
  fill_in "Confirmation", with: "BarFoo"
  click_button submit
end