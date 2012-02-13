require 'spec_helper'

describe "Users" do
  describe "GET /users" do
    
    before (:each) do
      @user = Factory.create(:user)
      post_via_redirect user_session_path, 'user[email]' => @user.email, 'user[password]' => "please"
    end
    
    it "works! (now write some real specs)" do
      get users_path
      response.status.should be(200)
    end
  end
end
