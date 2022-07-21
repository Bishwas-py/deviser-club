require 'rmagick'
include Magick

module ImageGen

  def self.word_wrap(line)
    return line if line.length <= 26
    line.gsub(/(.{1,26})(\s+|$)/, "\\1\n").strip
  end

  def self.og_create(my_text)
    background_image = Dir.glob('app/assets/og_assets/*').sample
    image = Magick::Image.read(background_image).first

    create = Magick::Draw.new
    position = 0

    create.annotate(image, 0, 0, 3, 0, word_wrap(my_text)) do
      self.font = 'ArialUnicode'
      self.pointsize = 75
      self.font_weight = BoldWeight
      self.fill = 'white'
      self.gravity = CenterGravity
    end

    file_name = my_text.dup
    file_name.downcase!
    file_name.strip!
    file_name.gsub!(/[^a-z0-9\s-]/, '') # Remove non-word characters
    file_name.gsub!(/\s+/, '-')         # Convert whitespaces to dashes
    file_name.gsub!(/-\z/, '')          # Remove trailing dashes
    file_name.gsub!(/-+/, '-')          # get rid of double-dashes

    image.write("app/assets/images/bg-img/#{file_name}.png")
    [File.open("app/assets/images/bg-img/#{file_name}.png"), "#{file_name}.png"]

  end
end