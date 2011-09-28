# -*- coding: UTF-8 -*-

#image magick limit resize author @kanayannet

class ImageLimitResize

	require "RMagick"

	def initialize(file = "")
		@img = Magick::Image.read(file).first
	end
	
	def set_limit(size = 0)
		#except number
		return self if(/^\d+$/!~size.to_s)
		@size = size
		return self
	end

	def resize(file = "")
		return false if(@size.to_i > 0)
		width = @img.columns
		height = @img.rows
		ret = limit_convert({:width => width,
				     :height => height})
		image = @img.resize(ret[:width],ret[:height])
		image.write(file)
		return true
	end
	
	private
	
	def limit_convert(refs = {})
		width = refs[:width]
		height = refs[:height]
		if @size < width
			height = ((@size.to_f / width.to_f) * height).to_i
			width = @size
		end
		if @size < height
			width = ((@size.to_f / height.to_f) * width).to_i
			height = @size
		end
		return {:width => width,:height => height}
	end
end
