require 'rails_helper'

RSpec.describe "Games", type: :request do
  
  describe "GET /games" do
    it "記事全件取得" do
      # 記事リスト作成
      FactoryBot.create_list(:game, 10)

      get '/games'
      json = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(json['data'].length).to eq(20)
    end
  end

  describe "GET /games/id" do
    it '特定の記事を取得する' do
      # テスト記事を作成
      game = FactoryBot.create(:game, title: 'testTitle', score: 100)
  
      # 作成した記事を取得
      get "/games/#{game.id}"
      json = JSON.parse(response.body)
  
      expect(response.status).to eq(200)
      expect(json['data']['title']).to eq(game.title)
    end
  end

  describe 'POST /games' do
    it '新しい記事を作成する' do
      # テスト記事を作成
      game = FactoryBot.create(:game, title: 'firstTitle', score: 100)
      valid_params = { title: 'secondTitle', score: 100 }
  
      # 更にテスト記事を作成し、記事が増えているか
      expect {
        post '/games', params: { game: valid_params }
      }.to change(Game, :count).by(+1)
      expect(response.status).to eq(200)
    end
  end

  describe 'PUT /games/id' do
    it '記事の編集を行う' do
      # テスト記事を作成
      game = FactoryBot.create(:game, title: 'oldTitle', score: 100)
  
      # 記事を編集する
      put "/games/#{game.id}", params: { game: {title: 'newTitle'}  }
      json = JSON.parse(response.body)
  
      expect(response.status).to eq(200)
      expect(json['data']['title']).to eq('newTitle')
    end
  end

  describe 'DELETE /games/id' do
    it '記事の削除を行う' do
      # テスト記事を作成
      game = FactoryBot.create(:game, title: 'oldTitle', score: 100)

      # 記事を削除
      expect { delete "/games/#{game.id}" }.to change(Game, :count).by(-1)
      expect(response.status).to eq(204)
    end
  end
end
