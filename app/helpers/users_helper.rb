module UsersHelper
  def print_full_name
    return "Anonymous" unless current_user.first_name || current_user.last_name
      
    "#{current_user.first_name} #{current_user.last_name}"
  end
end
