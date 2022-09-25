class RehabVideo < ApplicationRecord
  has_one_attached :video do |attachable|
    attachable.variant :thumb, resize_to_limit: [64, 64]
    # attachable.variant :medium_thumb, resize_to_limit: [128, 128]
    # attachable.variant :large_thumb, resize_to_limit: [256, 256]
  end

  enum category: { exercise: 0, education: 1, recipe: 3 }

  validates_presence_of :category, :title
end