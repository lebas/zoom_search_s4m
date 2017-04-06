require "zoom_search_s4m/version"
require 'nokogiri'
require 'open-uri'
require 'pry'
require 'certified'

module ZoomSearchS4m
	class ZoomCom
    def initialize 
      @pn = nil
      @url_default = 'https://www.zoom.com.br/search?q=PARTNUMBER#produtos'
      @offers = []
    end

    def setPNSearch(partNumber = nil)
      unless partNumber.nil?
        @pn = partNumber.downcase
        url_page = @url_default.gsub('PARTNUMBER', @pn)
        begin
        	# page = Nokogiri::HTML(open("https://www.zoom.com.br/search?q=MN942#produtos"))
          page = Nokogiri::HTML(open(url_page))
          unless page.nil?
          	list =  page.css('li.item').css('div.item-content').css('div.image-container')[0]
          	list =  list.css('a')[0].attributes['href'].value unless list.nil?
          	link = "https://www.zoom.com.br#{list}" unless list.nil?
          	getPrice(link) unless link.nil?
          end
        rescue OpenURI::HTTPError
        end
      end 
    end

    def top5Offers
       @offers[1..5] if @offers.count > 4 
    end

    def AvgOffers
    	@offers.sum/@offers.size unless @offers.empty?
    end

    def getPrice(page = nil)
    	unless page.nil?
    		page_source = Nokogiri::HTML(open(page))
      	unless page_source.nil?
      		list = page_source.css('div.container')
      		list_price = []
      		list.each do |item|
      			info = item.css('div.price-shipping-lead')
      			unless info.nil?
      				price = info[0].children[1].css('div').children[0].css('span').children[2] unless info[0].children[1].css('div').children[0].css('span').nil? || info[0].children[1].css('div').children[0].nil? || info[0].children[1].css('div').nil? || info[0].children[1].nil? || info[0].nil?
      				list_price << "#{price.children[0].text}#{price.children[1].children[0].text}" unless price.nil?
      			end
      		end
      		@offers = list_price.map{ |x| current2int(x) } 
      	end
      end
     end

    private
      def current2int(money = nil)
        money.delete(" R$ ").gsub('.','').gsub(',','.').to_f if !money.nil? && money.class == String
      end
  end
end
