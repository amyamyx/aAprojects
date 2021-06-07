require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password_digest) }
    it { should validate_length_of(:password).is_at_least(6)}  
  end

  describe "associations" do
    it { should have_many(:notes) }
  end

  describe "auth methods" do
    let(:user) { User.find_by(email: "email@abc.com") }

    context "#is_password?" do
      # it "should call BCrypt::Password on password_digest" do
      #   user1 = User.find_by(email: "email@abc.com")
      #   expect(BCrypt::Password).to receive(:new).with(user1.password_digest)
      #   user1.is_password?("qweuiop")
      # end
    end

    context "#reset_token!" do
      it "should save the new token to the database" do
        expect(user).to receive(:save!)
        user.reset_token!
      end

      it "should return the new generated token" do
        old_token = user.session_token
        new_token = user.reset_token!
        expect(new_token).not_to eq(old_token)
      end
    end

    context "::find_by_credentials" do
      it "should return the user with right credentials" do
        found_user = User.find_by_credentials("email@abc.com", "asdfjkl")
        expect(found_user.id).to be(user.id)
      end

      it "should return nil if email is not in database" do
        non_existing_user = User.find_by_credentials("asdfjkei", "sdfuei")  
        expect(non_existing_user).to be(nil)
      end

      it "should return nil if password is incorrect" do
        wrong_pw = User.find_by_credentials("email@abc.com", "qweuiop")
        expect(wrong_pw).to be(nil)
      end
    end
  end
end
