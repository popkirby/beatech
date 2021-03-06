class AchievementsController < ApplicationController
  def title
    '成果報告'
  end

  def index
    @achievement = Achievement.new(user: @current_user)
    @achievements = Achievement.preload(:user).order(date: :desc).page(params[:page])
  end

  def create
    @achievement = Achievement.new(user_params)
    @achievement.user = @current_user

    if @achievement.save
      Entry.find_by(url: 'achievements').try(:touch)
      redirect_to achievements_path, notice: '成果報告を送信しました。'
    else
      render action: 'index'
    end
  end

  def edit
    @achievement = Achievement.find(params[:id])
  end

  def update
    @achievement = Achievement.find(params[:achievement][:id])
    @achievement.text = params[:achievement][:text]
    year = params[:achievement]['date(1i)'].to_i
    month = params[:achievement]['date(2i)'].to_i
    day = params[:achievement]['date(3i)'].to_i
    @achievement.date = Date.new(year, month, day)
    @achievement.save

    redirect_to achievements_path
  end

  def destroy
    @achievement = Achievement.find(params[:id])
    @achievement.destroy

    redirect_to :back
  end

  private

  def user_params
    params.require(:achievement).permit(:date, :text)
  end
end
