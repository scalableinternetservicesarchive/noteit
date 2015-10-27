require 'test_helper'


class UserTest < ActiveSupport::TestCase
    include Devise::TestHelpers
    def setup
      @user = User.new(name: "Example User", email: "user123@example123.com", password: "foobar12", password_confirmation: "foobar12")
      sign_in (:user)
    end

    test "should be valid" do
      assert @user.valid?
    end
    test "name should be present" do
      @user.name = "     "
      assert_not @user.valid?
    end

    test "email should be present" do
      @user.email = "     "
      assert_not @user.valid?
    end

    test "name should not be too long" do
      @user.name = "a" * 51
      assert_not @user.valid?
    end

    test "email should not be too long" do
      @user.email = "a" * 244 + "@example.com"
      assert_not @user.valid?
    end

    test "email validation should accept valid addresses" do
      valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
      valid_addresses.each do |valid_address|
        @user.email = valid_address
        assert @user.valid?, "#{valid_address.inspect} should be valid"
      end
    end

    test "email validation should reject invalid addresses" do
      invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
      invalid_addresses.each do |invalid_address|
        @user.email = invalid_address
        assert_not @user.valid?
      end
    end

    test "email addresses should be unique" do
      duplicate_user = @user.dup
      @user.save
      assert_not duplicate_user.valid?
    end

    test "confirmed? should return false for a user at this stage" do
      assert_not @user.confirmed?
    end

    test "associated notes should be destroyed" do
      @user.save
      @user.notes.create!(title: "Alpha Beta", content: "Lorem ipsum")
      assert_difference 'Micropost.count', -1 do
        @user.destroy
      end
    end

  end