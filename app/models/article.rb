class Article < ApplicationRecord
    include Visible
  
    has_many :comments, dependent: :destroy
    belongs_to :user 
    has_one_attached :image
    validates :title, presence: true
    validates :body, presence: true, length: { minimum: 10 }
    def archive_if_reports_exceeded
      if reports_count >= 3 && !archived?
        puts "Article #{id} reached : #{reports_count} reports, it will be archived."
        update(archived: true)
      end
    end
    def report
      increment!(:reports_count)
    end
  end
  