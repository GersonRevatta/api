class PagesController < ApplicationController
  require 'httparty'
  require 'nokogiri'
  require 'pry'
  def home
    pagina = HTTParty.get('https://madrid.craigslist.es/search/hhh?=0')
    @array_Pisos = []
    paginaNokogiri = Nokogiri::HTML(pagina)
    paginaNokogiri.css('.content').css('.rows').css('.hdrlnk').map do |a|
      name = a.text
      Product.create(name: name)
    end
    @products = Product.all
  end
end
