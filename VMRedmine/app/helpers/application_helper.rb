module ApplicationHelper
  
  def render_flash_messages
      s = ''
      puts "flash messages"
      flash.each do |k,v|
        s << content_tag('div', v, :class => "flash #{k}")
      end
      s
  end

end
