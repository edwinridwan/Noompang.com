module UsersHelper

  # Returns the Gravatar (http://gravatar.com/) for the given user.
  def gravatar_for(user)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: user.email, class: "gravatar")
  end

  def user_icon_for(user)
    if (!user.image_url.blank?)
      image_tag(user.image_url, alt: user.first_name, class: "user_icon", size: "20x20")
    end
  end

end
