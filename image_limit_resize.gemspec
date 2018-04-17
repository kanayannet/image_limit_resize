
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "image_limit_resize/version"

Gem::Specification.new do |spec|
  spec.name          = "image_limit_resize"
  spec.version       = ImageLimitResize::VERSION
  spec.authors       = ["kanayannet"]
  spec.email         = ["kanayannet@gmail.com"]

  spec.summary       = %q{It is a library for shrinking the image to equal ratio.}
  spec.description   = %q{It is a library for shrinking the image to equal ratio. It depends on rmagick.}
  spec.homepage      = "https://github.com/kanayannet/image_limit_resize"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_runtime_dependency "rmagick"
end
