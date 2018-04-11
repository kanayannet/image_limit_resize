
require 'minitest/autorun'
require './lib/image_limit_resize.rb'

class ImageLimitResizeTest < Minitest::Test
  def setup
    file = './sakura.jpg'
    orient_file = './orient.jpg'
    @obj_file = ImageLimitResize.new(file: file)
    @obj_buffer = ImageLimitResize.new(buffer: File.read(file))
    @obj_orient = ImageLimitResize.new(buffer: File.read(orient_file))
  end

  def test_not_image_file
    assert_raises do
      obj_error = ImageLimitResize.new(file: './test.txt')
      obj_error.size = 90
      obj_error.resize('sakura_resize.jpg')
    end
  end

  def test_format
    assert_equal @obj_file.format, 'JPEG'
    assert_equal @obj_buffer.format, 'JPEG'
    assert_equal @obj_orient.format, 'JPEG'
  end

  def test_resize
    @obj_file.size = 90
    @obj_file.resize('sakura_resize.jpg')
    # リサイズ後 Rmagick を直接読んでサイズチェック
    img = Magick::Image.read('sakura_resize.jpg').first
    assert_equal img.columns <= 90, true
    assert_equal img.rows <= 90, true

    @obj_buffer.size = 90
    @obj_buffer.resize('sakura_resize.jpg')
    # リサイズ後 Rmagick を直接読んでサイズチェック
    img = Magick::Image.read('sakura_resize.jpg').first
    assert_equal img.columns <= 90, true
    assert_equal img.rows <= 90, true
  end

  def test_orientation
    @obj_orient.size = 90
    @obj_orient.resize('orient_resize.jpg')
    # リサイズ後 Rmagick を直接読んでサイズチェック
    img = Magick::Image.read('orient_resize.jpg').first
    assert_equal img.columns <= 90, true
    assert_equal img.rows <= 90, true
    assert_equal img.orientation.to_s, 'UndefinedOrientation'
  end
end
