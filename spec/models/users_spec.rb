require 'rails_helper'

RSpec.describe "Users API", type: :request do
  describe "POST /api/users" do
    it "ユーザー登録のテスト" do
      post "/api/users", params: { user:{ "username": "Example User", "email": "test@exmple.com", "password": "password" } }
    end
  end
end