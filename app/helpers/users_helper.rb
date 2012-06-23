module UsersHelper

  def user_icon_for(user)
    if (user && !user.image_url.blank?)
      image_tag(user.image_url, alt: user.first_name, class: "user_icon", size: "20x20")
    end
  end

  def user_image_for(user, height, width)
    if (user && !user.image_url.blank?)
      image_tag(user.image_url, :height => height, :width => width)
    end
  end

  def has_profile_picture(user)
    !user.image_url.blank?
  end

  def get_user_balance(user)
    "S$" + user.balance.to_s
  end

end
