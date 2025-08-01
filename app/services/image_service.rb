class ImageService
  require 'net/http'
  require 'json'
  
  # 免费的Pixabay API (需要注册获取API key)
  PIXABAY_API_KEY = ENV['PIXABAY_API_KEY'] || 'demo-key' # 在实际使用时需要真实的API key
  PIXABAY_URL = 'https://pixabay.com/api/'
  
  # Unsplash Access Key (需要注册获取)
  UNSPLASH_ACCESS_KEY = ENV['UNSPLASH_ACCESS_KEY'] || 'demo-key'
  UNSPLASH_URL = 'https://api.unsplash.com/search/photos'
  
  # 免费图片URL (无需API key的预设图片)
  DEFAULT_TOOL_IMAGES = [
    'https://images.unsplash.com/photo-1572981779307-38b8cabb2407?w=400', # drill
    'https://images.unsplash.com/photo-1581244277943-fe4a9c777189?w=400', # tools
    'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=400', # hammer
    'https://images.unsplash.com/photo-1609205387707-91e3ca6c6b50?w=400', # wrench
    'https://images.unsplash.com/photo-1609205387660-3f035e5f2474?w=400', # screwdriver
    'https://images.unsplash.com/photo-1572981779307-38b8cabb2407?w=400', # power tools
    'https://images.unsplash.com/photo-1609205387470-ee30b21faed1?w=400', # saw
    'https://images.unsplash.com/photo-1609205387644-86ecaf1c2d50?w=400', # pliers
    'https://images.unsplash.com/photo-1609205387707-91e3ca6c6b50?w=400', # toolkit
    'https://images.unsplash.com/photo-1581244277943-fe4a9c777189?w=400'  # workshop
  ].freeze
  
  def self.search_tool_images(query, count = 1)
    # 尝试从Pixabay获取图片
    images = fetch_from_pixabay(query, count)
    
    # 如果Pixabay失败，使用默认图片
    if images.empty?
      images = get_default_images(count)
    end
    
    images
  end
  
  def self.get_tool_image_for_category(category_name)
    category_keywords = {
      'Power Tools' => 'power drill electric tool',
      'Hand Tools' => 'hammer wrench hand tool',
      'Accessories' => 'tool accessories bits'
    }
    
    keyword = category_keywords[category_name] || 'tools equipment'
    search_tool_images(keyword, 1).first
  end
  
  def self.get_random_tool_image
    DEFAULT_TOOL_IMAGES.sample
  end
  
  private
  
  def self.fetch_from_pixabay(query, count)
    return [] if PIXABAY_API_KEY == 'demo-key'
    
    begin
      uri = URI(PIXABAY_URL)
      params = {
        key: PIXABAY_API_KEY,
        q: query,
        image_type: 'photo',
        category: 'industry',
        per_page: count,
        safesearch: 'true'
      }
      uri.query = URI.encode_www_form(params)
      
      response = Net::HTTP.get_response(uri)
      
      if response.code == '200'
        data = JSON.parse(response.body)
        images = data['hits'].map do |hit|
          hit['webformatURL']
        end
        return images
      end
    rescue => e
      Rails.logger.error "Failed to fetch from Pixabay: #{e.message}"
    end
    
    []
  end
  
  def self.get_default_images(count)
    DEFAULT_TOOL_IMAGES.sample(count)
  end
end
