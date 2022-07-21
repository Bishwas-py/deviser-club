module QuickTweetsHelper
  include ImageGen
  def create_og_image text
    ImageGen.og_create(text)
  end

end
