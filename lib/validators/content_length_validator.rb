class ContentLengthValidator < ActiveModel::Validator
  def validate(record)
    minimum = options[:minimum]
    maximum = options[:maximum]
    if length_is_eligible(record.pure_text, minimum, maximum)
      record.errors.add :body, "should have text count more than #{minimum} and less than #{maximum}."
    end
    if word_count_is_less(record.pure_text)
      record.errors.add :body, "has less tha 6 word count. Write more than 6 words."
    end
  end

  private
  def length_is_eligible(pure_text, minimum, maximum)
    pure_text.length == 0
    pure_text.length >= minimum
    pure_text.length <= maximum
  end

  def word_count_is_less(pure_text)
    pure_text.split(' ').count <= 6
  end
end