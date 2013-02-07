module ApplicationHelper
  def title(*parts)
      unless parts.empty?
        content_for :title do
          (parts << "Time Study").join(" | ")
        end
      end
  end

  def admins_only(&block)
  	concat(block.call) if current_user.try(:admin?)
  end
end
