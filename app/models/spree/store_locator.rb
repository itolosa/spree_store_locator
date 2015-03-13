require 'geocoder'

class Spree::StoreLocator < ActiveRecord::Base
  validates :address1, :city, :country, :state, :zip, presence: true
  translates :name, :address1, :address2, :city, :state, :zip, :country,
    fallbacks_for_empty_translations: true
  include SpreeI18n::Translatable

  scope :state_ordered, -> { order('state ASC') }

  geocoded_by :full_street_address

  after_validation :geocode

  def full_street_address
    "#{address1}, #{address2}, #{city}, #{state} #{zip}, #{country}"
  end

end