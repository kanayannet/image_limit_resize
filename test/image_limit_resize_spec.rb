#!/usr/local/bin/ruby
# -*- coding: UTF-8 -*-

require 'rspec'
require './lib/image_limit_resize.rb'

describe "ImageLimitResize test" do
	before do
		filename = 'sakura.jpg'
		@obj = ImageLimitResize.new(filename)
	end
	it "limit 90px で resize できるか?" do
		@obj.set_limit(90).resize("sakura_resize.jpg").should == true

		#Rmagick を直接読んでサイズチェック
		img = Magick::Image.read("sakura_resize.jpg").first
		img.columns.should <= 90
		img.rows.should <= 90
	end
end
