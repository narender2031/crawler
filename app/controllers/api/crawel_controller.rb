class Api::CrawelController < Api::ApiController
    before_action :authenticate
    def index
        require "open-uri"
        require "nokogiri"
        require "json"
        params[:url]
        if params[:url].blank?
            render json:{message: "Missing"}
        else
            puts params[:url]
            url = params[:url]
            document = open(url)
            doc = Nokogiri::HTML(document)
            content = doc
            data  = content.css('body').css('.a-aui_107069-c').css('div').css('#a-page').css('div').css('.a-fixed-left-flipped-grid').css('div').css('.a-fixed-left-grid-inner').css('div').css('.a-col-right').css('div').css('#container').css('div').css('#search-results').css('div').css('#mainResults').css('ul').css('.s-result-list').css('li').length
            limit = content.css('body').css('div').css('#a-page').css('div').css('#search-main-wrapper').css('div').css('#searchTemplate').css('div').css('#rightContainerATF').css('div').css('#rightResultsATF').css('div').css('#resultsCol').css('div').css('#centerMinus').css('div').css('#atfResults').css('ul').css('#s-results-list-atf').css('li').length
            puts data
            puts limit
            @array = Array.new
            if data != 0
                (0...data).each do |index|
                    length =   content.css('body').css('.a-aui_107069-c').css('div').css('#a-page').css('div').css('.a-fixed-left-flipped-grid').css('div').css('.a-fixed-left-grid-inner').css('div').css('.a-col-right').css('div').css('#container').css('div').css('#search-results').css('div').css('#mainResults').css('ul').css('.s-result-list').css('li')[index].css('div').css('.s-item-container').css('div').css('.a-spacing-base').css('div').css('.a-text-left').css('div').css('.a-spacing-none').length
                    if length == 0 
                    else
                        full_details_product =  content.css('body').css('.a-aui_107069-c').css('div').css('#a-page').css('div').css('.a-fixed-left-flipped-grid').css('div').css('.a-fixed-left-grid-inner').css('div').css('.a-col-right').css('div').css('#container').css('div').css('#search-results').css('div').css('#mainResults').css('ul').css('.s-result-list').css('li')[index].css('div').css('.s-item-container').css('div').css('.a-spacing-base').css('div').css('.a-text-left').css('div').css('.a-spacing-none')[0].css('a').attribute('href')
                        product_image =   content.css('body').css('.a-aui_107069-c').css('div').css('#a-page').css('div').css('.a-fixed-left-flipped-grid').css('div').css('.a-fixed-left-grid-inner').css('div').css('.a-col-right').css('div').css('#container').css('div').css('#search-results').css('div').css('#mainResults').css('ul').css('.s-result-list').css('li')[index].css('div').css('.s-item-container').css('div').css('.a-spacing-base').css('div').css('.a-text-left').css('div').css('.a-spacing-none')[0].css('a').css('img').attribute('src')
                        product_name =   content.css('body').css('.a-aui_107069-c').css('div').css('#a-page').css('div').css('.a-fixed-left-flipped-grid').css('div').css('.a-fixed-left-grid-inner').css('div').css('.a-col-right').css('div').css('#container').css('div').css('#search-results').css('div').css('#mainResults').css('ul').css('.s-result-list').css('li')[index].css('div').css('.s-item-container').css('div').css('.a-spacing-mini')[0].css('div').css('.a-spacing-none').css('a').css('.s-access-detail-page').css('h2').text
                        product_price =   content.css('body').css('.a-aui_107069-c').css('div').css('#a-page').css('div').css('.a-fixed-left-flipped-grid').css('div').css('.a-fixed-left-grid-inner').css('div').css('.a-col-right').css('div').css('#container').css('div').css('#search-results').css('div').css('#mainResults').css('ul').css('.s-result-list').css('li')[index].css('div').css('.s-item-container').css('div').css('.a-spacing-mini')[1].css('div').css('.a-spacing-none')[0].css('a').css('span').css('.a-price').css('span').css('span').css('.a-price-whole').text
                        product_original_price =   content.css('body').css('.a-aui_107069-c').css('div').css('#a-page').css('div').css('.a-fixed-left-flipped-grid').css('div').css('.a-fixed-left-grid-inner').css('div').css('.a-col-right').css('div').css('#container').css('div').css('#search-results').css('div').css('#mainResults').css('ul').css('.s-result-list').css('li')[index].css('div').css('.s-item-container').css('div').css('.a-spacing-mini')[1].css('div').css('.a-spacing-none')[0].css('span').css('.a-size-base-plus').css('span').text
                        product_type =   content.css('body').css('.a-aui_107069-c').css('div').css('#a-page').css('div').css('.a-fixed-left-flipped-grid').css('div').css('.a-fixed-left-grid-inner').css('div').css('.a-col-right').css('div').css('#container').css('div').css('#search-results').css('div').css('#mainResults').css('ul').css('.s-result-list').css('li')[index].css('div').css('.s-item-container').css('div').css('.a-spacing-mini')[1].css('div').css('.a-spacing-none').css('i').css('.a-icon').css('span').text
                        product_rating = content.css('body').css('.a-aui_107069-c').css('div').css('#a-page').css('div').css('.a-fixed-left-flipped-grid').css('div').css('.a-fixed-left-grid-inner').css('div').css('.a-col-right').css('div').css('#container').css('div').css('#search-results').css('div').css('#mainResults').css('ul').css('.s-result-list').css('li')[index].css('div').css('.s-item-container').css('div').css('.a-spacing-none').css('span').css('span').css('.a-declarative').css('a').css('i').css('.a-icon-star').css('span').text
                        product = current_user.crawled_data.new(full_details_product_url: full_details_product, product_name: product_name, product_image: product_image, product_price: product_price, product_original_price: product_original_price, product_type: product_type, product_rating: product_rating)
                        product.save
                        puts product
                        @array.push << product
                        puts full_details_product
                    end
                    #   puts  content.css('body').css('.a-aui_107069-c').css('div').css('#a-page').css('div').css('.a-fixed-left-flipped-grid').css('div').css('.a-fixed-left-grid-inner').css('div').css('.a-col-right').css('div').css('#container').css('div').css('#search-results').css('div').css('#mainResults').css('ul').css('.s-result-list').css('li')[index].css('div').css('.s-item-container').css('div').css('.a-spacing-base').css('div').css('.a-text-left').css('div').css('.a-spacing-none').css('a').css('img').attribute('src')
                end

                render json:{message: @array  }  
            elsif limit != 0

                
                puts limit
                (0...limit).each do |index|
                    length =  content.css('body').css('div').css('#a-page').css('div').css('#search-main-wrapper').css('div').css('#searchTemplate').css('div').css('#rightContainerATF').css('div').css('#rightResultsATF').css('div').css('#resultsCol').css('div').css('#centerMinus').css('div').css('#atfResults').css('ul').css('#s-results-list-atf').css('li')[index].css('div').css('.s-item-container').css('div').css('.a-spacing-base').css('div').css('.a-text-left').css('div').css('.a-spacing-none').length
                    if length == 0
                    else
                        full_details_product =  content.css('body').css('div').css('#a-page').css('div').css('#search-main-wrapper').css('div').css('#searchTemplate').css('div').css('#rightContainerATF').css('div').css('#rightResultsATF').css('div').css('#resultsCol').css('div').css('#centerMinus').css('div').css('#atfResults').css('ul').css('#s-results-list-atf').css('li')[index].css('div').css('.s-item-container').css('div').css('.a-spacing-base').css('div').css('.a-text-left').css('div').css('.a-spacing-none')[0].css('a').attribute('href')
                        product_image =  content.css('body').css('div').css('#a-page').css('div').css('#search-main-wrapper').css('div').css('#searchTemplate').css('div').css('#rightContainerATF').css('div').css('#rightResultsATF').css('div').css('#resultsCol').css('div').css('#centerMinus').css('div').css('#atfResults').css('ul').css('#s-results-list-atf').css('li')[index].css('div').css('.s-item-container').css('div').css('.a-spacing-base').css('div').css('.a-text-left').css('div').css('.a-spacing-none')[0].css('a').css('img').attribute('src')
                        
                        product_name =  content.css('body').css('div').css('#a-page').css('div').css('#search-main-wrapper').css('div').css('#searchTemplate').css('div').css('#rightContainerATF').css('div').css('#rightResultsATF').css('div').css('#resultsCol').css('div').css('#centerMinus').css('div').css('#atfResults').css('ul').css('#s-results-list-atf').css('li')[index].css('div').css('.s-item-container').css('div').css('.a-spacing-mini')[0].css('div').css('.a-spacing-none').css('a').css('.s-access-detail-page').css('h2').text
                        product_price =  content.css('body').css('div').css('#a-page').css('div').css('#search-main-wrapper').css('div').css('#searchTemplate').css('div').css('#rightContainerATF').css('div').css('#rightResultsATF').css('div').css('#resultsCol').css('div').css('#centerMinus').css('div').css('#atfResults').css('ul').css('#s-results-list-atf').css('li')[index].css('div').css('.s-item-container').css('div').css('.a-spacing-mini')[1].css('div').css('.a-spacing-none')[0].css('a').css('span').css('.a-price').css('span').css('span').css('.a-price-whole').text
                        product_original_price =  content.css('body').css('div').css('#a-page').css('div').css('#search-main-wrapper').css('div').css('#searchTemplate').css('div').css('#rightContainerATF').css('div').css('#rightResultsATF').css('div').css('#resultsCol').css('div').css('#centerMinus').css('div').css('#atfResults').css('ul').css('#s-results-list-atf').css('li')[index].css('div').css('.s-item-container').css('div').css('.a-spacing-mini')[1].css('div').css('.a-spacing-none')[0].css('span').css('.a-size-base-plus').css('span').text
                        #issue puts content.css('body').css('div').css('#a-page').css('div').css('#search-main-wrapper').css('div').css('#searchTemplate').css('div').css('#rightContainerATF').css('div').css('#rightResultsATF').css('div').css('#resultsCol').css('div').css('#centerMinus').css('div').css('#atfResults').css('ul').css('#s-results-list-atf').css('li')[index].css('div').css('.s-item-container').css('div').css('.a-spacing-mini')[1].css('div').css('.a-spacing-none')[1]
                        product_type =  content.css('body').css('div').css('#a-page').css('div').css('#search-main-wrapper').css('div').css('#searchTemplate').css('div').css('#rightContainerATF').css('div').css('#rightResultsATF').css('div').css('#resultsCol').css('div').css('#centerMinus').css('div').css('#atfResults').css('ul').css('#s-results-list-atf').css('li')[index].css('div').css('.s-item-container').css('div').css('.a-spacing-mini')[1].css('div').css('.a-spacing-none').css('i').css('.a-icon').css('span').text
                        product_rating  = content.css('body').css('div').css('#a-page').css('div').css('#search-main-wrapper').css('div').css('#searchTemplate').css('div').css('#rightContainerATF').css('div').css('#rightResultsATF').css('div').css('#resultsCol').css('div').css('#centerMinus').css('div').css('#atfResults').css('ul').css('#s-results-list-atf').css('li')[index].css('div').css('.s-item-container').css('div').css('.a-spacing-none').css('span').css('span').css('.a-declarative').css('a').css('i').css('.a-icon-star').css('span').text
                        product = current_user.crawled_data.new(full_details_product_url: full_details_product, product_name: product_name, product_image: product_image, product_price: product_price, product_original_price: product_original_price, product_type: product_type, product_rating: product_rating)
                        product.save
                        @array.push << product
                        puts product
                    end
                    
                end
                render json:{message: @array  }  
            else
                render json: {message: "error"}
            end 
            
        end    

    end           
end