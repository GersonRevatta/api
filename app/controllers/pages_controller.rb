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

  def landing
    @xml = File.read(Rails.root.join("public", "report_uuid.xml"))
    xml = Nokogiri::XML(@xml)
    @array = []
    body = xml.xpath("//s0:invoices")
    body.xpath("//s0:uuid").each do |e|
      @array.push(e.content)
    end
  end
end
