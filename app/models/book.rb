class Book < ApplicationRecord
  replicated_model
  mount_uploader :cover_image, CoverImageUploader
  belongs_to :category
  acts_as_list scope: :category
  has_many :reviews, dependent: :destroy
  # before_save :set_cover_image
  def img_cat
    ["nightlife", "city", "people", "transport", "business"].sample
  end

  def is_best_seller?
    position < 11
  end

  def set_cover_image
    if self.cover_image.blank?
      thumb_url = BingSearch.get_image_url(self.title)[:thumbnail_url]
      self.remote_cover_image_url = thumb_url
    end
  end
end
