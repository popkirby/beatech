# -*- coding: utf-8 -*-
class Contest2ndsController < ApplicationController
  def result
    @contest2nds = Contest2nd.all
    @contestdates = Contestdate.all
    @a_team = Contest2nd.find(:all, :conditions => {:team => 'A'})
    @b_team = Contest2nd.find(:all, :conditions => {:team => 'B'})
    @c_team = Contest2nd.find(:all, :conditions => {:team => 'C'})

    @a_total_score = 0
    @b_total_score = 0
    @c_total_score = 0

    @a_total_rate = 0
    @b_total_rate = 0
    @c_total_rate = 0

    @a_total_bp = 0
    @b_total_bp = 0
    @c_total_bp = 0

    # 合計計算
    @a_team.each_with_index do |a, i|
      total_score = a.a_score + a.b_score + a.c_score
      a["total_score"] = total_score
      @a_total_score += total_score

      total_bp = a.a_bp + a.b_bp + a.c_bp
      a["total_bp"] = total_bp
      @a_total_bp += total_bp

      a["a_rate"] = 0
      a["b_rate"] = 0
      a["c_rate"] = 0

      a["a_rate"] =
        a.a_score * 1000 / (@a_team[i].notes * 2) unless @a_team[i].notes == 0
      a["b_rate"] =
        a.b_score * 1000 / (@b_team[i].notes * 2) unless @b_team[i].notes == 0
      a["c_rate"] =
        a.c_score * 1000 / (@c_team[i].notes * 2) unless @c_team[i].notes == 0
      a["total_rate"] = a["a_rate"] + a["b_rate"] + a["c_rate"]
      @a_total_rate += a["total_rate"]

      a["a_rate"] = (a["a_rate"] / 10).to_s + '.' + (a["a_rate"] % 10).to_s
      a["b_rate"] = (a["b_rate"] / 10).to_s + '.' + (a["b_rate"] % 10).to_s
      a["c_rate"] = (a["c_rate"] / 10).to_s + '.' + (a["c_rate"] % 10).to_s
      a["total_rate"] =
        (a["total_rate"] / 10).to_s + '.' + (a["total_rate"] % 10).to_s
    end

    @b_team.each_with_index do |b, i|
      total_score = b.a_score + b.b_score + b.c_score
      b["total_score"] = total_score
      @b_total_score += total_score

      total_bp = b.a_bp + b.b_bp + b.c_bp
      b["total_bp"] = total_bp
      @b_total_bp += total_bp

      b["a_rate"] = 0
      b["b_rate"] = 0
      b["c_rate"] = 0

      b["a_rate"] =
        b.a_score * 1000 / (@a_team[i].notes * 2) unless @a_team[i].notes == 0
      b["b_rate"] =
        b.b_score * 1000 / (@b_team[i].notes * 2) unless @b_team[i].notes == 0
      b["c_rate"] =
        b.c_score * 1000 / (@c_team[i].notes * 2) unless @c_team[i].notes == 0
      b["total_rate"] = b["a_rate"] + b["b_rate"] + b["c_rate"]
      @b_total_rate += b["total_rate"]

      b["a_rate"] = (b["a_rate"] / 10).to_s + '.' + (b["a_rate"] % 10).to_s
      b["b_rate"] = (b["b_rate"] / 10).to_s + '.' + (b["b_rate"] % 10).to_s
      b["c_rate"] = (b["c_rate"] / 10).to_s + '.' + (b["c_rate"] % 10).to_s
      b["total_rate"] =
        (b["total_rate"] / 10).to_s + '.' + (b["total_rate"] % 10).to_s
    end

    @c_team.each_with_index do |c, i|
      total_score = c.a_score + c.b_score + c.c_score
      c["total_score"] = total_score
      @c_total_score += total_score

      total_bp = c.a_bp + c.b_bp + c.c_bp
      c["total_bp"] = total_bp
      @c_total_bp += total_bp

      c["a_rate"] = 0
      c["b_rate"] = 0
      c["c_rate"] = 0

      c["a_rate"] =
        c.a_score * 1000 / (@a_team[i].notes * 2) unless @a_team[i].notes == 0
      c["b_rate"] =
        c.b_score * 1000 / (@b_team[i].notes * 2) unless @b_team[i].notes == 0
      c["c_rate"] =
        c.c_score * 1000 / (@c_team[i].notes * 2) unless @c_team[i].notes == 0
      c["total_rate"] = c["a_rate"] + c["b_rate"] + c["c_rate"]
      @c_total_rate += c["total_rate"]

      c["a_rate"] = (c["a_rate"] / 10).to_s + '.' + (c["a_rate"] % 10).to_s
      c["b_rate"] = (c["b_rate"] / 10).to_s + '.' + (c["b_rate"] % 10).to_s
      c["c_rate"] = (c["c_rate"] / 10).to_s + '.' + (c["c_rate"] % 10).to_s
      c["total_rate"] =
        (c["total_rate"] / 10).to_s + '.' + (c["total_rate"] % 10).to_s
    end

    @a_total_rate = (@a_total_rate / 10).to_s + '.' + (@a_total_rate % 10).to_s
    @b_total_rate = (@b_total_rate / 10).to_s + '.' + (@b_total_rate % 10).to_s
    @c_total_rate = (@c_total_rate / 10).to_s + '.' + (@c_total_rate % 10).to_s

    @title = '第二回部内大会'
  end

  def tunesedit
    @order = params[:order]
    @tunes = Array.new
    @a_team = Contest2nd.find(:all,
      :conditions => {:team => 'A', :order => @order})
    @tunes[0] = @a_team[0]
    @b_team = Contest2nd.find(:all,
      :conditions => {:team => 'B', :order => @order})
    @tunes[1] = @b_team[0]
    @c_team = Contest2nd.find(:all,
      :conditions => {:team => 'C', :order => @order})
    @tunes[2] = @c_team[0]
  end

  def scoreedit
    @order = params[:order]
    @tunes = Array.new
    @a_team = Contest2nd.find(:all,
      :conditions => {:team => 'A', :order => @order})
    @tunes[0] = @a_team[0]
    @b_team = Contest2nd.find(:all,
      :conditions => {:team => 'B', :order => @order})
    @tunes[1] = @b_team[0]
    @c_team = Contest2nd.find(:all,
      :conditions => {:team => 'C', :order => @order})
    @tunes[2] = @c_team[0]
  end

  def tunesupdate
    @tunes = params[:tune]
    @tunes.each do |tune|
      data = tune[1]
      @order = data["order"]
      @team = data["team"]

      contests = Contest2nd.find(:all,
        :conditions => {:team => @team, :order => @order})
      contest = contests[0]
      contest.notes = data["notes"]
      contest.music = data["music"]
      contest.save
    end

    @page = Page.find_by_url('contest2nd')
    @page.touch
    redirect_to root_url + 'contest2nd', :notice => '曲名の編集に成功しました。'
  end

  def scoreupdate
    @tunes = params[:tune]
    @tunes.each do |tune|
      data = tune[1]
      @order = data["order"]
      @team = data["team"]

      contests = Contest2nd.find(:all,
        :conditions => {:team => @team, :order => @order})
      contest = contests[0]
      contest.a_score = data["a_score"] if data["a_score"].length > 0
      contest.a_bp = data["a_bp"] if data["a_bp"].length > 0
      contest.b_score = data["b_score"] if data["b_score"].length > 0
      contest.b_bp = data["b_bp"] if data["b_bp"].length > 0
      contest.c_score = data["c_score"] if data["c_score"].length > 0
      contest.c_bp = data["c_bp"] if data["c_bp"].length > 0
      contest.url = data["url"] if data["url"]
      contest.save
    end

    @page = Page.find_by_url('contest2nd')
    @page.touch
    redirect_to root_url + 'contest2nd', :notice => '対戦結果の編集に成功しました。'
  end

  def index
    @contest2nds = Contest2nd.all
    @title = 'データ編集'

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @contest2nds }
    end
  end

  def show
    @contest2nd = Contest2nd.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @contest2nd }
    end
  end

  def new
    @contest2nd = Contest2nd.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @contest2nd }
    end
  end

  def edit
    @contest2nd = Contest2nd.find(params[:id])
  end

  def create
    @contest2nd = Contest2nd.new(params[:contest2nd])

    respond_to do |format|
      if @contest2nd.save
        format.html { redirect_to @contest2nd,
          :notice => 'Contest2nd was successfully created.' }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @contest2nd = Contest2nd.find(params[:id])

    respond_to do |format|
      if @contest2nd.update_attributes(params[:contest2nd])
        format.html { redirect_to root_url + 'contest2nd',
          :notice => '対戦結果の編集に成功しました。' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @contest2nd.errors,
          :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @contest2nd = Contest2nd.find(params[:id])
    @contest2nd.destroy

    respond_to do |format|
      format.html { redirect_to contest2nds_url }
      format.json { head :no_content }
    end
  end
end
