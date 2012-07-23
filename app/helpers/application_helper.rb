module ApplicationHelper

   # Returns the full title on a per-page basis.
   def full_title(page_title)
      base_title = "Noompang.com"
      if page_title.empty?
         base_title
      else
         "#{base_title} | #{page_title}"
      end
   end

  # Returns origin URL of current request
  def get_current_url
    'http://#{request.host}:#{request.port+request.fullpath}'
  end

end
