class GamesController < ApplicationController

  # テーブル一覧をGET /games.json
  def index
    games = Game.all
    render json: { status: 'SUCCESS', data: games }
  end


  # 指定されたIDのインスタンスをGET /games/id.json
  def show
    game = Game.find(params[:id])
    render json: { status: 'SUCCESS', data: game }
  end


  # インスタンス作成してPOST
  def create
    game = Game.new(game_params)
    if game.save
      render json: { status: 'SUCCESS', data: game }
    else
      render json: { status: 'ERROR', data: game.errors }
    end
  end


  # PUTCH/PUT
  def update
    game = Game.find(params[:id])
    if game.update(game_params)
      render json: { status: 'SUCCESS', data: game }
    else
      render json: { status: 'ERROR', data: game.errors }
    end
  end


  # DELETE
  def destroy
    game = Game.find(params[:id])
    game.destroy
    head :no_content
  end


  # 以下はプライベート
  private

  def game_params
    params.require(:game).permit(:title, :score)
  end
  
end
