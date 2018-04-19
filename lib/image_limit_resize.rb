
require 'rmagick'

module ImageLimitResize
  # image magick limit resize author @kanayannet
  class Base
    FORMAT_PATTERN = /^jpeg$|^gif$|^png$/i
    def initialize(file: nil, buffer: nil)
      @img = Magick::Image.read(file).first if !file.nil? && File.exist?(file)
      @img = Magick::Image.from_blob(buffer).shift unless buffer.nil?
      @size = nil
    end
    attr_accessor :size

    def format
      @img.format
    end

    def valid?
      raise 'buffer and file is nil' if @img.nil?
      raise "size:#{@size} value is not Integer" unless @size.is_a?(Integer)
      raise "#{@img.format} can't allow" if FORMAT_PATTERN !~ @img.format
      raise 'size 0 can\'not allow' if @size <= 0
    end

    def resize(file)
      valid?

      @img.auto_orient!
      @img.strip!

      width = @img.columns
      height = @img.rows
      size = width_height(width, height)
      image = @img.resize(size[:width], size[:height])

      image.write(file)
    end

    private

    def width_height(width, height)
      width, height = width_base_size(width, height)
      width, height = height_base_size(width, height)
      { width: width, height: height }
    end

    def width_base_size(width, height)
      if @size < width
        height = (@size.to_f / width.to_f * height).to_i
        width = @size
      end
      [width, height]
    end

    def height_base_size(width, height)
      if @size < height
        width = (@size.to_f / height.to_f * width).to_i
        height = @size
      end
      [width, height]
    end
  end
end
