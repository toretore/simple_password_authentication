require File.join(File.dirname(__FILE__), 'test_helper')
require "user"

load_schema

class HorsesController < ApplicationController
  def rescue_action(e); raise e; end
end


class PasswordAuthenticatorTest < Test::Unit::TestCase

  def setup
    @controller = HorsesController.new
    @auth = SimpleAuthentication::PasswordAuthenticator.new(@controller)
    User.delete_all
    @user = User.create!(:username => "humbaba", :password => "password")
  end

  def test_authentication_should_be_possible_with_username_and_password_params
    @controller.params = {}
    assert !@auth.authentication_possible?
    @controller.params.update(:username => "foo", :password => "bar")
    assert @auth.authentication_possible?
  end

  def test_authenticate_should_return_user_when_successful
    @controller.params = {:username => "humbaba", :password => "password"}
    assert_equal @user, @auth.authenticate
    @controller.params = {:username => "humbaba", :password => "wordpass"}
    assert_nil @auth.authenticate
  end

end
