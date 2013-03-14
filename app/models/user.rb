# -*- coding: utf-8 -*-
class User < ActiveRecord::Base
  has_secure_password
  attr_accessible :account, :name, :password_digest, :profile, :repeat_year, :uid, :year, :password, :password_confirmation, :short_profile, :long_profile, :profile_image, :screen_name

  def self.grade(grade)
    this_year = Time.now.year    
    this_year -= 1 if Time.now.month < 4
    
    @users = self.where(year: this_year - grade + 1, repeat_year: 0)
    @users += self.where(year: this_year - grade, repeat_year: 1)
    @users
  end

  def self.ob
    this_year = Time.now.year    
    this_year -= 1 if Time.now.month < 4
    
    @all = self.all
    @users = Array.new
    @all.each do |user|
      if this_year + 1 - user.year > 4
        @users += user
      end
    end    
    @users
  end

  def self.authenticate(account, password)
    user = find_by_account(account, password)
    if user && user.password_digest.present? &&
        BCrypt::Password.new(user.password_digest) == password
      user
    else
      nil
    end
  end

  def self.name_by_account(account)
    user = self.find_by_account(account)
    if user.name
      user.name
    else
      account
    end
  end

  def self.profile_image_by_account(account)
    user = self.find_by_account(account)
    if user.profile_image
      if user.profile_image =~ /.*normal.*/        
        user.profile_image.gsub(/normal/, "bigger")
      else
        user.profile_image
      end
    else
      'https://si0.twimg.com/sticky/default_profile_images/default_profile_0_bigger.png'
    end
  end

  def self.short_profile_by_account(account)
    user = self.find_by_account(account)
    if user.short_profile
      user.short_profile
    else
      '未入力'
    end
  end
  
  def self.long_profile_by_account(account)
    user = self.find_by_account(account)
    if user.long_profile
      user.long_profile
    else
      '未入力'
    end
  end

  def self.screen_names_by_account(account)
    user = self.find_by_account(account)    
    if user.screen_name
      user.screen_name.split(" ")
    else
      nil
    end    
  end
end
