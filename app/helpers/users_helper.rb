module UsersHelper
  def print_full_name(user)
    return "Anonymous" unless user.first_name || user.last_name
      
    "#{user.first_name} #{user.last_name}"
  end
end
