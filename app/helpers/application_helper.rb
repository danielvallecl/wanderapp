module ApplicationHelper

  def gravatar_for(user, options ={size: 80, default: 'mm'})
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    default = options[:default]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}&d=#{default}"
    image_tag(gravatar_url, alt: user.username, class: "rounded-circle")
  end



end
