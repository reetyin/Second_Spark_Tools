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
    'https://images.unsplash.com/photo-1572981779307-38b8cabb2407?w=800&h=400&fit=crop', # drill
    'https://images.unsplash.com/photo-1581244277943-fe4a9c777189?w=800&h=400&fit=crop', # tools
    'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=800&h=400&fit=crop', # hammer
    'https://images.unsplash.com/photo-1609205387707-91e3ca6c6b50?w=800&h=400&fit=crop', # wrench
    'https://images.unsplash.com/photo-1609205387660-3f035e5f2474?w=800&h=400&fit=crop', # screwdriver
    'https://images.unsplash.com/photo-1572981779307-38b8cabb2407?w=800&h=400&fit=crop', # power tools
    'https://images.unsplash.com/photo-1609205387470-ee30b21faed1?w=800&h=400&fit=crop', # saw
    'https://images.unsplash.com/photo-1609205387644-86ecaf1c2d50?w=800&h=400&fit=crop', # pliers
    'https://images.unsplash.com/photo-1609205387707-91e3ca6c6b50?w=800&h=400&fit=crop', # toolkit
    'https://images.unsplash.com/photo-1581244277943-fe4a9c777189?w=800&h=400&fit=crop',  # workshop
    'https://images.unsplash.com/photo-1504328345606-18bbc8c9d7d1?w=800&h=400&fit=crop', # workshop tools
    'https://images.unsplash.com/photo-1609205387515-d7a63827fe65?w=800&h=400&fit=crop', # tool collection
    'https://images.unsplash.com/photo-1613040809024-b4ef7ba99bc3?w=800&h=400&fit=crop', # garage tools
    'https://images.unsplash.com/photo-1609205387493-c8b62bfe8248?w=800&h=400&fit=crop', # hand tools
    'https://images.unsplash.com/photo-1609205387420-e8b0fa3e8af2?w=800&h=400&fit=crop'  # tool box
  ].freeze
  
  # 分类专用图片
  CATEGORY_IMAGES = {
    'Power Tools' => [
      'https://images.unsplash.com/photo-1572981779307-38b8cabb2407?w=400&h=300&fit=crop',
      'https://images.unsplash.com/photo-1609205387470-ee30b21faed1?w=400&h=300&fit=crop',
      'https://images.unsplash.com/photo-1504328345606-18bbc8c9d7d1?w=400&h=300&fit=crop'
    ],
    'Hand Tools' => [
      'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=400&h=300&fit=crop',
      'https://images.unsplash.com/photo-1609205387707-91e3ca6c6b50?w=400&h=300&fit=crop',
      'https://images.unsplash.com/photo-1609205387644-86ecaf1c2d50?w=400&h=300&fit=crop'
    ],
    'Accessories' => [
      'https://images.unsplash.com/photo-1609205387420-e8b0fa3e8af2?w=400&h=300&fit=crop',
      'https://images.unsplash.com/photo-1609205387515-d7a63827fe65?w=400&h=300&fit=crop',
      'https://images.unsplash.com/photo-1581244277943-fe4a9c777189?w=400&h=300&fit=crop'
    ]
  }.freeze
  
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
    # 首先尝试从预设的分类图片中获取
    category_images = CATEGORY_IMAGES[category_name]
    if category_images && !category_images.empty?
      return category_images.sample
    end
    
    # 如果没有找到特定分类的图片，使用关键词搜索
    category_keywords = {
      'Power Tools' => 'power drill electric tool',
      'Hand Tools' => 'hammer wrench hand tool',
      'Accessories' => 'tool accessories bits',
      'Electric Tools' => 'electric power tools',
      'Workshop' => 'workshop garage tools'
    }
    
    keyword = category_keywords[category_name] || 'tools equipment'
    images = search_tool_images(keyword, 1)
    
    # 如果搜索失败，返回随机工具图片
    images.first || get_random_tool_image
  end
  
  def self.get_random_tool_image
    DEFAULT_TOOL_IMAGES.sample
  end
  
  # 获取英雄横幅图片
  def self.get_hero_banner_image
    hero_images = [
      'https://images.unsplash.com/photo-1504328345606-18bbc8c9d7d1?w=1200&h=600&fit=crop',
      'https://images.unsplash.com/photo-1581244277943-fe4a9c777189?w=1200&h=600&fit=crop',
      'https://images.unsplash.com/photo-1613040809024-b4ef7ba99bc3?w=1200&h=600&fit=crop',
      'https://images.unsplash.com/photo-1572981779307-38b8cabb2407?w=1200&h=600&fit=crop'
    ]
    hero_images.sample
  end
  
  # 获取产品占位图片
  def self.get_product_placeholder_image
    'https://images.unsplash.com/photo-1581244277943-fe4a9c777189?w=300&h=300&fit=crop'
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
