#!/usr/local/bin/ruby
# -*- coding: UTF-8 -*-

require 'rspec'
require './lib/image_limit_resize.rb'

describe "ImageLimitResize test" do
	before do
		filename = 'sakura.jpg'
		error_file = 'test.txt'
		@obj = ImageLimitResize.new(filename)
		@obj_error = ImageLimitResize.new(error_file)
	end
	it "画像以外を弾くか?" do
		@obj_error.set_limit(90).resize("sakura_resize.jpg").should == false
	end
	
	it "limit 90px で resize できるか?" do
		@obj.set_limit(90).resize("sakura_resize.jpg").should == true

		#Rmagick を直接読んでサイズチェック
		img = Magick::Image.read("sakura_resize.jpg").first
		img.columns.should <= 90
		img.rows.should <= 90
	end
end
