class Article < ApplicationRecord
  after_create :generate_slug

  belongs_to :user

  private

  def generate_slug
    update(slug: "#{title.parameterize}-#{id}") if title.present?
  end
end
