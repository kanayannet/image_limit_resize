# -*- coding: UTF-8 -*-

#image magick limit resize author @kanayannet

class ImageLimitResize

	require "RMagick"

	def initialize()
		@is_error = false
	end
	
	def set_file(file = "")
		begin
			@img = Magick::Image.read(file).first
		rescue
			@is_error = true
		end
		return self
	end

	def set_buffer(buffer)
		begin
			@img = Magick::Image.from_blob(buffer).shift
		rescue
			@is_error = true
		end
		return self
	end
	
	def get_type()
		return false if(@is_error == true)
		return @img.format
	end
	
	def set_limit(size = 0)
		#except number
		return self if(/^\d+$/!~size.to_s)
		@size = size
		return self
	end

	def resize(file = "")
		return false if(@is_error == true)
		return false if(/^jpeg$|^gif$|^png$/i !~@img.format)
		return false if(@size.to_i <= 0)
		@img.auto_orient!
		@img.strip!
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
