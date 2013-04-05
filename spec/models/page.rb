class Page
  include Mongoid::Document
  include Mongoid::Slug

  field :title
  field :custom_slug
  # attr_accessor :custom_slug

  slug :title, :custom_slug do |doc|
    (doc.custom_slug.to_s.empty? ? doc.title : doc.custom_slug).to_url
  end

  validates :title, presence: true
  validates :slug , presence: true
end
