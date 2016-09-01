require 'rails_helper'

RSpec.describe User, type: :model do
  subject {
    described_class.new(username: "foo",
                        email: "foo@example.com",
                        password: "foobar",
                        password_confirmation: "foobar")
  }

  it "is valid with a username and email" do
    expect(subject).to be_valid
  end

  it "is invalid without a username" do
    subject.username = nil
    expect(subject).to_not be_valid
  end

  it "is invalid without an email" do
    subject.email = nil
    expect(subject).to_not be_valid
  end

  it "is invalid with a duplicate username" do
    User.create(
      username: "foo",
      email: "fool@example.com",
      password: "foobar",
      password_confirmation: "foobar"
    )
    subject.save
    expect(subject).to_not be_valid
  end

  it "is invalid with a duplicate email" do
    User.create(
      username: "bar",
      email: "foo@example.com",
      password: "foobar",
      password_confirmation: "foobar"
    )
    subject.save
    expect(subject).to_not be_valid
  end

  it "is invalid with an invalid email" do
    subject.email = "foo"
    expect(subject).to_not be_valid
  end

  it "is invalid with a blank password" do
    subject.password = subject.password_confirmation = " "
    expect(subject).to_not be_valid
  end

  it "is invalid with a password below minimum length" do
    subject.password = subject.password_confirmation = "12345"
    expect(subject).to_not be_valid
  end
end
