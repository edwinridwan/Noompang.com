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

  def get_rating(user)
    if user.total_votes > 0
      rating = user.total_score / user.total_votes.to_f
      return "Score: " + rating.to_s + " (" + pluralize(user.total_votes, 'vote') + ")"
    else
      return "You have not received any votes."
    end
  end

  def get_user_name(user_id)
    user = User.find(user_id)
    user.first_name + " " + user.last_name
  end

  def get_user_country(user)
    location = user.location
    index = location.index(',')
    if index
      location.slice(index + 1, location.length).strip!
    else
      ""
    end
  end

end
