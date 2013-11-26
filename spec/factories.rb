FactoryGirl.define do
  factory :user do
    name                    "Vincent Taverna"
    email                   "vinnymac@gmail.com"
    password                "tactic"
    password_confirmation   "tactic"
  end
end