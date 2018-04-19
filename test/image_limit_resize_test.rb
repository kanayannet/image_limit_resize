
require 'minitest/autorun'
require './lib/image_limit_resize'

class ImageLimitResizeTest < Minitest::Test
  def setup
    file = './data/sakura.jpg'
    orient_file = './data/orient.jpg'
    @obj_file = ImageLimitResize::Base.new(file: file)
    @obj_buffer = ImageLimitResize::Base.new(buffer: File.read(file))
    @obj_orient = ImageLimitResize::Base.new(buffer: File.read(orient_file))
  end

  def test_not_image_file
    assert_raises do
      obj_error = ImageLimitResize.new(file: './data/test.txt')
      obj_error.size = 90
      obj_error.resize('./data/sakura_resize.jpg')
    end
  end

  def test_format
    assert_equal @obj_file.format, 'JPEG'
    assert_equal @obj_buffer.format, 'JPEG'
    assert_equal @obj_orient.format, 'JPEG'
  end

  def test_resize_file
    @obj_file.size = 90
    @obj_file.resize('./data/sakura_resize.jpg')
    # resized check by rmagick
    img = Magick::Image.read('./data/sakura_resize.jpg').first
    assert_equal img.columns <= 90, true
    assert_equal img.rows <= 90, true
  end

  def test_resize_buffer
    @obj_buffer.size = 90
    @obj_buffer.resize('./data/sakura_resize.jpg')
    # resized check by rmagick
    img = Magick::Image.read('./data/sakura_resize.jpg').first
    assert_equal img.columns <= 90, true
    assert_equal img.rows <= 90, true
  end

  def test_orientation
    @obj_orient.size = 90
    @obj_orient.resize('./data/orient_resize.jpg')
    # resized check by rmagick
    img = Magick::Image.read('./data/orient_resize.jpg').first
    assert_equal img.columns <= 90, true
    assert_equal img.rows <= 90, true
    assert_equal img.orientation.to_s, 'UndefinedOrientation'
  end
end
