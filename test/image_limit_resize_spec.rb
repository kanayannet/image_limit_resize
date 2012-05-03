#!/usr/local/bin/ruby
# -*- coding: UTF-8 -*-

require 'rspec'
require './lib/image_limit_resize.rb'

describe "ImageLimitResize test" do
	before do
		filename = 'sakura.jpg'
		orient_file = 'orient.jpg'
		error_file = 'test.txt'
		@obj_file = ImageLimitResize.new()
		@obj_file.set_file(filename)
		
		@obj_buffer = ImageLimitResize.new()
		@obj_buffer.set_buffer(File.read(filename))
		
		@obj_orient = ImageLimitResize.new()
		@obj_orient.set_buffer(File.read(orient_file))
		
		@obj_error = ImageLimitResize.new()
		@obj_error.set_file(error_file)
	end
	it "画像以外を弾くか?" do
		@obj_error.get_type.should == 'TXT'
		@obj_error.set_limit(90).resize("sakura_resize.jpg").should == false
	end
	it "画像の種類を取得する" do
		@obj_file.get_type.should == 'JPEG'
		@obj_buffer.get_type.should == 'JPEG'
		@obj_orient.get_type.should == 'JPEG'
	end
	it "limit 90px で resize できるか?" do
		@obj_file.set_limit(90).resize("sakura_resize.jpg").should == true
		#Rmagick を直接読んでサイズチェック
		img = Magick::Image.read("sakura_resize.jpg").first
		img.columns.should <= 90
		img.rows.should <= 90

		@obj_buffer.set_limit(90).resize("sakura_resize.jpg").should == true
		#Rmagick を直接読んでサイズチェック
		img = Magick::Image.read("sakura_resize.jpg").first
		img.columns.should <= 90
		img.rows.should <= 90
	end
	it "orientation の情報がある画像を回転してresizeしてorientation 情報削除できるか?" do
		@obj_orient.set_limit(90).resize("orient_resize.jpg").should == true
		#Rmagick を直接読んでサイズチェック
		img = Magick::Image.read("orient_resize.jpg").first
		img.columns.should <= 90
		img.rows.should <= 90
		img.orientation.to_s.should <= 'UndefinedOrientation=0'
	end
end
