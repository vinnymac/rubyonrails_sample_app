require 'spec_helper'

describe User do
  before { @user = User.new(  
    name:                   "Example User", 
    email:                  "user@example.com", 
    password:               "foobar", 
    password_confirmation:   "foobar" ) }

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:admin) }
  it { should respond_to(:microposts) }
  it { should respond_to(:feed) }

  it { should be_valid }

  describe "with admin attribute set to 'true'" do
    before do 
      @user.save!
      @user.toggle!(:admin)
    end

    it { should be_admin }
  end

  describe "remember token" do
    before { subject.save }
    its(:remember_token) { should_not be_blank }
  end

  describe "when name is not present" do
    before { subject.name = " " }
    it { should_not be_valid }
  end

  describe "when email is not present" do
    before { subject.email = " " }
    it {should_not be_valid }
  end

  describe "when name is too long" do
    before { subject.name = "a" * 51 }
    it {should_not be_valid }
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.foo@bar_baz.com foo@bar+baz.com foobar@baz  com]
      addresses.each do |invalid_address|
        subject.email = invalid_address
        expect(subject).not_to be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        subject.email = valid_address
        expect(subject).to be_valid
      end
    end
  end

  describe "when email address is already taken" do
    before do
      user_with_same_email = subject.dup
      user_with_same_email.email = subject.email.upcase
      user_with_same_email.save
    end

    it { should_not be_valid }
  end

  describe "email address with mixed case" do
    let(:mixed_case_email) { "Foo@ExAMPle.CoM" }

    it "should be saved as all lower-case" do
      subject.email = mixed_case_email
      subject.save
      expect(subject.reload.email).to eq mixed_case_email.downcase
    end
  end

  describe "when password is not present" do
    before do
      @user = User.new(name: "Example User", email: "user@example.com",
        password: " ", password_confirmation: " ")
    end
    it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
    before { subject.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end

  describe "with a password that's too short" do
    before { subject.password = subject.password_confirmation = "a" * 5 }
    it { should be_invalid }
  end

  describe "return value of authenticate method" do
    before { subject.save }
    let(:found_user) { User.find_by(email: subject.email) }

    describe "with valid password" do
      it { should eq found_user.authenticate(subject.password) }
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it { should_not eq user_for_invalid_password }
      specify { expect(user_for_invalid_password).to be_false }
    end
  end

  describe "micropost associations" do
    before { @user.save }
    let!(:older_micropost) do
      FactoryGirl.create(:micropost, user: @user, created_at: 1.day.ago)
    end
    let!(:newer_micropost) do
      FactoryGirl.create(:micropost, user: @user, created_at: 1.hour.ago)
    end

    it "should have the right microposts in the right order" do
      expect(@user.microposts.to_a).to eq [newer_micropost, older_micropost]
    end

    it "should destroy associated microposts" do
      microposts = @user.microposts.to_a
      @user.destroy
      expect(microposts).not_to be_empty
      microposts.each do |micropost|
        expect(Micropost.where(id: micropost.id)).to be_empty
      end
    end

    describe "status" do
      let(:unfollowed_post) do
        FactoryGirl.create(:micropost, user: FactoryGirl.create(:user))
      end

      its(:feed) { should include(newer_micropost) }
      its(:feed) { should include(older_micropost) }
      its(:feed) { should_not include(unfollowed_post) }
    end
  end
end