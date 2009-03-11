require File.join(File.dirname(__FILE__), 'test_helper')

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

  def test_password_should_be_hashed
    u = User.new(:password => "humbaba")
    assert_equal "humbaba", u.password
    assert_equal User.hash_password("humbaba", u.salt), u.hashed_password
    u.password = "ereshkigal"
    assert_equal "ereshkigal", u.password
    assert_equal User.hash_password("ereshkigal", u.salt), u.hashed_password
  end

  def test_password_should_be_available_in_plaintext_while_object_is_alive
    u = User.new(:password => "mordechai")
    assert_equal "mordechai", u.password
    u.password = "nibiru"
    assert_equal "nibiru", u.password
  end

  def test_password_should_be_gone_when_
  end

  def test_correct_password
    assert @user.correct_password?("password")
    assert !@user.correct_password?("heinz")
    u = User.new(:username => "enkidu")
    assert !u.correct_password?("foo")
    u.password = "bar"
    assert u.correct_password?("bar")
    u.save!
    assert u.correct_password?("bar")
  end

  def test_authenticate_should_return_user_with_matching_username_and_salted_password
    assert_equal @user, User.authenticate("humbaba", "password")
    assert_nil User.authenticate("humbaba", "wordpass")
  end

end
