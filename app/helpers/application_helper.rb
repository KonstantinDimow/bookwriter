module ApplicationHelper

  def user_books
    current_user.books
  end

  def datums_format(datum)
    d = Date.new(datum)
    d.strftime('%Y%m%d')

  end
end
