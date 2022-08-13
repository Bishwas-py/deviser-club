require 'rmagick'
include Magick
module ImageGenHelper
  def word_wrap(line)
    return line if line.length <= 25
    line.gsub(/(.{1,20})(\s+|$)/, "\\1\n").strip
  end

  def create_og_image(my_text)
    my_text = my_text.lines[0].truncate(38)
    background_image = Dir.glob('app/assets/og_assets/*').sample
    image = Magick::Image.read(background_image).first

    create = Magick::Draw.new
    position = 0

    create.annotate(image, 0, 0, 10, 0, word_wrap(my_text)) do
      self.font = 'ArialUnicode'
      self.pointsize = 75
      self.font_weight = BoldWeight
      self.fill = 'white'
      self.gravity = CenterGravity
    end

    file_name = my_text
    file_name.downcase!
    file_name.strip!
    file_name.gsub!(/[^a-z0-9\s-]/, '') # Remove non-word characters
    file_name.gsub!(/\s+/, '-')         # Convert whitespaces to dashes
    file_name.gsub!(/-\z/, '')          # Remove trailing dashes
    file_name.gsub!(/-+/, '-')          # get rid of double-dashes
    FileUtils.mkdir_p 'app/bg-img'

    image.write("app/bg-img/#{file_name}.png")
    image_file_io = File.open("app/bg-img/#{file_name}.png") # object
    image_data = [image_file_io, "#{file_name}.png"]
    File.delete(image_file_io)
    image_data
  end
end