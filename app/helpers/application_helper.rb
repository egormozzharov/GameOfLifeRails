module ApplicationHelper
    def nav_bar_theme
        # binding.pry
        if user_signed_in?
            if current_user.theme_color == 'light'
                'navbar-inverse'
            end
        end
    end
end
