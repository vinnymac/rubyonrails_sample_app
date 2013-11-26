require 'spec_helper'

describe "User Pages" do

	subject { page }

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it { should have_content(user.name) }
    it { should have_title(user.name) }
  end

  describe "signup page" do
    before { visit signup_path }

    it { should have_content('Sign up') }
    it { should have_title(full_title('Sign up')) }

    let(:submit) { "Create my account" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change( User, :count )
      end

      describe "after submission" do

        describe "password is too short" do
          before do
            fill_in "Name",         with: "name"
            fill_in "Email",        with: "user@example.com"
            fill_in "Password",     with: "foo"
            fill_in "Confirmation", with: "foo"
            click_button submit
          end
          it { should have_content('is too short') }

          it { should have_title('Sign up') }
          it { should have_content('error') }
        end

        describe "email is invalid" do
          before do
            fill_in "Name",         with: "FooBar"
            fill_in "Email",        with: "example.com"
            fill_in "Password",     with: "FooBar"
            fill_in "Confirmation", with: "FooBar"
            click_button submit
          end
          it { should have_content('Email is invalid') }

          it { should have_title('Sign up') }
          it { should have_content('error') }
        end

        describe "password can't be blank" do
          before do
            fill_in "Name",         with: "FooBar"
            fill_in "Email",        with: "email@example.com"
            fill_in "Password",     with: ""
            fill_in "Confirmation", with: ""
            click_button submit
          end
          it { should have_content("Password can't be blank") }

          it { should have_title('Sign up') }
          it { should have_content('error') }
        end

        describe "name is too long" do
          before do
            fill_in "Name",         with: "foobarfoobarfoobarfoobarfoobarfoobarfoobarfoobarfoo"
            fill_in "Email",        with: "email@example.com"
            fill_in "Password",     with: "FooBar"
            fill_in "Confirmation", with: "FooBar"
            click_button submit
          end
          it { should have_content('Name is too long (maximum is 50 characters)') }

          it { should have_title('Sign up') }
          it { should have_content('error') }
        end

        describe "password confirmation doesn't match" do
          before do
            fill_in "Name",         with: "foobar"
            fill_in "Email",        with: "email@example.com"
            fill_in "Password",     with: "FooBar"
            fill_in "Confirmation", with: "BarFoo"
            click_button submit
          end
          it { should have_content("Password confirmation doesn't match Password") }

          it { should have_title('Sign up') }
          it { should have_content('error') }
        end

      end
    end

    describe "with valid information" do
      before do
        fill_in "Name",         with: "Example User"
        fill_in "Email",        with: "user@example.com"
        fill_in "Password",     with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end
      
      it "should create a user" do
        expect { click_button submit }.to change( User, :count ).by(1)
      end

      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by(email: 'user@example.com') }

        it { should have_title(user.name) }
        it { should have_selector('div.alert.alert-success', text: 'Welcome') }
      end
    end
  end
end 
