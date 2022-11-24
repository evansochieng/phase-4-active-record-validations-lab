class Post < ApplicationRecord
    
    #validations
    validates :title, presence: true
    validates :content, length: {minimum: 250}
    validates :summary, length: {maximum: 250}
    validates :category, inclusion: {in: ["Fiction", "Non-Fiction"]}

    #custom validation method
    validate :clickbait_y_title

    #wont work coz 'Top ...' have any number
    #clickbait_y_pattern = ["Won't Believe", "Secret", "Top ", "Guess"]

    # Define the pattern as a constant global variable (capital letters)
    CLICKBAIT_Y_PATTERN = [/Won't Believe/i, /Secret/i, /Top \d/i, /Guess/i]

    def clickbait_y_title
      if CLICKBAIT_Y_PATTERN.none? { |term| term.match title }
        errors.add(:title, "must be clickbait")
      end
    end
end
