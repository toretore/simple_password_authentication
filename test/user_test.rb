require File.join(File.dirname(__FILE__), 'test_helper')
require 'user'

load_schema

class UserTest < Test::Unit::TestCase

  def setup
    User.delete_all
    @user = User.create!(:username => "humbaba", :password => "password", :password_confirmation => "password", :name => "Humbaba")
  end

  def test_salt_should_be_generated_automatically
    assert_not_nil User.new.salt
  end

  def test_salt_should_be_regenerateable_by_force
    u = User.new
    salt = u.salt
    new_salt = u.salt!
    assert_not_equal salt, new_salt
    assert_equal u.salt, new_salt
  end

  def test_correct_password_should_return_true_if_salted_password_equals_stored_password
    assert @user.correct_password?("password")
    assert !@user.correct_password?("heinz")
  end

  def test_correct_password_should_compare_unhashed_password_when_not_saved
    u = User.new
    assert !u.correct_password?("foo")
    u.password = "bar"
    assert u.correct_password?("bar")
  end

  def test_should_hash_password_on_save
    u = User.new(:username => "enkidu", :password => "password", :password_confirmation => "password")
    assert_equal "password", u.password
    u.save!
    assert_not_equal "password", u.password
    assert_equal User.hash_password("password", u.salt), u.password
  end

  def test_authenticate_should_return_user_with_matching_username_and_salted_password
    assert_equal @user, User.authenticate("humbaba", "password")
    assert_nil User.authenticate("humbaba", "wordpass")
  end

end
