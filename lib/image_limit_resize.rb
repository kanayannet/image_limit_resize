
require 'rmagick'

# image magick limit resize author @kanayannet
class ImageLimitResize
  def initialize(file: nil, buffer: nil)
    raise 'buffer and file is nil' if file.nil? && buffer.nil?
    raise "#{file} is not exist" if file.nil? == false && File.exist?(file) == false

    @img = Magick::Image.read(file).first if file.nil? == false && File.exist?(file)
    @img = Magick::Image.from_blob(buffer).shift if buffer.nil? == false
    @size = nil
  end
  attr_accessor :size

  def format
    @img.format
  end

  def resize(file)
    raise "size:#{@size} value is not Integer" unless @size.class == Integer
    raise "format:#{@img.format} can't allow" if /^jpeg$|^gif$|^png$/i !~ @img.format
    raise 'size 0 can\'not allow' if @size.to_i <= 0

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
